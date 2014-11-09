import sys
import argparse

def colonyMaintenance(basetax):
    cost_per_year = 24 + (basetax / 2.0)
    return cost_per_year

def computeMaintenanceCostMultiplier(colonists, nth_colony):
    temp = max(nth_colony - colonists, 0)
    temp = temp*temp
    return 1 + temp

def optimize(basetaxes, colonists, multipliers):

    counter = 0
    total_cost = 0.0
    basetaxes.sort(reverse=True)
    for c in basetaxes:
        cost_for_colony = colonyMaintenance(c)
        multiplied_cost = cost_for_colony * multipliers[counter]
        total_cost = total_cost + multiplied_cost
        print("(optimized) Base tax: " + str(c) + ", Base cost: " + str(cost_for_colony) + ", Multiplier: " + str(multipliers[counter]) + ", Total cost: " + str(multiplied_cost))
        counter = counter + 1

    print("Optimized total cost per year: " + str(total_cost) + " and per month: " + str(total_cost/12.0))

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Compute EU4 colonization costs")
    parser.add_argument('-c', '--colonists', type=int, dest='colonists', help="The total number of colonists you currently have", required=True)
    parser.add_argument('-b', '--basetaxes', type=int, dest='base_taxes', nargs='+', help="A full list of all your colonies' basetaxes", required=True)

    args = parser.parse_args()

    colonists = int(args.colonists)
    base_tax_list = args.base_taxes
    num_of_colonies = len(base_tax_list)
    maintenance_costs = dict()
    
    list_of_multipliers = []
    for i in range(0, num_of_colonies):
        maintenanceMultiplier = computeMaintenanceCostMultiplier(colonists, i+1)
        list_of_multipliers.append(maintenanceMultiplier)

    counter = 0
    total_cost = 0
    for c in base_tax_list:
        cost_for_colony = colonyMaintenance(c)
        multiplied_cost = cost_for_colony * list_of_multipliers[counter]
        total_cost = total_cost + multiplied_cost
        print("Base tax: " + str(c) + ", Base cost: " + str(cost_for_colony) + ", Multiplier: " + str(list_of_multipliers[counter]) + ", Total cost per year: " + str(multiplied_cost))
        counter = counter + 1

    print("total yearly cost for " + str(num_of_colonies) + " colonies per year: " + str(total_cost) + " and per month: " + str(total_cost/12.0))

    optimized_cost = optimize(base_tax_list, colonists, list_of_multipliers)

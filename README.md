# DOL Equity
Scripts from [Department of Labor (DOL) Summer Data Challenge on Equity and Underserved Communities](https://www.dol.gov/agencies/oasp/evaluation/currentstudies/Department-of-Labor-Summer-Data-Challenge) (H-2A Oversight).

---
## [descriptives_and_visualizations.R](https://github.com/camguage/dol_equity/blob/main/descriptives_and_visualizations.R)
This script was created in collaboration with [@rebeccajohnson88](https://github.com/rebeccajohnson88) to create descriptives and visualizations of our data after cleaning and fuzzy matching, like the following:

![barplot_unique_emp_by_year-1](https://user-images.githubusercontent.com/71299048/145092106-327a87da-7162-4d43-9bea-9d85c4e8e23c.png)

For examples of visualizations that I created without collaboration, see my [data_viz repo](https://github.com/camguage/data_viz).

## [disclosure_diff_fields.py](https://github.com/camguage/dol_equity/blob/main/disclosure_diff_fields.py)
This script reads in DOL H-2A data for each year from 2014 to 2021 and finds the column names present in every year. It also finds which columns are added each year (i.e., are not present in the year prior).

## [fuzzy_matching.R](https://github.com/camguage/dol_equity/blob/main/fuzzy_matching.R)
At a high-level, this script probabilistically matches entity names in H-2A application data to those in DOL Wage and Hour Division (WHD) investigation data in order to see, out of the universe of H-2A employers, which have been investigated by the federal government. It does this in 6 steps:
1. **Define helper functions**: `find_status` and `clean_names` are later applied to the datasets to pull out relevant data and ease matching in fastLink. `generate_save_matches` and `merge_matches` are later called in the driver function for fuzzy matching
2. **Read in the data**: Read in DOL H-2A data and WHD investigation data
3. **Clean the data**: Apply the `find_status` and `clean_names` functions
4. **Deduplication**: Uses fastLink functionality to remove observations which have a repeated entry in the name column for both the H-2A application data and the WHD investigation data
5. **Fuzzy Matching Driver**: Define `fuzzy_matching` function which returns a fuzzy-matched dataset for a given state. Then isolate the relevant states, loop through them applying `fuzzy_matching` to get the datasets for each state, and row-bind them together
6. **Reduplication**: Carefully add back in the observations that were removed during deduplication, filling in the relevant columns if its copy had a match in the other dataset

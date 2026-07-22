import streamlit as st
import pandas as pd

# --- Config --- #
st.set_page_config(
    page_title='OSHS Capstone Dashboard',
    layout='wide',
    initial_sidebar_state='expanded',
)

# --- 2. Sidebar Settings --- #

with st.sidebar:
    st.header('Controls and Filtering')
    st.write('Filter Service Records and Regional Dispatches')

    st.date_input("date scheduled", [])

    regions = ["SoCal", "NorCal", "CenCal", "FTA", "NV", "Reno", "CO", "WA", "OR", "Undefined Region",
               "HI", "IN", "IL", "MO", "KS", "ID"]
    selected_regions = st.multiselect("Select Region(s)", options=regions, default=regions[1:3])

    services = ["Drug Screen", "Post Accident", "Injury Response", "Respiratory",
                "Blood Draw", "EOS", "CPR", "Training"]
    selected_services = st.selectbox("Select Service(s)", services)

    st.divider()
    st.info("UI Prototype: Backend Logic Needs to be created")

st.title("On-Site Health and Safety (OSHS Dashboard")
st.caption("Executive Overview and Analysis Across Key Service Goals")

tab1, tab2, tab3, tab4= st.tabs([
    "Goal 1: Operational Compliance (3rd Attempt)",
    "Goal 2: Technician Allocation",
    "Goal 3: Onsite One Adoption",
    "Goal 4: Client Retention"
])

with tab1:
    st.header("Operational Compliance")
    st.subheader("Technician Paperwork Errors & Follow-up Tracking")

    col1, col2 = st.columns([1, 2])

    with col1:
        st.write("**Top Paperwork Error Types**")
        error_counts = pd.DataFrame({
            "Error Type": ["Missing Signature", "Incomplete Form", "Wrong Date", "Illegible Field"],
            "Count": [42, 28, 15, 9]
        })
        st.bar_chart(error_counts.set_index("Error Type"))

    with col2:
        st.write("**Technicians Flagged for Follow-up**")
        tech_data = pd.DataFrame({
            "Technician Name": ["John Doe", "Jane Smith", "Gary Curb", "Jesse Lewallen"],
            "Assigned Region": ["So Cal", "Nor Cal", "WA", "So Cal"],
            "Total Visits": [120, 95, 80, 110],
            "Error Count": [12, 8, 5, 4],
            "Processing Status": ["Needs Follow-up", "Pending Admin", "Completed", "Completed"]
        })
        st.dataframe(tech_data)

with tab2:
    st.header("Technician Allocation")
    st.subheader("Regional Usage & Service Volume Density")

    col_a, col_b = st.columns(2)

    with col_a:
        st.write("**Service Visits by Region**")
        region_volume = pd.DataFrame({
            "Region": ["So Cal", "Nor Cal", "WA", "MO", "CO", "NV"],
            "Visits": [450, 320, 210, 150, 95, 60]
        })
        st.bar_chart(region_volume.set_index("Region"))

    with col_b:
        st.write("**Regional Breakdown Table**")
        st.dataframe(region_volume)

with tab3:
    st.header("Onsite One Platform Adoption")
    st.subheader("High-Volume Drug Screen Clients Not Yet On Platform")

    st.warning(
        "Target List: Companies below have high drug screen volume and should be prioritized" +
        " for portal onboarding.")

    onsite_one_targets = pd.DataFrame({
        "Company Name": ["Alpha Construction Inc", "Bravo Logistics LLC", "Delta Site Services", "Charlie Build Group"],
        "Drug Screens Performed": [48, 35, 22, 19],
        "Primary Region": ["So Cal", "Nor Cal", "WA", "MO"],
        "Onsite One Status": ["Not Onboarded", "Not Onboarded", "In Outreach", "Not Onboarded"]
    })
    st.dataframe(onsite_one_targets)

with tab4:
    st.header("Client Retention")
    st.subheader("Company Usage Frequency & History")

    retention_df = pd.DataFrame({
        "Company Name": ["Alpha Construction Inc", "Bravo Logistics LLC", "Charlie Build Group", "Delta Site Services",
                         "Echo Heavy Machinery"],
        "Total Jobsite Visits": [52, 38, 29, 14, 3],
        "First Service Date": ["2023-01-15", "2023-03-10", "2023-05-22", "2023-08-01", "2024-01-10"],
        "Last Service Date": ["2026-07-18", "2026-07-20", "2026-06-12", "2026-04-05", "2026-02-14"],
        "Retention Status": ["Active", "Active", "Active", "Low Activity", "Inactive"]
    })
    st.dataframe(retention_df)
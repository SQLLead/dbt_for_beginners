def model(dbt, session):
    df = dbt.ref("stg_web_logs").to_pandas()

    def categorize_time(ts):
        hour = ts.hour
        if hour < 12:
            return "morning"
        elif hour < 18:
            return "afternoon"
        else:
            return "evening"

    df["ACTIVITY_WINDOW"] = df["EVENT_TIMESTAMP"].apply(categorize_time)
    return session.create_dataframe(df)

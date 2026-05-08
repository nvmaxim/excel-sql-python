from _001_main import df_csv
import pandas as pd
import numpy as np
import sys
import io
from typing import Union, Optional

sys.setrecursionlimit(2000)
pd.set_option("display.max_columns", None)
pd.set_option("display.width", 1000)


def get_pandas_logic(df: pd.DataFrame) -> pd.DataFrame:
    result = (
        df.groupby("manager")
        .agg(total_revenue=("revenue", "sum"))
        .sort_values("total_revenue", ascending=False)
        .reset_index()
    )
    return result


def solve(data_input: Optional[pd.DataFrame]) -> None:
    if data_input is None:
        return
    if isinstance(data_input, pd.DataFrame):
        if data_input.empty:
            return
        result = get_pandas_logic(data_input)
        print("--- PANDAS RESULT ---")
        print(result.to_string(index=False, encoding="utf-8"))
        print("-" * 30)
        return
    return


def main():
    IS_LOCAL_TEST = True
    CURRENT_MODE = "PANDAS"  # OR ALGO

    if CURRENT_MODE == "ALGO":
        if IS_LOCAL_TEST:
            raw_input = ""
            input_stream = io.StringIO(raw_input).read()
        else:
            input_stream = sys.stdin.read()
        # solve(input_stream)
    elif CURRENT_MODE == "PANDAS":
        if IS_LOCAL_TEST:
            df = df_csv.copy()
            table_q1 = df[df["period"] == "Q1"].reset_index(drop=True)
            table_q2 = df[df["period"] == "Q2"].reset_index(drop=True)
            df = pd.concat([table_q1, table_q2], ignore_index=True)
        else:
            df = pd.read_csv(sys.stdin)
        solve(df)


if __name__ == "__main__":
    main()

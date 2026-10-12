<h1 align="center">🗄️ SQL Learning Notes</h1>

<p align="center">
Revision-ready MySQL notes and runnable queries, from <b>SELECT basics to window functions, stored programs, indexing, and transactions</b>, built on the Parks and Recreation sample database.
</p>

<hr>

<h2>📌 Project Overview</h2>

<p>
This repository is my personal <b>SQL revision handbook</b>. Each file covers one topic with working queries, short concept notes written in my own words, and comments on common errors, so I can quickly revise any topic before an interview or while working on a project.
</p>

<p>
The notes follow the course <i>Learn SQL Beginner to Advanced in Under 4 Hours</i> by Alex The Analyst (YouTube). Every example runs on one shared database, so the queries are easy to compare and revisit.
</p>

<ul>
<li>One topic per file, numbered in learning order</li>
<li>Queries are followed by notes on when and why to use them</li>
<li>Intentional errors are kept (commented) to remember what <i>not</i> to do</li>
<li>A single setup script rebuilds the practice database any time</li>
</ul>

<hr>

<h2>📚 Topics Covered</h2>

<table>
<tr><th>#</th><th>Topic</th><th>File</th></tr>
<tr><td>01</td><td>SELECT Statement</td><td><a href="sql/01_Select_Statement_Tutorial.sql">01_Select_Statement_Tutorial.sql</a></td></tr>
<tr><td>02</td><td>WHERE, LIKE, Logical Operators</td><td><a href="sql/02_Where_Clause_LIKE_Statement_Logical_Operators.sql">02_Where_Clause_LIKE_Statement_Logical_Operators.sql</a></td></tr>
<tr><td>03</td><td>GROUP BY, Aggregates, HAVING vs WHERE</td><td><a href="sql/03_Group_By_Aggregate_functions_Having_vs_Where.sql">03_Group_By_Aggregate_functions_Having_vs_Where.sql</a></td></tr>
<tr><td>04</td><td>LIMIT and Aliasing</td><td><a href="sql/04_Limit_Aliasing.sql">04_Limit_Aliasing.sql</a></td></tr>
<tr><td>05</td><td>Joins (Inner, Outer, Self)</td><td><a href="sql/05_Joins_Inner_Outer_Self.sql">05_Joins_Inner_Outer_Self.sql</a></td></tr>
<tr><td>06</td><td>Unions</td><td><a href="sql/06_Unions.sql">06_Unions.sql</a></td></tr>
<tr><td>07</td><td>String Functions</td><td><a href="sql/07_String_Functions.sql">07_String_Functions.sql</a></td></tr>
<tr><td>08</td><td>CASE Statements</td><td><a href="sql/08_Case_Statements.sql">08_Case_Statements.sql</a></td></tr>
<tr><td>09</td><td>Subqueries</td><td><a href="sql/09_Subqueries.sql">09_Subqueries.sql</a></td></tr>
<tr><td>10</td><td>Window Functions</td><td><a href="sql/10_Window_Functions.sql">10_Window_Functions.sql</a></td></tr>
<tr><td>11</td><td>CTEs</td><td><a href="sql/11_CTEs.sql">11_CTEs.sql</a></td></tr>
<tr><td>12</td><td>Temporary Tables</td><td><a href="sql/12_Temporary_Tables.sql">12_Temporary_Tables.sql</a></td></tr>
<tr><td>13</td><td>Stored Procedures</td><td><a href="sql/13_Stored_Procedures.sql">13_Stored_Procedures.sql</a></td></tr>
<tr><td>14</td><td>Triggers and Events</td><td><a href="sql/14_Triggers_and_Events.sql">14_Triggers_and_Events.sql</a></td></tr>
<tr><td>15</td><td>Functions (UDFs)</td><td><a href="sql/15_Functions.sql">15_Functions.sql</a></td></tr>
<tr><td>16</td><td>Views</td><td><a href="sql/16_Views.sql">16_Views.sql</a></td></tr>
<tr><td>17</td><td>Indexing and Query Optimization</td><td><a href="sql/17_Indexing_and_Query_Optimization.sql">17_Indexing_and_Query_Optimization.sql</a></td></tr>
<tr><td>18</td><td>Transactions and ACID Properties</td><td><a href="sql/18_Transactions_and_ACID_Properties.sql">18_Transactions_and_ACID_Properties.sql</a></td></tr>
<tr><td>19</td><td>Database Design, Keys and Constraints</td><td><i>coming soon</i></td></tr>
</table>

<hr>

<h2>🛠️ Tech Stack</h2>

<ul>
<li><b>Database:</b> MySQL 8.x</li>
<li><b>Client:</b> MySQL Workbench</li>
<li><b>Dataset:</b> Parks and Recreation (3 tables: <code>employee_demographics</code>, <code>employee_salary</code>, <code>parks_departments</code>)</li>
<li><b>Version Control:</b> Git and GitHub</li>
</ul>

<hr>

<h2>📂 Repository Structure</h2>

<pre>
sql_learning_notes/
│
├── README.md
├── .gitignore
│
├── setup/
│   └── 00_Parks_and_Rec_Create_db.sql        # Creates and fills the practice database
│
└── sql/
    ├── 01_Select_Statement_Tutorial.sql
    ├── 02_Where_Clause_LIKE_Statement_Logical_Operators.sql
    ├── ...
    └── 18_Transactions_and_ACID_Properties.sql
</pre>

<hr>

<h2>🚀 Getting Started</h2>

<h3>1️⃣ Clone the Repository</h3>
<pre>
git clone https://github.com/UmeshBhabad/sql_learning_notes.git
cd sql_learning_notes
</pre>

<h3>2️⃣ Install MySQL</h3>
<p>Install <b>MySQL Server</b> and <b>MySQL Workbench</b>, then connect to your local server.</p>

<h3>3️⃣ Create the Practice Database</h3>
<p>Open <code>setup/00_Parks_and_Rec_Create_db.sql</code> in Workbench and run the whole script. It drops and recreates the <code>Parks_and_Recreation</code> database, so <b>run it again any time to reset the data</b> after experiments with triggers, events, or transactions.</p>

<h3>4️⃣ Run a Topic</h3>
<p>Open any file from <code>sql/</code> and run the queries <b>one statement at a time</b> (<code>Ctrl + Enter</code> in Workbench) rather than the whole file, so each result can be compared with the notes.</p>

<hr>

<h2>⚠️ Notes Before Running</h2>

<ul>
<li>Some statements are <b>intentional errors</b> kept for learning. They are marked with comments like <code>-- Error: ...</code>.</li>
<li>Files <code>13</code> to <code>16</code> create procedures, triggers, events, functions, and views. Use <code>DROP</code> statements or rerun the setup script to clean up.</li>
<li>The scheduled <b>event</b> in file <code>14</code> deletes rows on a timer. Drop it after trying it out.</li>
<li>Files <code>14</code> and <code>18</code> insert and update rows, so rerun the setup script before repeating them.</li>
</ul>

<hr>

<h2>🧠 Quick Reference</h2>

<h3>SQL Logical Order of Execution</h3>
<pre>
FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
</pre>

<h3>Choosing the Right Tool</h3>
<ul>
<li><b>WHERE vs HAVING</b> — WHERE filters raw rows, HAVING filters groups after aggregation</li>
<li><b>RANK vs DENSE_RANK vs ROW_NUMBER</b> — ties skip numbers, ties keep numbers, ties never repeat</li>
<li><b>Subquery vs CTE</b> — same result, CTEs read top-to-bottom and can be chained</li>
<li><b>CTE vs Temp Table</b> — a CTE lives for one statement, a temp table lives for the session</li>
<li><b>Procedure vs Function</b> — procedures are run with <code>CALL</code>, functions return one value and work inside <code>SELECT</code></li>
<li><b>Trigger vs Event</b> — triggers fire on table changes, events fire on a schedule</li>
<li><b>ACID</b> — Atomicity, Consistency, Isolation, Durability</li>
</ul>

<hr>

<h2>🗺️ Roadmap</h2>

<ul>
<li>Add notes on Database Design, Keys, and Constraints (topic 19)</li>
<li>Link the SQL data cleaning and exploratory data analysis projects, kept in their own repositories</li>
<li>Add interview-style practice questions for each topic</li>
</ul>

<hr>

<h2>📖 Source</h2>

<p>
<i>Learn SQL Beginner to Advanced in Under 4 Hours</i> by <b>Alex The Analyst</b> (YouTube). Notes, structure, and extra examples are my own revision work.
</p>

<hr>

<h2>👨‍💻 Author</h2>

<p>
<b>Umesh Shivaji Bhabad</b><br>
📫 umeshbhabad9@gmail.com
</p>

<hr>

<h2>⭐ Support</h2>

<p>If these notes help you revise, consider giving the repository a ⭐ on GitHub!</p>
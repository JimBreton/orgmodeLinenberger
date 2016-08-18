# orgmodeLinenberger
Setup of org-mode to be  used with Linenberger


We are following here mostly the rules by Linenberger for Toodledo 
 - org-mode's SCHEDULED  date is used for start date.
 - org-mode's DEADLINE   is used as due date

 - SOC are given by items with start date <= today and tag SOC (org-mode syntax :SOC:) 
   This differes from Linenberger who uses top priority for it
 - Critical Now is prority A ([#A] and start date <= today
 - Target Now is priority B ([#B] and start date today
 - Opportunity Now is priority B and start date < today
 - Prority C is for someday/maybe items
 - over the horizon items have start date > today

We use org-capture to create tasks using C-c c t  
 using a template for a task with start date today and priority #B.
 It adds as well a time stamp and context information from where it was invoked.

Items from org-capture are added to ~/org/inbox.org rather than the main file, 
  so that one can quickly add tasks there and then go through them carefully before adding them to the 
  task list.

C-c a l  will show the agenda containing 
  SOC, Critical Now and Opportunity now.
  Target now are the items which are with start date today on top of Opportunity now.

The task list is in ~/org/tasks.org

Caveats:
- items with deadlines will be shown on the top of the list and might occur twice. (using deadline)
- If one adds dates org-mode agenda will create dated lines, which are not in accordance with 
  Lineneberger. The work around is to write for times 14::15 instead of 14:15

Task file
- items need a SCHEDULED date, and a priority, except for SOCs which need a tag :SOC: and a 
  SCHEDULED date


---
layout: post
title:  "Reflections on my First Development Job"
date:   2019-03-09 13:34:26 -0500
category: articles
tags:
  - work
  - retrospective
  - humor
---
<style>em { padding-left: 0.6em; padding-right: 0.4em; }</style>
December of 2018 marked the 20th anniversary for my being given money to tell computers what to do.  As I'm currently in the process of adjusting to a new role, I thought that it may be amusing to reminisce back on the first paying job as a developer that I had.

# Setting the Stage

One of my big goals going through college was to graduate without having any loans or other debts hanging over my head.  As someone paying my own way, that meant that I didn't have the luxury of exploring unpaid internships nor taking a low paying position to gain experience.  Luckily, the fast food job that I started in high school had a tuition reimbursement program for college students.  Unfortunately, that means that I had been working in the food service industry for roughly 8 years by the time I entered my last semester.  As you can imagine, I was ready for a change and chomping at the bit to move into my chosen field and start building my career.  By the mid-point of my last year, my tuition was fully paid and I excitedly began looking.

Given that I live in an area well outside of any urban center, my choices for a programming position were somewhat limited since I had to be close enough to make the drive to school for classes.  Remarkably, though I had tough luck searching, I somehow caught the attention of a local(ish) company who reached out about a role.

# The Fun Begins

The interview process was a bit odd and awkward.  I wasn't asked any technical questions nor, really, anything beyond whether I'd be willing to learn FoxPro and what I expected as a salary.  They weren't forthcoming with much about the company or product and came across as overly secretive.  I negotiated up from the $8 an hour that I was offered to a whopping $10 an hour. It was a slight pay cut from what I was making, but I was finally going to stop smelling like grease and spend my day writing code!

The company was small and split its efforts between doing custom installation of networks and developing a software package aimed at a niche market of managing a small business in a very specific industry _(details intentionally vague to avoid calling out the company)_.

# The Product

The management software, like most packages in the late 90s, was distributed on physical disks and accompanied by a very large manual.  A new version was created each year which customers could opt to upgrade to or not.  Support contracts and live call center access was sold as a separate add-on.  It was written in Visual FoxPro and shipped as a core unit with some optional add-ons.  The FoxPro runtime was packaged and each of the core and add-on modules were included as loose FoxPro files in the directory.  All-told, there was one directory level that contained a hundred or so FoxPro files of different types and then the files and structure for the FoxPro engine.

The software didn't change very much from year-to-year, typically.  A few bug fixes, some minor enhancements, and maybe a retired feature were typical for a yearly ship cycle.  The big change was an update to the bitmap that served as the background for the application and loading splash screen.  It always had the year featured prominently as part of the product name.  _(To be fair, this was back in the days of Windows 95, Windows 98, Office 95, and similar naming schemes.)_  Apparently, customers were willing to pay a solid 8-10 thousand dollars each year for an upgrade so long as the splash screen had a new year displayed and a new, thick manual came with the box.

# Here's Where it Gets Weird

The owner of the company, Mike, was the person that "interviewed" me.  He and a partner had started the company and wrote the original few years of the management software before Mike stepped away from hands-on development and hired others to do the work.  By the time I joined, Mike had been away from programming for a solid 10+ years, but his shadow loomed large.  I learned very quickly during my first few weeks that Mike still dictated many of the practices for development and that my initial impression of him being a bit odd was on point.  He had some interesting rules that we had to follow:

{:.with-paragraph}
- Development will always be done in a version of FoxPro that is at least 1 major version behind the current release. **_Why?_**  Mike had his environment crash once after installing the most recent version and didn't want to deal with "unstable software" that could cost him money.
- The names of all files will begin with a "w".**_Why?_**  Because Mike likes "w"s.
- Files were to be named in lowercase without underscores, dashes, or spaces in them and were not to exceed 8 characters, including the leading "w". **_Why?_**   Because Mike felt that Windows was a fad and required that DOS limitations were adhered to.
- All variable names were to begin with "M".**_Why?_**   To denote that it was a "memory variable."  Nobody was explain to me what other type of variable we were trying to distinguish from.  There was no such thing as a "file variable," for instance.  Everything was just a standard memory pointer.
- Variable names were to be in UPPERCASE only, must contain only letters and digits, and may not exceed 8 characters, including the leading "M." **_Why?_**   Because FoxPro 2.0 wasn't able to deal with longer names or special characters and Mike required that we be compatible with it in case we ever had to rollback.  For the record, FoxPro 2.0 was 7 years older than our version and ran on a different operating system than our product was sold on.
- We were not allowed to use arrays.**_Why?_**   Mike "didn't understand" arrays and, thus, didn't like them.
- We were not allowed to use SQL.**_Why?_**  Mike "didn't understand" SQL.  Instead, we were to open each table file that we needed, programmatically set a join between them in memory, and then linearly scan them and copy over the information that we were trying to retrieve.

I suspect that there were more quirks, but those are the ones that I can still recall.  My final memory is that, after arguing that using an array was necessary to implement whatever first task I was assigned, I was banished to being a networking cable pull assistant for the next two weeks as "a time to reflect on the importance of following standards."

# Well, That was Fast

Shortly into my tenure, one of my college professors approached me with an opportunity that he had been kind enough to recommend me for.  I was offered double what I was making to take a role working on technology that wasn't in danger of being obsolete, Visual Basic - quite a hot technology at the time.

Thus ended my time with Mike's company.  It may have only been 3 months, but it left quite an impression.
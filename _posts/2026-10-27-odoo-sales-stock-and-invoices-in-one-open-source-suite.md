---
layout: post
title: "Odoo: Sales, Stock and Invoices in One Open Source Suite"
date: 2026-10-27
tags:
  - self-hosting
  - open-source
  - business
author: Taylor
description: "One open source suite can run a small company's sales, stock, invoicing and website, and you can start with a single app and add the others later."
---

One open source suite can run a small company's sales, stock, invoicing and website, and you can start with a single app and add the others later.

## TL;DR

[Odoo](https://github.com/odoo/odoo) is a suite of web-based open source business apps (CRM, eCommerce, warehouse, accounting, point of sale and more) for small and mid-sized companies tired of copying data between separate tools. Each app works on its own, and the ones you install together behave as one ERP. You can try it in a free hosted start or run it yourself on your own infrastructure.

## Five tools, one person copying between them

A lot of small companies run like this: leads live in one tool, invoices come from another, stock is a spreadsheet, and the website is somewhere else entirely. Somebody on the team spends part of every week moving the same customer and order data from one place to the next, and fixing it where the copies disagree.

If you are the person asked to fix that, replacing everything in one go is a hard sell. Odoo is built for the gentler route: pick the one problem that hurts most, install the app for it, and add the rest when you are ready.

## What using it is like

Odoo is a web application, so what you and your colleagues open is a browser tab. Inside it, each business job is its own app.

### Selling

The [CRM app](https://www.odoo.com/page/crm) is where you keep track of sales leads and customers. If you also want to sell online, the [Website Builder](https://www.odoo.com/app/website) is how you put the company website together, and the [eCommerce app](https://www.odoo.com/app/ecommerce) is how that website sells.

For a physical shop, [Point of Sale](https://www.odoo.com/app/point-of-sale-shop) runs the counter.

### Stock and projects

[Warehouse Management](https://www.odoo.com/app/inventory) keeps track of your stock, which is the job the spreadsheet was doing. [Project Management](https://www.odoo.com/app/project) is where you plan the work. [Manufacturing](https://www.odoo.com/app/manufacturing) is there if you make what you sell.

### Money and people

[Billing & Accounting](https://www.odoo.com/app/accounting) handles invoices and the books. The [Human Resources app](https://www.odoo.com/app/employees) manages staff, and [Marketing](https://www.odoo.com/app/social-marketing) covers the campaigns. The list goes on past these; the full catalogue is on the [project's homepage](https://www.odoo.com).

The point of having them in one suite is that they integrate. Install several apps and they work together as a full ERP, so an order taken in the shop or on the website is data the other apps can use, not something to retype.

## Why it is worth a look

- **You choose how much of it to use.** The apps run as stand-alone applications, or several together as an ERP. Starting with just the CRM, or just invoicing, is a normal way in.
- **The data is in PostgreSQL.** The project says there is no proprietary data format, and that you can host Odoo on its infrastructure or on premise.
- **There is a large app store.** The project says its community app store holds 40k+ apps, which is where you look when the standard apps do not quite fit.

## Running it

The quickest way to see it is the hosted start the project offers on its homepage. The project says it is free and needs no credit card.

To run it yourself, the project points to the [setup instructions](https://www.odoo.com/documentation/master/administration/install/install.html) in its documentation for a standard installation. Odoo keeps its data in PostgreSQL, so that is the database you will be running next to it. Follow the setup instructions for the rest; they are the maintainers' own steps for a standard install.

## Where it falls short

Odoo comes in two editions. Community is open source and free. Enterprise adds extra apps, infrastructure and professional services. Which apps belong only to Enterprise is something to find out before you build a plan around a particular app, so look at the edition comparison on the [homepage](https://www.odoo.com) first.

Also, a suite this broad is a lot of surface. Installing one app at a time is the sensible way to keep it manageable, and it is the way the suite is designed to be adopted.

## What to do next

Start with the free hosted start on [odoo.com](https://www.odoo.com) and click through the app that matches your biggest headache. When you are ready to host it yourself, follow the [setup instructions](https://www.odoo.com/documentation/master/administration/install/install.html). To learn the software, the project recommends the [Odoo eLearning](https://www.odoo.com/slides) or its business game, [Scale-up](https://www.odoo.com/page/scale-up-business-game). Developers can begin with the [developer tutorials](https://www.odoo.com/documentation/master/developer/howtos.html). The code is at [github.com/odoo/odoo](https://github.com/odoo/odoo).

*An overview based on the project's own documentation, not a hands-on review.*

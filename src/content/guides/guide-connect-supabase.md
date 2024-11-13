---
title: Set up Supabase with Netlify template
---

In this guide we’re going to install and configure the Supabase Netlify extension, create Supabase project and fill the database with data.

## Set up Supabase database

1. Create Supabase account at [Supabase.com](https://supabase.com).
2. After signing up to your Supabase account, click New project from your dashboard. Select your organization, give the project a name, generate a new password for the database, and select the us-east-1 region.

## Create the frameworks table

Once the database is provisioned, we can create the **frameworks** table. From your project dashboard, open the SQL editor.

![Create the frameworks table](/images/guides/supabase-netlify-sql-editor.png)

Run the following commands in the SQL editor to create the **frameworks** table.

```sql
CREATE TABLE frameworks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  description TEXT NOT NULL,
  logo TEXT NOT NULL,
  likes INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

## Add data

Next, let’s add some starter data to the **frameworks** table. From the Table Editor in Supabase (1), choose the **frameworks** table from the list (2) and then select **Insert > Import** data from CSV (3).

![Create the frameworks table](/images/guides/supabase-netlify-import-csv.png)

Paste the following data:

```sql
name,url,logo,likes,description
Astro,https://astro.build/,astro.svg,0,"Astro is a fresh but familiar approach to building websites. Astro combines decades of proven performance best practices with the DX improvements of the component-oriented era."
Eleventy,https://svelte.dev/,eleventy.svg,0,"Eleventy (11ty) is a flexible, minimalist static site generator that builds fast, content-driven websites using multiple templating languages and a zero-client-JavaScript philosophy."
Gatsby,https://www.gatsbyjs.com/,gatsby.svg,0,"Gatsby.js is a React-based framework for building fast, SEO-friendly websites and applications with powerful data integration and static site generation capabilities."
Next,https://nextjs.org/,next.svg,0,"Next.js enables you to create high-quality web applications with the power of React components."
Nuxt,https://nuxt.com/,nuxt.svg,0,"Nuxt is an open source framework that makes web development intuitive and powerful. Create performant and production-grade full-stack web apps and websites with confidence."
Remix,https://remix.run/,remix.svg,0,"Remix is a React framework designed for server-side rendering (SSR). Is a full-stack web framework, allowing developers to build both backend and frontend within a single app."
Svelte,https://svelte.dev/,svelte.svg,0,"Svelte is a UI framework that uses a compiler to let you write breathtakingly concise components that do minimal work in the browser, using languages you already know — HTML, CSS and JavaScript."
```

This will give you a preview of the data that will be inserted into the database. Click **Import data** to add the data to the database.

## Install the Supabase Netlify extension

Now we can install the Supabase extension. In the Netlify UI, go to your team’s dashboard, navigate to **Extensions** and click on the Supabase extension. Click the install button to install the extension.

### Configure the Supabase extension

After the [extension](https://app.netlify.com/extensions/supabase) is installed, navigate to the Supabase template site that you deployed, and go to **Site configuration**. In the **General** settings, you will see a new **Supabase** section. Click **Connect** to connect your Netlify site to your Supabase account using OAuth.

![Configure the Supabase extension](/images/guides/supabase-netlify-connect-oauth.png)

Once you’ve completed this process, return to the Supabase section of your site configuration, and choose the project you just created in Supabase. And make sure to choose Astro for the framework since the template is built with Astro.

![Supabase Netlify extension configuration](/images/guides/supabase-netlify-extension-configuration.png)

## Deploy the site again

Now that the extension is configured, we can deploy the site again. Got to **Deploys** (1) and click the **Deploy site** (2) button to deploy the site. 

![Supabase Netlify extension configuration](/images/guides/deploy-button.png)

Once the build is complete, navigate to your production URL and you should see the **frameworks** that we just added to the database.

![Template with data](/images/guides/web-frameworks.png)
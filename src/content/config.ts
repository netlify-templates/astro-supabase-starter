import { defineCollection, z } from 'astro:content';

const guides = defineCollection({
    schema: z.object({
        title: z.string().optional(),
    })
});

export const collections = { guides };

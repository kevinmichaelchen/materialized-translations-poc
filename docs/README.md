# Materialize Benefits Presentation

This is a Slidev presentation showcasing the benefits of Materialize's Incremental View Maintenance Replicas (IVMRs).

## Getting Started

1. Install dependencies:
   ```bash
   pnpm install
   ```

2. Start the development server:
   ```bash
   pnpm dev
   ```

3. Visit <http://localhost:3030> to view the presentation

## Available Commands

- `pnpm dev` - Start development server with auto-reload  
- `pnpm build` - Build static SPA for deployment
- `pnpm export` - Export slides to PDF

## Deployment

### GitHub Pages
The project includes a GitHub Actions workflow that automatically builds and deploys the presentation to GitHub Pages on every push to the main branch.

1. Enable GitHub Pages in your repository settings:
   - Go to Settings → Pages
   - Select "Deploy from a GitHub Actions artifact" as the source
   
2. The slides will be available at: `https://<username>.github.io/<repository-name>/`

### Netlify
The project includes a `netlify.toml` configuration for easy deployment.

### Vercel
A `vercel.json` configuration is also included for Vercel deployment.

### Static Export
Run `pnpm build` to create a static site in the `dist/` directory that can be hosted anywhere.

## Presentation Content

The presentation covers:
- The database read performance challenge
- Traditional approaches and their trade-offs
- How IVMRs work with Differential Dataflow
- Real-world use cases and performance benefits
- Success stories (90% cost reduction)
- Technical implementation details
- Comparison with traditional solutions

Based on the blog post: [Materialize IVM Database Replica](https://materialize.com/blog/ivm-database-replica/)

Learn more about Slidev at the [documentation](https://sli.dev/).

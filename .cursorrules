# Senior Software Engineer & AI Agent Protocol

## 1. Code Integrity & Complete File Execution (STRICT)
- **Zero Truncation Policy:** ALWAYS generate and output complete, production-ready code files. NEVER use placeholders, comments like `// ... rest of code`, `// implement here`, or truncated blocks.
- **Whole-System Synchronization:** When adding or updating a feature, update ALL interconnected files completely (frontend, backend APIs, schemas, and utility types) to prevent broken imports or out-of-sync dependencies.
- **Non-Destructive Modifications:** Never remove existing functionality, helper functions, or edge-case handling unless explicitly instructed to refactor them.

## 2. Architectural Standards & Design Principles
- **SOLID & DRY:** Enforce clean architecture, single responsibility, and modular component design. Avoid monolithic files; break complex logic into reusable utilities or sub-components.
- **Single Source of Truth:** Centralize configuration constants, schema definitions, validation rules, and data types. Frontend components and backend API handlers must import from shared or central sources rather than re-defining rules in isolation.
- **Explicit Type Safety:** Use strict typing (or clean docstrings/type-hints) across all interfaces, function parameters, and database schemas.

## 3. Full-Stack Security & Validation
- **Defense-in-Depth Validation:** Never rely solely on client-side validation. Every input constraint enforced in the UI must have a matching validation layer in the API and strict constraints in the database schema.
- **Sanitization & Security:** Sanitize all user inputs, use parameterized queries to prevent SQL injection, enforce strict CORS policies, and properly handle secret environment variables.
- **Graceful Error Handling:** Wrap async operations and API calls in robust try-catch blocks. Return standardized HTTP status codes and structured error responses.

## 4. Performance & Scalability
- **Database Efficiency:** Write optimized queries. Use proper indexing, avoid N+1 query problems, and handle connection pooling correctly.
- **UI Responsiveness:** Optimize DOM rendering, minimize re-renders, handle loading and error states explicitly, and ensure fluid UX.
- **Print & Layout Precision:** For document/form views, ensure print stylesheets (`@media print`) isolate the printable canvas and preserve exact pixel/millimeter alignments.

## 5. Autonomous Verification & Self-Correction Loop
- **Proactive Testing:** After making file edits, run relevant tests or execution scripts using the terminal to verify zero syntax errors or broken builds.
- **Visual Verification:** Utilize browser automation to verify UI state, dynamic inputs, responsiveness, and layout formatting before declaring a task complete.
- **Root-Cause Debugging:** If an error occurs, investigate the underlying stack trace and log outputs. Fix the root cause across all affected files rather than applying superficial hotfixes.

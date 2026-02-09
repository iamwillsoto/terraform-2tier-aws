# Terraform-Managed Highly Available 2-Tier Web Architecture on AWS

## Overview
This implementation delivers a **highly available two-tier web architecture** on AWS using **Terraform Cloud** for remote execution, state management, and controlled change delivery.  
A WordPress application is served behind an **internet-facing Application Load Balancer**, backed by a **private Amazon RDS MySQL database**, with strict network isolation and security enforcement.

All infrastructure is modular, reproducible, and validated through runtime behavior rather than configuration assumptions.

---

## Business Problem
Web applications that handle dynamic content must remain available during traffic fluctuations while protecting sensitive data and minimizing operational risk.

Common failure patterns include:
- Publicly exposed databases
- Single-instance application tiers
- Manually provisioned infrastructure
- Databases coupled directly to application hosts

These patterns increase blast radius, complicate recovery, and prevent horizontal scaling.

---

## Solution
This architecture enforces availability, security, and scalability at the **platform layer**:

- Ingress is centralized through an Application Load Balancer
- Compute is distributed across Availability Zones
- Stateful data is isolated in private subnets
- Access is enforced using security-group-to-security-group trust
- Provisioning and changes are executed via Terraform Cloud with remote state

The result is a predictable, recoverable system that exposes only what is required.

---

## Architecture Summary

### Network
- Custom VPC
- Two public subnets (ALB and web tier)
- Two private subnets (RDS)
- Internet Gateway for ingress
- NAT Gateway for controlled egress
- Explicit public and private route tables

### Application Tier
- Two EC2 instances running WordPress
- Deployed across separate Availability Zones
- Bootstrapped via user-data
- Stateless design with shared database backend

### Data Tier
- Amazon RDS MySQL (micro instance)
- Private subnet placement
- Not publicly accessible
- Database access restricted to web tier only

### Load Balancing
- Internet-facing Application Load Balancer
- Instance-based target group
- Health checks enforcing runtime correctness
- Verified request distribution and recovery

---

## Security Model
- **ALB Security Group**
  - Allows HTTP (80) from the internet
- **Web Tier Security Group**
  - Allows HTTP (80) from ALB only
- **RDS Security Group**
  - Allows MySQL (3306) only from the web tier

No CIDR-based database access is permitted.  
The database is unreachable from the internet and from non-application resources.

---

## Infrastructure as Code & Delivery
- Terraform modules used for:
  - Network
  - Security
  - Compute
  - Load balancing
  - RDS
- Terraform Cloud provides:
  - Remote state storage
  - Plan and apply execution
  - Change auditing

No local state or credentials are committed to source control.

---

## Database Design Rationale
Placing the database on application hosts tightly couples state to compute and prevents horizontal scaling.

Using RDS enables:
- Shared state across multiple application instances
- Simplified scaling and recovery
- Reduced operational overhead
- Clear separation between compute and data layers

---

## Validation Evidence
Correctness is demonstrated through execution artifacts:
- All ALB targets report healthy
- WordPress is accessible only through the ALB
- Database connectivity verified through application runtime
- Terraform Cloud runs show successful plan and apply
- Security group rules confirm strict tier isolation

---

## Key Outcomes
- Highly available web tier across multiple Availability Zones
- Private, secured database layer
- Enforced network and security boundaries
- Modular, reusable Terraform codebase
- Platform-managed provisioning and recovery

---

## Repository Structure
```bash
infra/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── modules/
│ ├── network/
│ ├── security/
│ ├── compute/
│ ├── alb/
│ └── rds/
└── userdata/
└── wordpress.sh
```


---

## Closing Perspective
This implementation reflects a standard cloud architecture pattern for operating web workloads under variable demand: centralized ingress, distributed compute, private data, and declarative infrastructure management.

The value lies in enforced correctness, isolation, and repeatability rather than the application itself.


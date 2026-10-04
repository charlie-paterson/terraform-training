import { BrowserRouter, Link, Route, Routes, useLocation } from "react-router-dom";
import "./App.css";

type Service = {
  name: string;
  type: string;
  status: string;
  port: string;
  description: string;
};

const services: Service[] = [
  {
    name: "PostgreSQL",
    type: "Database",
    status: "Running",
    port: "5432",
    description: "Relational database service",
  },
  {
    name: "Redis",
    type: "Cache",
    status: "Running",
    port: "6379",
    description: "In-memory data store",
  },
  {
    name: "MinIO",
    type: "Object Storage",
    status: "Running",
    port: "9000",
    description: "S3-compatible object storage",
  },
];

const navSections = [
  {
    title: "Cloud Services",
    items: [
      { label: "Dashboard", path: "/" },
      { label: "Databases", path: "/databases" },
      { label: "Redis", path: "/redis" },
      { label: "Object Storage", path: "/storage" },
      { label: "Secrets", path: "/secrets" },
    ],
  },
  {
    title: "Observability",
    items: [
      { label: "Monitoring", path: "/monitoring" },
      { label: "Metrics", path: "/metrics" },
    ],
  },
  {
    title: "Infrastructure",
    items: [
      { label: "Containers", path: "/containers" },
      { label: "Networks", path: "/networks" },
      { label: "Volumes", path: "/volumes" },
    ],
  },
];

function Sidebar() {
  const location = useLocation();

  return (
    <aside className="sidebar">
      <div className="brand">
        <div className="brand-icon">☁</div>
        <div>
          <div className="brand-name">LocalCloud</div>
          <div className="brand-subtitle">Local Infrastructure</div>
        </div>
      </div>

      <nav className="sidebar-nav">
        {navSections.map((section) => (
          <div className="nav-section" key={section.title}>
            <div className="nav-section-title">{section.title}</div>

            {section.items.map((item) => {
              const active =
                item.path === "/"
                  ? location.pathname === "/"
                  : location.pathname.startsWith(item.path);

              return (
                <Link
                  key={item.path}
                  to={item.path}
                  className={`nav-item ${active ? "active" : ""}`}
                >
                  <span className="nav-icon">
                    {getIcon(item.label)}
                  </span>
                  <span>{item.label}</span>
                </Link>
              );
            })}
          </div>
        ))}
      </nav>

      <div className="sidebar-footer">
        <div className="environment">
          <span className="status-dot" />
          <div>
            <div className="environment-title">Local Development</div>
            <div className="environment-subtitle">Docker Engine</div>
          </div>
        </div>
      </div>
    </aside>
  );
}

function getIcon(label: string) {
  const icons: Record<string, string> = {
    Dashboard: "▦",
    Databases: "◉",
    Redis: "◆",
    "Object Storage": "▣",
    Secrets: "◇",
    Monitoring: "◒",
    Metrics: "⌁",
    Containers: "□",
    Networks: "⌘",
    Volumes: "▤",
  };

  return icons[label] ?? "•";
}

function Topbar() {
  const location = useLocation();

  const pageName =
    location.pathname === "/"
      ? "Dashboard"
      : location.pathname
          .split("/")
          .filter(Boolean)[0]
          .replace("-", " ")
          .replace(/\b\w/g, (letter) => letter.toUpperCase());

  return (
    <header className="topbar">
      <div className="breadcrumb">
        <span>LocalCloud</span>
        <span className="breadcrumb-separator">/</span>
        <strong>{pageName}</strong>
      </div>

      <div className="topbar-actions">
        <button className="icon-button" title="Notifications">
          ♢
        </button>

        <div className="user-menu">
          <div className="avatar">A</div>
          <div>
            <div className="user-name">Administrator</div>
            <div className="user-role">Local Environment</div>
          </div>
          <span className="chevron">⌄</span>
        </div>
      </div>
    </header>
  );
}

function Dashboard() {
  return (
    <PageLayout
      title="Dashboard"
      description="Overview of your local cloud environment."
    >
      <div className="stats-grid">
        <StatCard label="Services" value="3" detail="Configured" icon="☁" />
        <StatCard label="Running" value="3" detail="Healthy services" icon="✓" />
        <StatCard label="Databases" value="1" detail="PostgreSQL" icon="◉" />
        <StatCard label="Storage" value="1" detail="MinIO" icon="▣" />
      </div>

      <div className="section-header">
        <div>
          <h2>Services</h2>
          <p>Your local cloud services</p>
        </div>

        <Link className="secondary-button" to="/containers">
          View containers
        </Link>
      </div>

      <div className="service-grid">
        {services.map((service) => (
          <ServiceCard key={service.name} service={service} />
        ))}
      </div>

      <div className="section-header infrastructure-header">
        <div>
          <h2>Infrastructure</h2>
          <p>How LocalCloud is running</p>
        </div>
      </div>

      <div className="infrastructure-card">
        <InfrastructureItem label="Environment" value="Local Development" />
        <InfrastructureItem label="Provisioning" value="Terraform" />
        <InfrastructureItem label="Runtime" value="Docker" />
        <InfrastructureItem label="Deployment" value="GitHub Actions" />
      </div>
    </PageLayout>
  );
}

function ServiceCard({ service }: { service: Service }) {
  const path =
    service.name === "PostgreSQL"
      ? "/databases"
      : service.name === "Redis"
        ? "/redis"
        : "/storage";

  return (
    <Link to={path} className="service-card">
      <div className="service-card-header">
        <div className="service-icon">{getIcon(service.name)}</div>

        <span className="status-badge">
          <span className="status-dot" />
          {service.status}
        </span>
      </div>

      <h3>{service.name}</h3>
      <p>{service.description}</p>

      <div className="service-meta">
        <span>{service.type}</span>
        <span>Port {service.port}</span>
      </div>
    </Link>
  );
}

function StatCard({
  label,
  value,
  detail,
  icon,
}: {
  label: string;
  value: string;
  detail: string;
  icon: string;
}) {
  return (
    <div className="stat-card">
      <div className="stat-icon">{icon}</div>
      <div>
        <div className="stat-label">{label}</div>
        <div className="stat-value">{value}</div>
        <div className="stat-detail">{detail}</div>
      </div>
    </div>
  );
}

function InfrastructureItem({
  label,
  value,
}: {
  label: string;
  value: string;
}) {
  return (
    <div className="infrastructure-item">
      <span>{label}</span>
      <strong>{value}</strong>
    </div>
  );
}

function PageLayout({
  title,
  description,
  children,
}: {
  title: string;
  description: string;
  children: React.ReactNode;
}) {
  return (
    <main className="main-content">
      <div className="page-header">
        <div>
          <h1>{title}</h1>
          <p>{description}</p>
        </div>
      </div>

      {children}
    </main>
  );
}

function ResourcePage({
  title,
  description,
  resource,
  items,
}: {
  title: string;
  description: string;
  resource: string;
  items: string[];
}) {
  return (
    <PageLayout title={title} description={description}>
      <div className="resource-toolbar">
        <div className="resource-count">
          <strong>{items.length}</strong> {resource}
        </div>

        <button className="primary-button">Create {resource}</button>
      </div>

      <div className="resource-table">
        <div className="table-header">
          <span>Name</span>
          <span>Status</span>
          <span>Actions</span>
        </div>

        {items.map((item) => (
          <div className="table-row" key={item}>
            <strong>{item}</strong>

            <span className="status-badge">
              <span className="status-dot" />
              Running
            </span>

            <button className="table-action">View</button>
          </div>
        ))}
      </div>
    </PageLayout>
  );
}

function Databases() {
  return (
    <ResourcePage
      title="Databases"
      description="Manage your local database services."
      resource="databases"
      items={["local-cloud-postgres"]}
    />
  );
}

function Redis() {
  return (
    <ResourcePage
      title="Redis"
      description="Manage Redis instances and caches."
      resource="Redis instances"
      items={["local-cloud-redis"]}
    />
  );
}

function Storage() {
  return (
    <ResourcePage
      title="Object Storage"
      description="Manage S3-compatible object storage."
      resource="storage services"
      items={["local-cloud-minio"]}
    />
  );
}

function Secrets() {
  return (
    <ResourcePage
      title="Secrets"
      description="Manage application secrets and credentials."
      resource="secrets"
      items={["POSTGRES_PASSWORD", "MINIO_PASSWORD"]}
    />
  );
}

function Monitoring() {
  return (
    <ResourcePage
      title="Monitoring"
      description="Monitor the health of your local cloud."
      resource="services"
      items={["PostgreSQL", "Redis", "MinIO"]}
    />
  );
}

function Metrics() {
  return (
    <PageLayout
      title="Metrics"
      description="Performance metrics for your local environment."
    >
      <div className="empty-state">
        <div className="empty-state-icon">⌁</div>
        <h2>Metrics coming next</h2>
        <p>
          This page will connect to Prometheus once the observability stack is
          deployed.
        </p>
      </div>
    </PageLayout>
  );
}

function Containers() {
  return (
    <ResourcePage
      title="Containers"
      description="Docker containers managed by LocalCloud."
      resource="containers"
      items={[
        "local-cloud-postgres",
        "local-cloud-redis",
        "local-cloud-minio",
      ]}
    />
  );
}

function Networks() {
  return (
    <ResourcePage
      title="Networks"
      description="Docker networks used by LocalCloud."
      resource="networks"
      items={["local-cloud"]}
    />
  );
}

function Volumes() {
  return (
    <ResourcePage
      title="Volumes"
      description="Persistent Docker volumes used by LocalCloud."
      resource="volumes"
      items={[
        "local-cloud-postgres-data",
        "local-cloud-redis-data",
        "local-cloud-minio-data",
      ]}
    />
  );
}

function NotFound() {
  return (
    <PageLayout
      title="Page not found"
      description="The requested LocalCloud resource does not exist."
    >
      <div className="empty-state">
        <div className="empty-state-icon">?</div>
        <h2>404</h2>
        <p>The page you're looking for doesn't exist.</p>
        <Link to="/" className="primary-button">
          Return to dashboard
        </Link>
      </div>
    </PageLayout>
  );
}

function AppShell() {
  return (
    <div className="app">
      <Sidebar />

      <div className="content">
        <Topbar />

        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/databases" element={<Databases />} />
          <Route path="/redis" element={<Redis />} />
          <Route path="/storage" element={<Storage />} />
          <Route path="/secrets" element={<Secrets />} />
          <Route path="/monitoring" element={<Monitoring />} />
          <Route path="/metrics" element={<Metrics />} />
          <Route path="/containers" element={<Containers />} />
          <Route path="/networks" element={<Networks />} />
          <Route path="/volumes" element={<Volumes />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </div>
    </div>
  );
}

function App() {
  return (
    <BrowserRouter>
      <AppShell />
    </BrowserRouter>
  );
}

export default App;

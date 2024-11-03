/****** Object:  Table [dbo].[notificacao]    Script Date: 25/05/2024 15:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[notificacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[notificacao](
	[id_notificacao] [uniqueidentifier] NOT NULL,
	[data] [datetime] NOT NULL,
	[mensagem] [nvarchar](50) NOT NULL,
	[id_dispositivo] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_notificacao_1] PRIMARY KEY CLUSTERED 
(
	[id_notificacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pedido]    Script Date: 25/05/2024 15:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pedido]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pedido](
	[id_pedido] [uniqueidentifier] NOT NULL,
	[data] [datetime] NOT NULL,
	[id_dispositivo] [uniqueidentifier] NOT NULL,
	[id_cliente] [uniqueidentifier] NULL,
	[status] [nvarchar](50) NOT NULL,
	[data_status_pedido] [datetime] NOT NULL,
	[status_pagamento] [nvarchar(50)] NOT NULL,
	[data_status_pagamento] [datetime] NOT NULL,
 CONSTRAINT [PK_pedido] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_pedido_data]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pedido] ADD  CONSTRAINT [DF_pedido_data]  DEFAULT (getdate()) FOR [data]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_pedido_data_status_pedido]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pedido] ADD  CONSTRAINT [DF_pedido_data_status_pedido]  DEFAULT (getdate()) FOR [data_status_pedido]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_pedido_data_status_pagamento]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pedido] ADD  CONSTRAINT [DF_pedido_data_status_pagamento]  DEFAULT (getdate()) FOR [data_status_pagamento]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_pedido_id_cliente')
BEGIN
    CREATE INDEX idx_pedido_id_cliente ON pedido (id_cliente);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_pedido_id_dispositivo')
BEGIN
    CREATE INDEX idx_pedido_id_dispositivo ON pedido (id_dispositivo);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_pedido_data')
BEGIN
    CREATE INDEX idx_pedido_data ON pedido ([data]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_pedido_status')
BEGIN
    CREATE INDEX idx_pedido_status ON pedido ([status]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_pedido_status_pagamento')
BEGIN
    CREATE INDEX idx_pedido_status_pagamento ON pedido (status_pagamento);
END
GO

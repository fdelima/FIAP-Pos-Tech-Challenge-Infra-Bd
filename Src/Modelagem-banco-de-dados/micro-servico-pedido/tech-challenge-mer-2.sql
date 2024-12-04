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
	[status_pagamento] [nvarchar](50) NOT NULL,
	[data_status_pagamento] [datetime] NOT NULL,
 CONSTRAINT [PK_pedido] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pedido_item]    Script Date: 25/05/2024 15:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pedido_item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pedido_item](
	[id_pedido_item] [uniqueidentifier] NOT NULL,
	[data] [datetime] NOT NULL,
	[id_pedido] [uniqueidentifier] NOT NULL,
	[id_produto] [uniqueidentifier] NOT NULL,
	[observacao] [nvarchar](50) NULL,
	[quantidade] [int] NOT NULL,
 CONSTRAINT [PK_pedido_item] PRIMARY KEY CLUSTERED 
(
	[id_pedido_item] ASC
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

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_pedido_item_data]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pedido_item] ADD  CONSTRAINT [DF_pedido_item_data]  DEFAULT (getdate()) FOR [data]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_pedido_item_quantidade]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pedido_item] ADD  CONSTRAINT [DF_pedido_item_quantidade]  DEFAULT ((1)) FOR [quantidade]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pedido_item_pedido]') AND parent_object_id = OBJECT_ID(N'[dbo].[pedido_item]'))
ALTER TABLE [dbo].[pedido_item]  WITH CHECK ADD  CONSTRAINT [FK_pedido_item_pedido] FOREIGN KEY([id_pedido])
REFERENCES [dbo].[pedido] ([id_pedido])
ON DELETE CASCADE
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pedido_item_pedido]') AND parent_object_id = OBJECT_ID(N'[dbo].[pedido_item]'))
ALTER TABLE [dbo].[pedido_item] CHECK CONSTRAINT [FK_pedido_item_pedido]
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

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_pedido_item_id_pedido')
BEGIN
    CREATE INDEX idx_pedido_item_id_pedido ON pedido_item (id_pedido);
END
GO

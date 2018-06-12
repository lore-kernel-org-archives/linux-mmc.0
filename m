From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 02/19] mmc: mmci: merge qcom dml feature into mmci dma
Date: Tue, 12 Jun 2018 15:14:23 +0200
Message-ID: <1528809280-31116-3-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch integrates qcom dml feature into mmci_dma file.
Qualcomm Data Mover lite/local is already a variant of mmci dmaengine.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/Makefile        |   1 -
 drivers/mmc/host/mmci.c          |   1 -
 drivers/mmc/host/mmci.h          |  35 ++++++++
 drivers/mmc/host/mmci_dma.c      | 135 ++++++++++++++++++++++++++++-
 drivers/mmc/host/mmci_qcom_dml.c | 177 ---------------------------------------
 drivers/mmc/host/mmci_qcom_dml.h |  31 -------
 6 files changed, 169 insertions(+), 211 deletions(-)
 delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
 delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index daecaa98..608a020 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -5,7 +5,6 @@
 
 obj-$(CONFIG_MMC_ARMMMCI) += armmmci.o
 armmmci-y := mmci.o mmci_dma.o
-armmmci-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8868be0..7a15afd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -43,7 +43,6 @@
 
 #include "mmci.h"
 #include "mmci_dma.h"
-#include "mmci_qcom_dml.h"
 
 #define DRIVER_NAME "mmci-pl18x"
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a73bb98..f7cba35 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -194,6 +194,41 @@
 
 #define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
 
+/* QCOM DML Registers */
+#define DML_CONFIG			0x00
+#define PRODUCER_CRCI_MSK		GENMASK(1, 0)
+#define PRODUCER_CRCI_DISABLE		0
+#define PRODUCER_CRCI_X_SEL		BIT(0)
+#define PRODUCER_CRCI_Y_SEL		BIT(1)
+#define CONSUMER_CRCI_MSK		GENMASK(3, 2)
+#define CONSUMER_CRCI_DISABLE		0
+#define CONSUMER_CRCI_X_SEL		BIT(2)
+#define CONSUMER_CRCI_Y_SEL		BIT(3)
+#define PRODUCER_TRANS_END_EN		BIT(4)
+#define BYPASS				BIT(16)
+#define DIRECT_MODE			BIT(17)
+#define INFINITE_CONS_TRANS		BIT(18)
+
+#define DML_SW_RESET			0x08
+#define DML_PRODUCER_START		0x0c
+#define DML_CONSUMER_START		0x10
+#define DML_PRODUCER_PIPE_LOGICAL_SIZE	0x14
+#define DML_CONSUMER_PIPE_LOGICAL_SIZE	0x18
+#define DML_PIPE_ID			0x1c
+#define PRODUCER_PIPE_ID_SHFT		0
+#define PRODUCER_PIPE_ID_MSK		GENMASK(4, 0)
+#define CONSUMER_PIPE_ID_SHFT		16
+#define CONSUMER_PIPE_ID_MSK		GENMASK(20, 16)
+
+#define DML_PRODUCER_BAM_BLOCK_SIZE	0x24
+#define DML_PRODUCER_BAM_TRANS_SIZE	0x28
+
+/* other definitions */
+#define PRODUCER_PIPE_LOGICAL_SIZE	4096
+#define CONSUMER_PIPE_LOGICAL_SIZE	4096
+
+#define DML_OFFSET			0x800
+
 struct clk;
 struct dma_chan;
 
diff --git a/drivers/mmc/host/mmci_dma.c b/drivers/mmc/host/mmci_dma.c
index 98a542d..dd7dae5 100644
--- a/drivers/mmc/host/mmci_dma.c
+++ b/drivers/mmc/host/mmci_dma.c
@@ -8,11 +8,11 @@
 #include <linux/dmaengine.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/of.h>
 #include <linux/scatterlist.h>
 
 #include "mmci.h"
 #include "mmci_dma.h"
-#include "mmci_qcom_dml.h"
 
 int mmci_dma_setup(struct mmci_host *host)
 {
@@ -101,6 +101,139 @@ struct dmaengine_priv {
 
 #define dma_inprogress(dmae) ((dmae)->dma_in_progress)
 
+#ifdef CONFIG_MMC_QCOM_DML
+void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
+{
+	u32 config;
+	void __iomem *base = host->base + DML_OFFSET;
+
+	if (data->flags & MMC_DATA_READ) {
+		/* Read operation: configure DML for producer operation */
+		/* Set producer CRCI-x and disable consumer CRCI */
+		config = readl_relaxed(base + DML_CONFIG);
+		config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_X_SEL;
+		config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_DISABLE;
+		writel_relaxed(config, base + DML_CONFIG);
+
+		/* Set the Producer BAM block size */
+		writel_relaxed(data->blksz, base + DML_PRODUCER_BAM_BLOCK_SIZE);
+
+		/* Set Producer BAM Transaction size */
+		writel_relaxed(data->blocks * data->blksz,
+			       base + DML_PRODUCER_BAM_TRANS_SIZE);
+		/* Set Producer Transaction End bit */
+		config = readl_relaxed(base + DML_CONFIG);
+		config |= PRODUCER_TRANS_END_EN;
+		writel_relaxed(config, base + DML_CONFIG);
+		/* Trigger producer */
+		writel_relaxed(1, base + DML_PRODUCER_START);
+	} else {
+		/* Write operation: configure DML for consumer operation */
+		/* Set consumer CRCI-x and disable producer CRCI*/
+		config = readl_relaxed(base + DML_CONFIG);
+		config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_X_SEL;
+		config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_DISABLE;
+		writel_relaxed(config, base + DML_CONFIG);
+		/* Clear Producer Transaction End bit */
+		config = readl_relaxed(base + DML_CONFIG);
+		config &= ~PRODUCER_TRANS_END_EN;
+		writel_relaxed(config, base + DML_CONFIG);
+		/* Trigger consumer */
+		writel_relaxed(1, base + DML_CONSUMER_START);
+	}
+
+	/* make sure the dml is configured before dma is triggered */
+	wmb();
+}
+
+static int of_get_dml_pipe_index(struct device_node *np, const char *name)
+{
+	int index;
+	struct of_phandle_args dma_spec;
+
+	index = of_property_match_string(np, "dma-names", name);
+
+	if (index < 0)
+		return -ENODEV;
+
+	if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
+				       &dma_spec))
+		return -ENODEV;
+
+	if (dma_spec.args_count)
+		return dma_spec.args[0];
+
+	return -ENODEV;
+}
+
+/* Initialize the dml hardware connected to SD Card controller */
+int dml_hw_init(struct mmci_host *host, struct device_node *np)
+{
+	u32 config;
+	void __iomem *base;
+	int consumer_id, producer_id;
+
+	consumer_id = of_get_dml_pipe_index(np, "tx");
+	producer_id = of_get_dml_pipe_index(np, "rx");
+
+	if (producer_id < 0 || consumer_id < 0)
+		return -ENODEV;
+
+	base = host->base + DML_OFFSET;
+
+	/* Reset the DML block */
+	writel_relaxed(1, base + DML_SW_RESET);
+
+	/* Disable the producer and consumer CRCI */
+	config = (PRODUCER_CRCI_DISABLE | CONSUMER_CRCI_DISABLE);
+	/*
+	 * Disable the bypass mode. Bypass mode will only be used
+	 * if data transfer is to happen in PIO mode and don't
+	 * want the BAM interface to connect with SDCC-DML.
+	 */
+	config &= ~BYPASS;
+	/*
+	 * Disable direct mode as we don't DML to MASTER the AHB bus.
+	 * BAM connected with DML should MASTER the AHB bus.
+	 */
+	config &= ~DIRECT_MODE;
+	/*
+	 * Disable infinite mode transfer as we won't be doing any
+	 * infinite size data transfers. All data transfer will be
+	 * of finite data size.
+	 */
+	config &= ~INFINITE_CONS_TRANS;
+	writel_relaxed(config, base + DML_CONFIG);
+
+	/*
+	 * Initialize the logical BAM pipe size for producer
+	 * and consumer.
+	 */
+	writel_relaxed(PRODUCER_PIPE_LOGICAL_SIZE,
+		       base + DML_PRODUCER_PIPE_LOGICAL_SIZE);
+	writel_relaxed(CONSUMER_PIPE_LOGICAL_SIZE,
+		       base + DML_CONSUMER_PIPE_LOGICAL_SIZE);
+
+	/* Initialize Producer/consumer pipe id */
+	writel_relaxed(producer_id | (consumer_id << CONSUMER_PIPE_ID_SHFT),
+		       base + DML_PIPE_ID);
+
+	/* Make sure dml initialization is finished */
+	mb();
+
+	return 0;
+}
+#else
+static inline int dml_hw_init(struct mmci_host *host, struct device_node *np)
+{
+	return -EINVAL;
+}
+
+static inline void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
+{
+}
+#endif /* CONFIG_MMC_QCOM_DML */
+
 static int dmaengine_setup(struct mmci_host *host)
 {
 	const char *rxname, *txname;
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
deleted file mode 100644
index 00750c9..0000000
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- *
- * Copyright (c) 2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#include <linux/of.h>
-#include <linux/of_dma.h>
-#include <linux/bitops.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/card.h>
-#include "mmci.h"
-
-/* Registers */
-#define DML_CONFIG			0x00
-#define PRODUCER_CRCI_MSK		GENMASK(1, 0)
-#define PRODUCER_CRCI_DISABLE		0
-#define PRODUCER_CRCI_X_SEL		BIT(0)
-#define PRODUCER_CRCI_Y_SEL		BIT(1)
-#define CONSUMER_CRCI_MSK		GENMASK(3, 2)
-#define CONSUMER_CRCI_DISABLE		0
-#define CONSUMER_CRCI_X_SEL		BIT(2)
-#define CONSUMER_CRCI_Y_SEL		BIT(3)
-#define PRODUCER_TRANS_END_EN		BIT(4)
-#define BYPASS				BIT(16)
-#define DIRECT_MODE			BIT(17)
-#define INFINITE_CONS_TRANS		BIT(18)
-
-#define DML_SW_RESET			0x08
-#define DML_PRODUCER_START		0x0c
-#define DML_CONSUMER_START		0x10
-#define DML_PRODUCER_PIPE_LOGICAL_SIZE	0x14
-#define DML_CONSUMER_PIPE_LOGICAL_SIZE	0x18
-#define DML_PIPE_ID			0x1c
-#define PRODUCER_PIPE_ID_SHFT		0
-#define PRODUCER_PIPE_ID_MSK		GENMASK(4, 0)
-#define CONSUMER_PIPE_ID_SHFT		16
-#define CONSUMER_PIPE_ID_MSK		GENMASK(20, 16)
-
-#define DML_PRODUCER_BAM_BLOCK_SIZE	0x24
-#define DML_PRODUCER_BAM_TRANS_SIZE	0x28
-
-/* other definitions */
-#define PRODUCER_PIPE_LOGICAL_SIZE	4096
-#define CONSUMER_PIPE_LOGICAL_SIZE	4096
-
-#define DML_OFFSET			0x800
-
-void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
-{
-	u32 config;
-	void __iomem *base = host->base + DML_OFFSET;
-
-	if (data->flags & MMC_DATA_READ) {
-		/* Read operation: configure DML for producer operation */
-		/* Set producer CRCI-x and disable consumer CRCI */
-		config = readl_relaxed(base + DML_CONFIG);
-		config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_X_SEL;
-		config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_DISABLE;
-		writel_relaxed(config, base + DML_CONFIG);
-
-		/* Set the Producer BAM block size */
-		writel_relaxed(data->blksz, base + DML_PRODUCER_BAM_BLOCK_SIZE);
-
-		/* Set Producer BAM Transaction size */
-		writel_relaxed(data->blocks * data->blksz,
-			       base + DML_PRODUCER_BAM_TRANS_SIZE);
-		/* Set Producer Transaction End bit */
-		config = readl_relaxed(base + DML_CONFIG);
-		config |= PRODUCER_TRANS_END_EN;
-		writel_relaxed(config, base + DML_CONFIG);
-		/* Trigger producer */
-		writel_relaxed(1, base + DML_PRODUCER_START);
-	} else {
-		/* Write operation: configure DML for consumer operation */
-		/* Set consumer CRCI-x and disable producer CRCI*/
-		config = readl_relaxed(base + DML_CONFIG);
-		config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_X_SEL;
-		config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_DISABLE;
-		writel_relaxed(config, base + DML_CONFIG);
-		/* Clear Producer Transaction End bit */
-		config = readl_relaxed(base + DML_CONFIG);
-		config &= ~PRODUCER_TRANS_END_EN;
-		writel_relaxed(config, base + DML_CONFIG);
-		/* Trigger consumer */
-		writel_relaxed(1, base + DML_CONSUMER_START);
-	}
-
-	/* make sure the dml is configured before dma is triggered */
-	wmb();
-}
-
-static int of_get_dml_pipe_index(struct device_node *np, const char *name)
-{
-	int index;
-	struct of_phandle_args	dma_spec;
-
-	index = of_property_match_string(np, "dma-names", name);
-
-	if (index < 0)
-		return -ENODEV;
-
-	if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
-				       &dma_spec))
-		return -ENODEV;
-
-	if (dma_spec.args_count)
-		return dma_spec.args[0];
-
-	return -ENODEV;
-}
-
-/* Initialize the dml hardware connected to SD Card controller */
-int dml_hw_init(struct mmci_host *host, struct device_node *np)
-{
-	u32 config;
-	void __iomem *base;
-	int consumer_id, producer_id;
-
-	consumer_id = of_get_dml_pipe_index(np, "tx");
-	producer_id = of_get_dml_pipe_index(np, "rx");
-
-	if (producer_id < 0 || consumer_id < 0)
-		return -ENODEV;
-
-	base = host->base + DML_OFFSET;
-
-	/* Reset the DML block */
-	writel_relaxed(1, base + DML_SW_RESET);
-
-	/* Disable the producer and consumer CRCI */
-	config = (PRODUCER_CRCI_DISABLE | CONSUMER_CRCI_DISABLE);
-	/*
-	 * Disable the bypass mode. Bypass mode will only be used
-	 * if data transfer is to happen in PIO mode and don't
-	 * want the BAM interface to connect with SDCC-DML.
-	 */
-	config &= ~BYPASS;
-	/*
-	 * Disable direct mode as we don't DML to MASTER the AHB bus.
-	 * BAM connected with DML should MASTER the AHB bus.
-	 */
-	config &= ~DIRECT_MODE;
-	/*
-	 * Disable infinite mode transfer as we won't be doing any
-	 * infinite size data transfers. All data transfer will be
-	 * of finite data size.
-	 */
-	config &= ~INFINITE_CONS_TRANS;
-	writel_relaxed(config, base + DML_CONFIG);
-
-	/*
-	 * Initialize the logical BAM pipe size for producer
-	 * and consumer.
-	 */
-	writel_relaxed(PRODUCER_PIPE_LOGICAL_SIZE,
-		       base + DML_PRODUCER_PIPE_LOGICAL_SIZE);
-	writel_relaxed(CONSUMER_PIPE_LOGICAL_SIZE,
-		       base + DML_CONSUMER_PIPE_LOGICAL_SIZE);
-
-	/* Initialize Producer/consumer pipe id */
-	writel_relaxed(producer_id | (consumer_id << CONSUMER_PIPE_ID_SHFT),
-		       base + DML_PIPE_ID);
-
-	/* Make sure dml initialization is finished */
-	mb();
-
-	return 0;
-}
diff --git a/drivers/mmc/host/mmci_qcom_dml.h b/drivers/mmc/host/mmci_qcom_dml.h
deleted file mode 100644
index 6e405d0..0000000
--- a/drivers/mmc/host/mmci_qcom_dml.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *
- * Copyright (c) 2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#ifndef __MMC_QCOM_DML_H__
-#define __MMC_QCOM_DML_H__
-
-#ifdef CONFIG_MMC_QCOM_DML
-int dml_hw_init(struct mmci_host *host, struct device_node *np);
-void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
-#else
-static inline int dml_hw_init(struct mmci_host *host, struct device_node *np)
-{
-	return -ENOSYS;
-}
-static inline void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
-{
-}
-#endif /* CONFIG_MMC_QCOM_DML */
-
-#endif /* __MMC_QCOM_DML_H__ */
-- 
2.7.4

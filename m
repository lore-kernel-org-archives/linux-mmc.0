From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 4/6] mmc: renesas-sdhi: rename tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
Date: Wed, 10 May 2017 11:25:28 +0200
Message-ID: <1494408330-28161-5-git-send-email-horms+renesas@verge.net.au>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54135 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbdEJJ0B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 05:26:01 -0400
In-Reply-To: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>

Rename the source file for DMA for SDHI as a follow-up to attaching
DMA code to the SDHI driver rather than the tmio_core driver.

The name "renesas" is chosen as the SDHI driver is applicable to a wider
range of SoCs than SH-Mobile it seems to be a more appropriate name.
However, the SDHI driver source itself, is left as sh_mobile_sdhi to
avoid unnecessary churn.

The name sys_dmac was chosen to reflect the type of DMA used.

Internal symbols have also been renamed to reflect the filename change.

A follow-up patch will re-organise the SDHI driver removing
the need for renesas_sdhi_get_dma_ops().

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/Makefile                          |  2 +-
 drivers/mmc/host/renesas_sdhi.h                    | 18 +++++++
 .../{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c}    | 59 ++++++++++++----------
 drivers/mmc/host/sh_mobile_sdhi.c                  |  3 +-
 drivers/mmc/host/tmio_mmc.h                        |  9 ----
 5 files changed, 52 insertions(+), 39 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c} (82%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f9baa943b470..15e3cdcda673 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
-obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o tmio_mmc_dma.o
+obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
new file mode 100644
index 000000000000..f65d936cd680
--- /dev/null
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -0,0 +1,18 @@
+/*
+ * Renesas Mobile SDHI
+ *
+ * Copyright (C) 2017 Horms Solutions Ltd., Simon Horman
+ * Copyright (C) 2017 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef RENESAS_SDHI_H
+#define RENESAS_SDHI_H
+
+#include "tmio_mmc.h"
+
+const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void);
+#endif
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
similarity index 82%
rename from drivers/mmc/host/tmio_mmc_dma.c
rename to drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 537ee4ad8b60..94f453c2da6d 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -20,7 +20,8 @@
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
-static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
+					     bool enable)
 {
 	if (!host->chan_tx || !host->chan_rx)
 		return;
@@ -29,19 +30,19 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 		host->dma->enable(host, enable);
 }
 
-static void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
 {
-	tmio_mmc_enable_dma(host, false);
+	renesas_sdhi_sys_dmac_enable_dma(host, false);
 
 	if (host->chan_rx)
 		dmaengine_terminate_all(host->chan_rx);
 	if (host->chan_tx)
 		dmaengine_terminate_all(host->chan_tx);
 
-	tmio_mmc_enable_dma(host, true);
+	renesas_sdhi_sys_dmac_enable_dma(host, true);
 }
 
-static void tmio_mmc_dma_callback(void *arg)
+static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
 
@@ -69,7 +70,7 @@ static void tmio_mmc_dma_callback(void *arg)
 	spin_unlock_irq(&host->lock);
 }
 
-static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
+static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
@@ -115,7 +116,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 
 	if (desc) {
 		reinit_completion(&host->dma_dataend);
-		desc->callback = tmio_mmc_dma_callback;
+		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
 		desc->callback_param = host;
 
 		cookie = dmaengine_submit(desc);
@@ -127,7 +128,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
-		tmio_mmc_enable_dma(host, false);
+		renesas_sdhi_sys_dmac_enable_dma(host, false);
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_rx = NULL;
@@ -143,7 +144,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	}
 }
 
-static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
+static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
@@ -193,7 +194,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 
 	if (desc) {
 		reinit_completion(&host->dma_dataend);
-		desc->callback = tmio_mmc_dma_callback;
+		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
 		desc->callback_param = host;
 
 		cookie = dmaengine_submit(desc);
@@ -205,7 +206,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
-		tmio_mmc_enable_dma(host, false);
+		renesas_sdhi_sys_dmac_enable_dma(host, false);
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_tx = NULL;
@@ -221,19 +222,19 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	}
 }
 
-static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+static void renesas_sdhi_sys_dmac_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
-			tmio_mmc_start_dma_rx(host);
+			renesas_sdhi_sys_dmac_start_dma_rx(host);
 	} else {
 		if (host->chan_tx)
-			tmio_mmc_start_dma_tx(host);
+			renesas_sdhi_sys_dmac_start_dma_tx(host);
 	}
 }
 
-static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
+static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
 {
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
 	struct dma_chan *chan = NULL;
@@ -255,8 +256,8 @@ static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
 		dma_async_issue_pending(chan);
 }
 
-static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-				 struct tmio_mmc_data *pdata)
+static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
+					      struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->dma || (!host->pdev->dev.of_node &&
@@ -319,10 +320,12 @@ static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
 			goto ebouncebuf;
 
 		init_completion(&host->dma_dataend);
-		tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn, (unsigned long)host);
+		tasklet_init(&host->dma_issue,
+			     renesas_sdhi_sys_dmac_issue_tasklet_fn,
+			     (unsigned long)host);
 	}
 
-	tmio_mmc_enable_dma(host, true);
+	renesas_sdhi_sys_dmac_enable_dma(host, true);
 
 	return;
 
@@ -336,7 +339,7 @@ static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
 	host->chan_tx = NULL;
 }
 
-static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+static void renesas_sdhi_sys_dmac_release_dma(struct tmio_mmc_host *host)
 {
 	if (host->chan_tx) {
 		struct dma_chan *chan = host->chan_tx;
@@ -354,15 +357,15 @@ static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 	}
 }
 
-static const struct tmio_mmc_dma_ops tmio_mmc_dma_ops = {
-	.start = tmio_mmc_start_dma,
-	.enable = tmio_mmc_enable_dma,
-	.request = tmio_mmc_request_dma,
-	.release = tmio_mmc_release_dma,
-	.abort = tmio_mmc_abort_dma,
+static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
+	.start = renesas_sdhi_sys_dmac_start_dma,
+	.enable = renesas_sdhi_sys_dmac_enable_dma,
+	.request = renesas_sdhi_sys_dmac_request_dma,
+	.release = renesas_sdhi_sys_dmac_release_dma,
+	.abort = renesas_sdhi_sys_dmac_abort_dma,
 };
 
-const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
+const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void)
 {
-	return &tmio_mmc_dma_ops;
+	return &renesas_sdhi_sys_dmac_dma_ops;
 }
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 90ab460811f6..708c2ba28f99 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -35,6 +35,7 @@
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/regulator/consumer.h>
 
+#include "renesas_sdhi.h"
 #include "tmio_mmc.h"
 
 #define EXT_ACC           0xe4
@@ -667,7 +668,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	ret = tmio_mmc_host_probe(host, mmc_data, tmio_mmc_get_dma_ops());
+	ret = tmio_mmc_host_probe(host, mmc_data, renesas_sdhi_get_dma_ops());
 	if (ret < 0)
 		goto efree;
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 5b8f61de78c9..9c94b6eb9b49 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -213,15 +213,6 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-#if IS_ENABLED(CONFIG_MMC_SDHI)
-const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void);
-#else
-static inline const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
-{
-	return NULL;
-}
-#endif
-
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
 {
-- 
2.1.4


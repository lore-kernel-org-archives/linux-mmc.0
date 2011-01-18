From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 3/4] omap4: hsmmc: Adding ADMA support for MMC1 & MMC2 controllers
Date: Tue, 18 Jan 2011 22:56:30 +0530
Message-ID: <1295371591-13610-4-git-send-email-kishore.kadiyala@ti.com>
References: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42182 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1ARRUL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Jan 2011 12:20:11 -0500
In-Reply-To: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>, Venkatraman S <svenkatr@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4, MMC1 & MMC2 controllers support ADMA feature which will
provide direct access to internal data.
Basically ADMA is a DMA controller embedded in the MMC controller.
It fetches each descriptor line [address+length+attributes] from a
descriptor table and executes the corresponding action [based on attributes].
Base address of Descriptor table in stored in MMCHS_ADMASAL register.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |  223 +++++++++++++++++++++++++++------
 2 files changed, 184 insertions(+), 40 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f57f36a..b13e927 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -110,6 +110,7 @@ struct omap_mmc_platform_data {
 		/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
 #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
+#define HSMMC_HAS_ADMA_SUPPORT	(1 << 2)
 		unsigned features;
 
 		int switch_pin;			/* gpio (card detect) */
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7cf0383..aaa113b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -51,12 +51,15 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
 #define OMAP_HSMMC_IE		0x0134
 #define OMAP_HSMMC_ISE		0x0138
 #define OMAP_HSMMC_CAPA		0x0140
+#define OMAP_HSMMC_ADMA_ES	0x0154
+#define OMAP_HSMMC_ADMA_SAL	0x0158
 
 #define VS18			(1 << 26)
 #define VS30			(1 << 25)
@@ -104,6 +107,25 @@
 #define SRD			(1 << 26)
 #define SOFTRESET		(1 << 1)
 #define RESETDONE		(1 << 0)
+#define DMAS			(0x2 << 3)
+#define CAPA_ADMA_SUPPORT	(1 << 19)
+#define ADMA_XFER_VALID		(1 << 0)
+#define ADMA_XFER_END		(1 << 1)
+#define ADMA_XFER_LINK		(1 << 4)
+#define ADMA_XFER_DESC		(1 << 5)
+#define DMA_MNS_ADMA_MODE	(1 << 20)
+#define ADMA_ERR		(1 << 25)
+#define ADMA_XFER_INT		(1 << 3)
+
+#define ADMA_TABLE_SZ		(PAGE_SIZE)
+#define ADMA_TABLE_NUM_ENTRIES	(ADMA_TABLE_SZ / sizeof(struct adma_desc_table))
+
+/*
+ * According to TRM, it is possible to transfer upto 64kB per ADMA table entry.
+ * But 64kB = 0x10000 cannot be represented using a 16bit integer
+ * in 1 ADMA table row. Hence rounding it to a lesser value.
+ */
+#define ADMA_MAX_XFER_PER_ROW (63 * 1024)
 
 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -146,6 +168,13 @@
 #define OMAP_HSMMC_WRITE(base, reg, val) \
 	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
 
+/* ADMA descriptor table entry */
+struct adma_desc_table {
+	u16 attr;
+	u16 length;
+	dma_addr_t addr;
+};
+
 struct omap_hsmmc_host {
 	struct	device		*dev;
 	struct	mmc_host	*mmc;
@@ -179,6 +208,8 @@ struct omap_hsmmc_host {
 	int			irq;
 	int			dma_ch;
 	int			xfer_type; /* Transfer can be PIO/SDMA/ADMA */
+	struct adma_desc_table	*adma_table;
+	dma_addr_t		phy_adma_table;
 	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
 	int			got_dbclk;
@@ -877,6 +908,44 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 }
 
 /*
+ * SDMA clean up during SDMA transfers.
+ * Also unmapping of sg list in case of error/transfer done during
+ * SDMA/ADMA transfers.
+ */
+static void omap_hsmmc_xfer_cleanup(struct omap_hsmmc_host *host, int errno)
+{
+	int dma_ch;
+	struct mmc_data *data = errno ? host->data : host->mrq->data;
+
+	switch (host->xfer_type) {
+	case OMAP_HSMMC_USE_SDMA_XFER:
+		spin_lock(&host->irq_lock);
+		dma_ch = host->dma_ch;
+		host->dma_ch = -1;
+		spin_unlock(&host->irq_lock);
+		if (dma_ch != -1)
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				host->dma_len,
+				omap_hsmmc_get_dma_dir(host, data));
+		omap_free_dma(dma_ch);
+		break;
+	case OMAP_HSMMC_USE_ADMA_XFER:
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+			host->dma_len, omap_hsmmc_get_dma_dir(host, data));
+		break;
+	case OMAP_HSMMC_USE_PIO_XFER:
+		/* TODO */
+		break;
+	default:
+		dev_dbg(mmc_dev(host->mmc), "Unknown xfer_type\n");
+	}
+	if (errno) {
+		host->data->error = errno;
+		host->data = NULL;
+	}
+}
+
+/*
  * Notify the transfer complete to MMC core
  */
 static void
@@ -898,6 +967,9 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 
 	host->data = NULL;
 
+	if (host->xfer_type == OMAP_HSMMC_USE_ADMA_XFER)
+		omap_hsmmc_xfer_cleanup(host, 0);
+
 	if (!data->error)
 		data->bytes_xfered += data->blocks * (data->blksz);
 	else
@@ -935,40 +1007,6 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 }
 
 /*
- * SDMA clean up during SDMA transfers.
- * Also unmapping of sg list in case of error/transfer done during
- * SDMA/ADMA transfers.
- */
-static void omap_hsmmc_xfer_cleanup(struct omap_hsmmc_host *host, int errno)
-{
-	int dma_ch;
-	struct mmc_data *data = errno ? host->data : host->mrq->data;
-
-	switch (host->xfer_type) {
-	case OMAP_HSMMC_USE_SDMA_XFER:
-		spin_lock(&host->irq_lock);
-		dma_ch = host->dma_ch;
-		host->dma_ch = -1;
-		spin_unlock(&host->irq_lock);
-		if (dma_ch != -1)
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-				host->dma_len,
-				omap_hsmmc_get_dma_dir(host, data));
-		omap_free_dma(dma_ch);
-		break;
-	case OMAP_HSMMC_USE_PIO_XFER:
-		/* TODO */
-		break;
-	default:
-		dev_dbg(mmc_dev(host->mmc), "Unknown xfer_type\n");
-	}
-	if (errno) {
-		host->data->error = errno;
-		host->data = NULL;
-	}
-}
-
-/*
  * Readable error output
  */
 #ifdef CONFIG_MMC_DEBUG
@@ -976,10 +1014,10 @@ static void omap_hsmmc_report_irq(struct omap_hsmmc_host *host, u32 status)
 {
 	/* --- means reserved bit without definition at documentation */
 	static const char *omap_hsmmc_status_bits[] = {
-		"CC", "TC", "BGE", "---", "BWR", "BRR", "---", "---", "CIRQ",
-		"OBI", "---", "---", "---", "---", "---", "ERRI", "CTO", "CCRC",
-		"CEB", "CIE", "DTO", "DCRC", "DEB", "---", "ACE", "---",
-		"---", "---", "---", "CERR", "CERR", "BADA", "---", "---", "---"
+		"CC", "TC", "BGE", "DMA", "BWR", "BRR", "CINS", "CREM", "CIRQ",
+		"OBI", "BSR", "---", "---", "---", "---", "ERRI", "CTO", "CCRC",
+		"CEB", "CIE", "DTO", "DCRC", "DEB", "CLE", "ACE", "ADMA",
+		"---", "---", "CERR", "BADA", "---", "---"
 	};
 	char res[256];
 	char *buf = res;
@@ -1100,6 +1138,24 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 			if (host->data)
 				end_trans = 1;
 		}
+		if (status & ADMA_ERR) {
+			dev_dbg(mmc_dev(host->mmc),
+				"ADMA err: ADMA_ES=%x, SAL=%x; Ignored!\n",
+					OMAP_HSMMC_READ(host->base, ADMA_ES),
+					OMAP_HSMMC_READ(host->base, ADMA_SAL));
+			if (host->cmd)
+				end_cmd = 1;
+			if (host->data)
+				end_trans = 1;
+		}
+	}
+	if (status & ADMA_XFER_INT) {
+		dev_dbg(mmc_dev(host->mmc),
+			"ADMA XFERINT: blk=%x at table=%x pstate=%x\n",
+			OMAP_HSMMC_READ(host->base, BLK),
+			OMAP_HSMMC_READ(host->base, ADMA_SAL),
+			OMAP_HSMMC_READ(host->base, PSTATE));
+
 	}
 
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
@@ -1402,6 +1458,63 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 	return 0;
 }
 
+static int mmc_populate_adma_desc_table(struct omap_hsmmc_host *host,
+		struct mmc_request *req, struct adma_desc_table *pdesc)
+{
+	int i, j, dmalen;
+	int splitseg, xferaddr;
+	int numblocks = 0;
+	dma_addr_t dmaaddr;
+	struct mmc_data *data = req->data;
+
+	host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
+		data->sg_len, omap_hsmmc_get_dma_dir(host, data));
+	for (i = 0, j = 0; i < host->dma_len; i++) {
+		dmaaddr = sg_dma_address(data->sg + i);
+		dmalen = sg_dma_len(data->sg + i);
+		numblocks += dmalen / data->blksz;
+
+		if (dmalen <= ADMA_MAX_XFER_PER_ROW) {
+			pdesc[i + j].length = dmalen;
+			pdesc[i + j].addr = dmaaddr;
+			pdesc[i + j].attr = (ADMA_XFER_DESC |
+						ADMA_XFER_VALID);
+		} else {
+			/* Each descriptor row can only support
+			 * transfer upto ADMA_MAX_XFER_PER_ROW.
+			 * If the current segment is bigger, it has to be
+			 * split to multiple ADMA table entries.
+			 */
+			xferaddr = 0;
+			do {
+				splitseg = min(dmalen, ADMA_MAX_XFER_PER_ROW);
+				dmalen -= splitseg;
+				pdesc[i + j].length = splitseg;
+				pdesc[i + j].addr = dmaaddr + xferaddr;
+				xferaddr += splitseg;
+				pdesc[i + j].attr = (ADMA_XFER_DESC |
+							ADMA_XFER_VALID);
+				j++;
+			} while (dmalen);
+			j--; /* Compensate for i++ */
+		}
+	}
+	/* Setup last entry to terminate */
+	pdesc[i + j - 1].attr |= ADMA_XFER_END;
+	WARN_ON((i + j - 1) > ADMA_TABLE_NUM_ENTRIES);
+	dev_dbg(mmc_dev(host->mmc),
+		"ADMA table has %d entries from %d sglist\n",
+		i + j, host->dma_len);
+	return numblocks;
+}
+
+static void omap_hsmmc_start_adma_transfer(struct omap_hsmmc_host *host)
+{
+	/* Enforcing ordering in write operations */
+	wmb();
+	OMAP_HSMMC_WRITE(host->base, ADMA_SAL, host->phy_adma_table);
+}
+
 static void set_data_timeout(struct omap_hsmmc_host *host,
 			     unsigned int timeout_ns,
 			     unsigned int timeout_clks)
@@ -1446,6 +1559,7 @@ static int
 omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 {
 	int ret;
+	int numblks;
 	host->data = req->data;
 
 	if (req->data == NULL) {
@@ -1463,12 +1577,17 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 					| (req->data->blocks << 16));
 	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
 
-	if (host->xfer_type) {
+	if (host->xfer_type == OMAP_HSMMC_USE_SDMA_XFER) {
 		ret = omap_hsmmc_start_dma_transfer(host, req);
 		if (ret != 0) {
 			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
 			return ret;
 		}
+	} else if (host->xfer_type == OMAP_HSMMC_USE_ADMA_XFER) {
+		numblks = mmc_populate_adma_desc_table(host, req,
+							host->adma_table);
+		WARN_ON(numblks != req->data->blocks);
+		omap_hsmmc_start_adma_transfer(host);
 	}
 	return 0;
 }
@@ -1667,6 +1786,11 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 		capa = VS18;
 	}
 
+	if (host->xfer_type == OMAP_HSMMC_USE_ADMA_XFER) {
+		hctl |= DMAS;
+		value = OMAP_HSMMC_READ(host->base, CON);
+		OMAP_HSMMC_WRITE(host->base, CON, value | DMA_MNS_ADMA_MODE);
+	}
 	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
 	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
 
@@ -2024,7 +2148,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret, irq;
+	int ret, irq, capa;
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform Data is missing\n");
@@ -2162,6 +2286,19 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
+	if (mmc_slot(host).features & HSMMC_HAS_ADMA_SUPPORT) {
+		capa = OMAP_HSMMC_READ(host->base, CAPA);
+		if (capa & CAPA_ADMA_SUPPORT) {
+			/* Allocating memory for ADMA Descriptor Table */
+			host->adma_table = dma_alloc_coherent(NULL,
+				ADMA_TABLE_SZ, &host->phy_adma_table, 0);
+			/* If allocation is success go with ADMA else SDMA */
+			if (host->adma_table != NULL)
+				host->xfer_type = OMAP_HSMMC_USE_ADMA_XFER;
+		}
+	}
+	dev_dbg(mmc_dev(host->mmc), "xfer_type=%d\n", host->xfer_type);
+
 	omap_hsmmc_conf_bus_power(host);
 
 	/* Select DMA lines */
@@ -2277,6 +2414,9 @@ err_irq:
 		clk_put(host->dbclk);
 	}
 err1:
+	if (host->adma_table != NULL)
+		dma_free_coherent(NULL, ADMA_TABLE_SZ,
+			host->adma_table, host->phy_adma_table);
 	iounmap(host->base);
 	platform_set_drvdata(pdev, NULL);
 	mmc_free_host(mmc);
@@ -2304,6 +2444,9 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 			free_irq(mmc_slot(host).card_detect_irq, host);
 		flush_scheduled_work();
 
+		if (host->adma_table != NULL)
+			dma_free_coherent(NULL, ADMA_TABLE_SZ,
+				host->adma_table, host->phy_adma_table);
 		mmc_host_disable(host->mmc);
 		clk_disable(host->iclk);
 		clk_put(host->fclk);
-- 
1.7.1


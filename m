From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 15/41] mmc: host: omap_hsmmc: Enable ADMA2
Date: Fri, 19 May 2017 13:45:15 +0530
Message-ID: <20170519081541.26753-16-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, nsekhar@ti.com, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

omap hsmmc host controller has ADMA2 feature. Enable it here
for better read and write throughput.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[misael.lopez@ti.com: handle ADMA errors]
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[nsekhar@ti.com: restore adma settings after context loss]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c            | 307 +++++++++++++++++++++++++++----
 include/linux/platform_data/hsmmc-omap.h |   1 +
 2 files changed, 271 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 90bf097484ae..c6e3efb0f8fb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -48,6 +48,9 @@
 #include <linux/mmc/sd.h>
 
 /* OMAP HSMMC Host Controller Registers */
+#define OMAP_HSMMC_HL_REV	0x0000
+#define OMAP_HSMMC_HL_HWINFO	0x0004
+#define OMAP_HSMMC_HL_SYSCONFIG	0x0010
 #define OMAP_HSMMC_SYSSTATUS	0x0014
 #define OMAP_HSMMC_CON		0x002C
 #define OMAP_HSMMC_DLL		0x0034
@@ -69,7 +72,10 @@
 #define OMAP_HSMMC_AC12		0x013C
 #define OMAP_HSMMC_CAPA		0x0140
 #define OMAP_HSMMC_CAPA2	0x0144
+#define OMAP_HSMMC_ADMAES	0x0154
+#define OMAP_HSMMC_ADMASAL	0x0158
 
+#define MADMA_EN		(1 << 0)
 #define VS18			(1 << 26)
 #define VS30			(1 << 25)
 #define HSS			(1 << 21)
@@ -79,6 +85,7 @@
 #define SDVS_MASK		0x00000E00
 #define SDVSCLR			0xFFFFF1FF
 #define SDVSDET			0x00000400
+#define DMA_SELECT		(2 << 3)
 #define AUTOIDLE		0x1
 #define SDBP			(1 << 8)
 #define DTO			0xe
@@ -100,6 +107,7 @@
 #define FOUR_BIT		(1 << 1)
 #define HSPE			(1 << 2)
 #define IWE			(1 << 24)
+#define DMA_MASTER		(1 << 20)
 #define DDR			(1 << 19)
 #define CLKEXTFREE		(1 << 16)
 #define CTPL			(1 << 11)
@@ -153,10 +161,11 @@
 #define DCRC_EN			(1 << 21)
 #define DEB_EN			(1 << 22)
 #define ACE_EN			(1 << 24)
+#define ADMAE_EN		(1 << 25)
 #define CERR_EN			(1 << 28)
 #define BADA_EN			(1 << 29)
 
-#define INT_EN_MASK (BADA_EN | CERR_EN | ACE_EN | DEB_EN | DCRC_EN |\
+#define INT_EN_MASK (BADA_EN | CERR_EN | ADMAE_EN | ACE_EN | DEB_EN | DCRC_EN |\
 		DTO_EN | CIE_EN | CEB_EN | CCRC_EN | CTO_EN | \
 		BRR_EN | BWR_EN | TC_EN | CC_EN)
 
@@ -206,6 +215,33 @@
 #define OMAP_HSMMC_WRITE(base, reg, val) \
 	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
 
+struct omap_hsmmc_adma_desc {
+	u8 attr;
+	u8 reserved;
+	u16 len;
+	u32 addr;
+} __packed;
+
+#define ADMA_DESC_SIZE			8
+
+#define ADMA_MAX_LEN			65532
+
+/* Decriptor table defines */
+#define ADMA_DESC_ATTR_VALID		BIT(0)
+#define ADMA_DESC_ATTR_END		BIT(1)
+#define ADMA_DESC_ATTR_INT		BIT(2)
+#define ADMA_DESC_ATTR_ACT1		BIT(4)
+#define ADMA_DESC_ATTR_ACT2		BIT(5)
+
+#define ADMA_DESC_TRANSFER_DATA		ADMA_DESC_ATTR_ACT2
+#define ADMA_DESC_LINK_DESC	(ADMA_DESC_ATTR_ACT1 | ADMA_DESC_ATTR_ACT2)
+
+/* ADMA error status */
+#define AES_MASK		0x3
+#define ST_STOP			0x0
+#define ST_FDS			0x1
+#define ST_TFR			0x3
+
 struct omap_hsmmc_next {
 	unsigned int	dma_len;
 	s32		cookie;
@@ -239,6 +275,7 @@ struct omap_hsmmc_host {
 	int			irq;
 	int			wake_irq;
 	int			dma_ch;
+	int			use_adma;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
 	int			response_busy;
@@ -270,6 +307,9 @@ struct omap_hsmmc_host {
 	struct pinctrl_state	*hs_pinctrl_state;
 	struct pinctrl_state	*ddr_1_8v_pinctrl_state;
 
+	struct omap_hsmmc_adma_desc *adma_desc_table;
+	dma_addr_t              adma_desc_table_addr;
+
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
 	 * possible return values:
@@ -851,6 +891,18 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, IE, 0);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 
+	if (host->use_adma) {
+		u32 val;
+
+		val = OMAP_HSMMC_READ(host->base, CON);
+		val |= DMA_MASTER;
+		OMAP_HSMMC_WRITE(host->base, CON, val);
+
+		val = OMAP_HSMMC_READ(host->base, HCTL);
+		val |= DMA_SELECT;
+		OMAP_HSMMC_WRITE(host->base, HCTL, val);
+	}
+
 	/* Do not initialize card-specific things if the power is off */
 	if (host->power_mode == MMC_POWER_OFF)
 		goto out;
@@ -1065,6 +1117,10 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 		return;
 	}
 
+	if (host->use_adma && host->data && !data->host_cookie)
+		dma_unmap_sg(host->dev, data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+
 	host->data = NULL;
 
 	if (!data->error)
@@ -1126,13 +1182,17 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	host->dma_ch = -1;
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 
-	if (dma_ch != -1) {
-		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
-
+	if (host->use_adma) {
+		dma_unmap_sg(host->dev, host->data->sg, host->data->sg_len,
+			     mmc_get_dma_dir(host->data));
+		host->data->host_cookie = 0;
+	} else if (dma_ch != -1) {
+		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host,
+								host->data);
 		dmaengine_terminate_all(chan);
 		dma_unmap_sg(chan->device->dev,
-			host->data->sg, host->data->sg_len,
-			mmc_get_dma_dir(host->data));
+			     host->data->sg, host->data->sg_len,
+			     mmc_get_dma_dir(host->data));
 
 		host->data->host_cookie = 0;
 	}
@@ -1227,6 +1287,35 @@ static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 		host->mrq->cmd->error = err;
 }
 
+static void omap_hsmmc_adma_err(struct omap_hsmmc_host *host)
+{
+	u32 admaes, admasal;
+
+	admaes = OMAP_HSMMC_READ(host->base, ADMAES);
+	admasal = OMAP_HSMMC_READ(host->base, ADMASAL);
+
+	switch (admaes & AES_MASK) {
+	case ST_STOP:
+		dev_err(mmc_dev(host->mmc),
+			"ADMA err: ST_STOP, desc at 0x%08x follows the erroneous one\n",
+			admasal);
+		break;
+	case ST_FDS:
+		dev_err(mmc_dev(host->mmc),
+			"ADMA err: ST_FDS, erroneous desc at 0x%08x\n",
+			admasal);
+		break;
+	case ST_TFR:
+		dev_err(mmc_dev(host->mmc),
+			"ADMA err: ST_TFR, desc at 0x%08x follows the erroneous one\n",
+			admasal);
+		break;
+	default:
+		dev_warn(mmc_dev(host->mmc), "Unexpected ADMA error state\n");
+		break;
+	}
+}
+
 static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 {
 	struct mmc_data *data;
@@ -1245,6 +1334,13 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 			end_trans = !end_cmd;
 			host->response_busy = 0;
 		}
+
+		if (status & ADMAE_EN) {
+			omap_hsmmc_adma_err(host);
+			end_trans = 1;
+			data->error = -EIO;
+		}
+
 		if (status & (CTO_EN | DTO_EN))
 			hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
 		else if (status & (CCRC_EN | DCRC_EN | DEB_EN | CEB_EN |
@@ -1426,6 +1522,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 				       struct dma_chan *chan)
 {
 	int dma_len;
+	struct device *dev;
 
 	if (!next && data->host_cookie &&
 	    data->host_cookie != host->next_data.cookie) {
@@ -1435,11 +1532,15 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 		data->host_cookie = 0;
 	}
 
+	if (chan)
+		dev = chan->device->dev;
+	else
+		dev = mmc_dev(host->mmc);
+
 	/* Check if next job is already prepared */
 	if (next || data->host_cookie != host->next_data.cookie) {
-		dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
+		dma_len = dma_map_sg(dev, data->sg, data->sg_len,
 				     mmc_get_dma_dir(data));
-
 	} else {
 		dma_len = host->next_data.dma_len;
 		host->next_data.dma_len = 0;
@@ -1612,8 +1713,58 @@ static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
 				| (req->data->blocks << 16));
 	set_data_timeout(host, req->data->timeout_ns,
 				req->data->timeout_clks);
-	chan = omap_hsmmc_get_dma_chan(host, req->data);
-	dma_async_issue_pending(chan);
+
+	if (host->use_adma) {
+		OMAP_HSMMC_WRITE(host->base, ADMASAL,
+				 (u32)host->adma_desc_table_addr);
+	} else {
+		chan = omap_hsmmc_get_dma_chan(host, req->data);
+		dma_async_issue_pending(chan);
+	}
+}
+
+static int omap_hsmmc_write_adma_desc(struct omap_hsmmc_host *host, void *desc,
+				      dma_addr_t addr, u16 len, u8 attr)
+{
+	struct omap_hsmmc_adma_desc *dma_desc = desc;
+
+	dma_desc->len = len;
+	dma_desc->addr = (u32)addr;
+	dma_desc->reserved = 0;
+	dma_desc->attr = attr;
+
+	return 0;
+}
+
+static int omap_hsmmc_setup_adma_transfer(struct omap_hsmmc_host *host,
+					  struct mmc_request *req)
+{
+	struct mmc_data *data = req->data;
+	struct scatterlist *sg;
+	int i;
+	int len;
+	int ret;
+	dma_addr_t addr;
+	struct omap_hsmmc_adma_desc *dma_desc;
+
+	ret = omap_hsmmc_pre_dma_transfer(host, data, NULL, NULL);
+	if (ret)
+		return ret;
+
+	dma_desc = host->adma_desc_table;
+	for_each_sg(data->sg, sg, host->dma_len, i) {
+		addr = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+		WARN_ON(len > ADMA_MAX_LEN);
+		omap_hsmmc_write_adma_desc(host, dma_desc, addr, len,
+					   ADMA_DESC_ATTR_VALID |
+					   ADMA_DESC_TRANSFER_DATA);
+		dma_desc++;
+	}
+	omap_hsmmc_write_adma_desc(host, dma_desc, 0, 0, ADMA_DESC_ATTR_END |
+				   ADMA_DESC_ATTR_VALID);
+
+	return 0;
 }
 
 /*
@@ -1644,10 +1795,18 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 		return 0;
 	}
 
-	ret = omap_hsmmc_setup_dma_transfer(host, req);
-	if (ret != 0) {
-		dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
-		return ret;
+	if (host->use_adma) {
+		ret = omap_hsmmc_setup_adma_transfer(host, req);
+		if (ret != 0) {
+			dev_err(mmc_dev(host->mmc), "MMC adma setup failed\n");
+			return ret;
+		}
+	} else {
+		ret = omap_hsmmc_setup_dma_transfer(host, req);
+		if (ret != 0) {
+			dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
+			return ret;
+		}
 	}
 	return 0;
 }
@@ -1657,11 +1816,18 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
+	struct device *dev;
+	struct dma_chan *c;
 
 	if (data->host_cookie) {
-		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
+		if (host->use_adma) {
+			dev = mmc_dev(mmc);
+		} else {
+			c = omap_hsmmc_get_dma_chan(host, mrq->data);
+			dev = c->device->dev;
+		}
 
-		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
+		dma_unmap_sg(dev, data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 		data->host_cookie = 0;
 	}
@@ -1677,7 +1843,8 @@ static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 		return ;
 	}
 
-	c = omap_hsmmc_get_dma_chan(host, mrq->data);
+	if (!host->use_adma)
+		c = omap_hsmmc_get_dma_chan(host, mrq->data);
 
 	if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
 					&host->next_data, c))
@@ -2337,6 +2504,7 @@ static const struct omap_mmc_of_data omap3_pre_es3_mmc_of_data = {
 
 static const struct omap_mmc_of_data omap4_mmc_of_data = {
 	.reg_offset = 0x100,
+	.controller_flags = OMAP_HSMMC_HAS_HWPARAM,
 };
 static const struct omap_mmc_of_data am33xx_mmc_of_data = {
 	.reg_offset = 0x100,
@@ -2346,7 +2514,8 @@ static const struct omap_mmc_of_data am33xx_mmc_of_data = {
 static const struct omap_mmc_of_data dra7_mmc_of_data = {
 	.reg_offset = 0x100,
 	.controller_flags = OMAP_HSMMC_SWAKEUP_MISSING |
-			    OMAP_HSMMC_REQUIRE_IODELAY,
+			    OMAP_HSMMC_REQUIRE_IODELAY |
+			    OMAP_HSMMC_HAS_HWPARAM,
 };
 
 static const struct of_device_id omap_mmc_of_match[] = {
@@ -2490,6 +2659,64 @@ static int omap_hsmmc_get_iodelay_pinctrl_state(struct omap_hsmmc_host *host)
 	return 0;
 }
 
+static int omap_hsmmc_adma_init(struct omap_hsmmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	u32 val;
+
+	host->adma_desc_table = dma_alloc_coherent(host->dev, ADMA_DESC_SIZE *
+						   (mmc->max_segs + 1),
+						   &host->adma_desc_table_addr,
+						   GFP_KERNEL);
+	if (!host->adma_desc_table) {
+		dev_err(host->dev, "failed to allocate adma desc table\n");
+		return -ENOMEM;
+	}
+
+	val = OMAP_HSMMC_READ(host->base, HCTL);
+	val |= DMA_SELECT;
+	OMAP_HSMMC_WRITE(host->base, HCTL, val);
+
+	val = OMAP_HSMMC_READ(host->base, CON);
+	val |= DMA_MASTER;
+	OMAP_HSMMC_WRITE(host->base, CON, val);
+
+	return 0;
+}
+
+static void omap_hsmmc_adma_exit(struct omap_hsmmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	dma_free_coherent(host->dev, ADMA_DESC_SIZE * (mmc->max_segs + 1),
+			  host->adma_desc_table, host->adma_desc_table_addr);
+}
+
+static int omap_hsmmc_dma_init(struct omap_hsmmc_host *host)
+{
+	host->rx_chan = dma_request_chan(host->dev, "rx");
+	if (IS_ERR(host->rx_chan)) {
+		dev_err(mmc_dev(host->mmc), "RX DMA channel request failed\n");
+		return PTR_ERR(host->rx_chan);
+	}
+
+	host->tx_chan = dma_request_chan(host->dev, "tx");
+	if (IS_ERR(host->tx_chan)) {
+		dev_err(mmc_dev(host->mmc), "TX DMA channel request failed\n");
+		return PTR_ERR(host->tx_chan);
+	}
+
+	return 0;
+}
+
+static void omap_hsmmc_dma_exit(struct omap_hsmmc_host *host)
+{
+	if (!IS_ERR_OR_NULL(host->tx_chan))
+		dma_release_channel(host->tx_chan);
+	if (!IS_ERR_OR_NULL(host->rx_chan))
+		dma_release_channel(host->rx_chan);
+}
+
 static int omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_hsmmc_platform_data *pdata = pdev->dev.platform_data;
@@ -2497,6 +2724,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
 	int ret, irq;
+	u32 val;
 	const struct of_device_id *match;
 	const struct omap_mmc_of_data *data;
 	void __iomem *base;
@@ -2552,6 +2780,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->next_data.cookie = 1;
 	host->pbias_enabled = 0;
 	host->vqmmc_enabled = 0;
+	host->use_adma	= false;
 
 	ret = omap_hsmmc_gpio_init(mmc, host, pdata);
 	if (ret)
@@ -2613,6 +2842,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		host->dbclk = NULL;
 	}
 
+	if (host->pdata->controller_flags & OMAP_HSMMC_HAS_HWPARAM) {
+		val = OMAP_HSMMC_READ(base, HL_HWINFO);
+		if (val & MADMA_EN)
+			host->use_adma = true;
+	}
+
 	/* Since we do only SG emulation, we can have as many segs
 	 * as we want. */
 	mmc->max_segs = 1024;
@@ -2620,7 +2855,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
+	if (host->use_adma)
+		mmc->max_seg_size = ADMA_MAX_LEN;
+	else
+		mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
@@ -2640,19 +2878,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pinctrl;
 
-	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
-	if (IS_ERR(host->rx_chan)) {
-		dev_err(mmc_dev(host->mmc), "RX DMA channel request failed\n");
-		ret = PTR_ERR(host->rx_chan);
-		goto err_irq;
-	}
-
-	host->tx_chan = dma_request_chan(&pdev->dev, "tx");
-	if (IS_ERR(host->tx_chan)) {
-		dev_err(mmc_dev(host->mmc), "TX DMA channel request failed\n");
-		ret = PTR_ERR(host->tx_chan);
+	if (host->use_adma)
+		ret = omap_hsmmc_adma_init(host);
+	else
+		ret = omap_hsmmc_dma_init(host);
+	if (ret)
 		goto err_irq;
-	}
 
 	/* Request IRQ for MMC operations */
 	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
@@ -2707,10 +2938,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 err_slot_name:
 	mmc_remove_host(mmc);
 err_irq:
-	if (!IS_ERR_OR_NULL(host->tx_chan))
-		dma_release_channel(host->tx_chan);
-	if (!IS_ERR_OR_NULL(host->rx_chan))
-		dma_release_channel(host->rx_chan);
+	if (host->use_adma)
+		omap_hsmmc_adma_exit(host);
+	else
+		omap_hsmmc_dma_exit(host);
 err_pinctrl:
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
@@ -2732,8 +2963,10 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
 
-	dma_release_channel(host->tx_chan);
-	dma_release_channel(host->rx_chan);
+	if (host->use_adma)
+		omap_hsmmc_adma_exit(host);
+	else
+		omap_hsmmc_dma_exit(host);
 
 	del_timer_sync(&host->timer);
 
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 8e771851e07a..c3f2a34db97a 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -28,6 +28,7 @@
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
 #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
 #define OMAP_HSMMC_REQUIRE_IODELAY		BIT(3)
+#define OMAP_HSMMC_HAS_HWPARAM			BIT(4)
 
 struct omap_hsmmc_dev_attr {
 	u8 flags;
-- 
2.11.0

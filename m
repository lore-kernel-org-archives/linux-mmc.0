From: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/4] sdio: mediatek: Support sdio feature
Date: Tue, 8 Nov 2016 14:08:59 +0800
Message-ID: <1478585341-6749-3-git-send-email-yong.mao@mediatek.com>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1478585341-6749-1-git-send-email-yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chunfeng Yun <chunfeng.yun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

1. Add irqlock to protect accessing the shared register
2. Modify the implementation of msdc_card_busy due to SDIO
3. Implement enable_sdio_irq
4. Add msdc_recheck_sdio_irq mechanism to make sure all
   interrupts can be processed immediately

Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c |  167 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 129 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b29683b..37edf30 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -117,6 +117,7 @@
 #define MSDC_PS_CDSTS           (0x1 << 1)	/* R  */
 #define MSDC_PS_CDDEBOUNCE      (0xf << 12)	/* RW */
 #define MSDC_PS_DAT             (0xff << 16)	/* R  */
+#define MSDC_PS_DATA1           (0x1 << 17)	/* R  */
 #define MSDC_PS_CMD             (0x1 << 24)	/* R  */
 #define MSDC_PS_WP              (0x1 << 31)	/* R  */
 
@@ -304,6 +305,7 @@ struct msdc_host {
 	int cmd_rsp;
 
 	spinlock_t lock;
+	spinlock_t irqlock;	/* sdio irq lock */
 	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	struct mmc_data *data;
@@ -322,12 +324,14 @@ struct msdc_host {
 	struct pinctrl_state *pins_uhs;
 	struct delayed_work req_timeout;
 	int irq;		/* host interrupt */
+	bool irq_thread_alive;
 
 	struct clk *src_clk;	/* msdc source clock */
 	struct clk *h_clk;      /* msdc h_clk */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
 	u32 sclk;		/* SD/MS bus clock frequency */
+	bool clock_on;
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 hs400_ds_delay;
@@ -387,6 +391,7 @@ static void msdc_reset_hw(struct msdc_host *host)
 
 static void msdc_cmd_next(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd);
+static void msdc_recheck_sdio_irq(struct msdc_host *host);
 
 static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
 			MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
@@ -513,6 +518,7 @@ static void msdc_gate_clock(struct msdc_host *host)
 {
 	clk_disable_unprepare(host->src_clk);
 	clk_disable_unprepare(host->h_clk);
+	host->clock_on = false;
 }
 
 static void msdc_ungate_clock(struct msdc_host *host)
@@ -521,6 +527,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
 	clk_prepare_enable(host->src_clk);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
+	host->clock_on = true;
 }
 
 static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
@@ -529,6 +536,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 flags;
 	u32 div;
 	u32 sclk;
+	unsigned long irq_flags;
 
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
@@ -537,8 +545,11 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		return;
 	}
 
+	spin_lock_irqsave(&host->irqlock, irq_flags);
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
+	spin_unlock_irqrestore(&host->irqlock, irq_flags);
+
 	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
 	if (timing == MMC_TIMING_UHS_DDR50 ||
 	    timing == MMC_TIMING_MMC_DDR52 ||
@@ -588,7 +599,10 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	host->timing = timing;
 	/* need because clk changed. */
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
+
+	spin_lock_irqsave(&host->irqlock, irq_flags);
 	sdr_set_bits(host->base + MSDC_INTEN, flags);
+	spin_unlock_irqrestore(&host->irqlock, irq_flags);
 
 	/*
 	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
@@ -690,6 +704,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
 			    struct mmc_command *cmd, struct mmc_data *data)
 {
+	unsigned long flags;
 	bool read;
 
 	WARN_ON(host->data);
@@ -698,8 +713,12 @@ static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
 
 	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 	msdc_dma_setup(host, &host->dma, data);
+
+	spin_lock_irqsave(&host->irqlock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
 	dev_dbg(host->dev, "DMA start\n");
 	dev_dbg(host->dev, "%s: cmd=%d DMA data: %d blocks; read=%d\n",
 			__func__, cmd->opcode, data->blocks, read);
@@ -756,6 +775,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq);
 	mmc_request_done(host->mmc, mrq);
+	msdc_recheck_sdio_irq(host);
 }
 
 /* returns true if command is fully handled; returns false otherwise */
@@ -779,15 +799,17 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 					| MSDC_INT_CMDTMO)))
 		return done;
 
-	spin_lock_irqsave(&host->lock, flags);
 	done = !host->cmd;
+	spin_lock_irqsave(&host->lock, flags);
 	host->cmd = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (done)
 		return true;
 
+	spin_lock_irqsave(&host->irqlock, flags);
 	sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	spin_unlock_irqrestore(&host->irqlock, flags);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
@@ -902,6 +924,7 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 static void msdc_start_command(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
+	unsigned long flags;
 	u32 rawcmd;
 
 	WARN_ON(host->cmd);
@@ -920,7 +943,10 @@ static void msdc_start_command(struct msdc_host *host,
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
 	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 
+	spin_lock_irqsave(&host->irqlock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
 	writel(cmd->arg, host->base + SDC_ARG);
 	writel(rawcmd, host->base + SDC_CMD);
 }
@@ -1013,8 +1039,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 	     | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
 	     | MSDC_INT_DMA_PROTECT);
 
-	spin_lock_irqsave(&host->lock, flags);
 	done = !host->data;
+	spin_lock_irqsave(&host->lock, flags);
 	if (check_data)
 		host->data = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1029,7 +1055,11 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 				1);
 		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
 			cpu_relax();
+
+		spin_lock_irqsave(&host->irqlock, flags);
 		sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
+		spin_unlock_irqrestore(&host->irqlock, flags);
+
 		dev_dbg(host->dev, "DMA stop\n");
 
 		if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
@@ -1134,44 +1164,47 @@ static void msdc_request_timeout(struct work_struct *work)
 
 static irqreturn_t msdc_irq(int irq, void *dev_id)
 {
+	unsigned long flags;
 	struct msdc_host *host = (struct msdc_host *) dev_id;
+	struct mmc_request *mrq;
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+	u32 events, event_mask;
+
+	spin_lock_irqsave(&host->irqlock, flags);
+	events = readl(host->base + MSDC_INT);
+	event_mask = readl(host->base + MSDC_INTEN);
+	/* clear interrupts */
+	writel(events & event_mask, host->base + MSDC_INT);
+
+	mrq = host->mrq;
+	cmd = host->cmd;
+	data = host->data;
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
+	if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
+		mmc_signal_sdio_irq(host->mmc);
+		if (!mrq)
+			return IRQ_HANDLED;
+	}
 
-	while (true) {
-		unsigned long flags;
-		struct mmc_request *mrq;
-		struct mmc_command *cmd;
-		struct mmc_data *data;
-		u32 events, event_mask;
-
-		spin_lock_irqsave(&host->lock, flags);
-		events = readl(host->base + MSDC_INT);
-		event_mask = readl(host->base + MSDC_INTEN);
-		/* clear interrupts */
-		writel(events & event_mask, host->base + MSDC_INT);
-
-		mrq = host->mrq;
-		cmd = host->cmd;
-		data = host->data;
-		spin_unlock_irqrestore(&host->lock, flags);
-
-		if (!(events & event_mask))
-			break;
+	if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
+		return IRQ_HANDLED;
 
-		if (!mrq) {
-			dev_err(host->dev,
-				"%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
-				__func__, events, event_mask);
-			WARN_ON(1);
-			break;
-		}
+	if (!mrq) {
+		dev_err(host->dev,
+			"%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
+			__func__, events, event_mask);
+		WARN_ON(1);
+		return IRQ_HANDLED;
+	}
 
-		dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
+	dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
 
-		if (cmd)
-			msdc_cmd_done(host, events, mrq, cmd);
-		else if (data)
-			msdc_data_xfer_done(host, events, mrq, data);
-	}
+	if (cmd)
+		msdc_cmd_done(host, events, mrq, cmd);
+	else if (data)
+		msdc_data_xfer_done(host, events, mrq, data);
 
 	return IRQ_HANDLED;
 }
@@ -1179,6 +1212,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 static void msdc_init_hw(struct msdc_host *host)
 {
 	u32 val;
+	unsigned long flags;
 
 	/* Configure to MMC/SD mode, clock free running */
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
@@ -1190,9 +1224,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
 
 	/* Disable and clear all interrupts */
+	spin_lock_irqsave(&host->irqlock, flags);
 	writel(0, host->base + MSDC_INTEN);
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
+	spin_unlock_irqrestore(&host->irqlock, flags);
 
 	writel(0, host->base + MSDC_PAD_TUNE);
 	writel(0, host->base + MSDC_IOCON);
@@ -1207,9 +1243,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	 */
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
 
-	/* disable detect SDIO device interrupt function */
-	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
-
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	else
+		/* disable detect SDIO device interrupt function */
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
 
@@ -1221,11 +1259,15 @@ static void msdc_init_hw(struct msdc_host *host)
 static void msdc_deinit_hw(struct msdc_host *host)
 {
 	u32 val;
+	unsigned long flags;
+
 	/* Disable and clear all interrupts */
+	spin_lock_irqsave(&host->irqlock, flags);
 	writel(0, host->base + MSDC_INTEN);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
+	spin_unlock_irqrestore(&host->irqlock, flags);
 }
 
 /* init gpd and bd list in msdc_drv_probe */
@@ -1493,6 +1535,52 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	sdr_clr_bits(host->base + EMMC_IOCON, 1);
 }
 
+/**
+ * msdc_recheck_sdio_irq - recheck whether the SDIO IRQ is lost
+ * @host: The host to check.
+ *
+ * Host controller may lost interrupt in some special case.
+ * Add sdio IRQ recheck mechanism to make sure all interrupts
+ * can be processed immediately
+ *
+ */
+static void msdc_recheck_sdio_irq(struct msdc_host *host)
+{
+	u32 reg_int, reg_ps;
+
+	if (host->clock_on &&
+	    (host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
+	    host->irq_thread_alive) {
+		reg_int = readl(host->base + MSDC_INT);
+		reg_ps  = readl(host->base + MSDC_PS);
+		if (!((reg_int & MSDC_INT_SDIOIRQ) ||
+		      (reg_ps & MSDC_PS_DATA1))) {
+			mmc_signal_sdio_irq(host->mmc);
+		}
+	}
+}
+
+static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	host->irq_thread_alive = true;
+	if (enable) {
+		pm_runtime_get_sync(host->dev);
+		msdc_recheck_sdio_irq(host);
+
+		spin_lock_irqsave(&host->irqlock, flags);
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		spin_unlock_irqrestore(&host->irqlock, flags);
+	} else {
+		spin_lock_irqsave(&host->irqlock, flags);
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		spin_unlock_irqrestore(&host->irqlock, flags);
+	}
+}
+
 static struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
@@ -1504,6 +1592,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	.execute_tuning = msdc_execute_tuning,
 	.prepare_hs400_tuning = msdc_prepare_hs400_tuning,
 	.hw_reset = msdc_hw_reset,
+	.enable_sdio_irq = msdc_enable_sdio_irq,
 };
 
 static int msdc_drv_probe(struct platform_device *pdev)
@@ -1600,6 +1689,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc_dev(mmc)->dma_mask = &host->dma_mask;
 
 	host->timeout_clks = 3 * 1048576;
+	host->irq_thread_alive = false;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
 				2 * sizeof(struct mt_gpdma_desc),
 				&host->dma.gpd_addr, GFP_KERNEL);
@@ -1613,6 +1703,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_init_gpd_bd(host, &host->dma);
 	INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
 	spin_lock_init(&host->lock);
+	spin_lock_init(&host->irqlock);
 
 	platform_set_drvdata(pdev, mmc);
 	msdc_ungate_clock(host);
-- 
1.7.9.5

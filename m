From: Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [v4] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
Date: Tue, 18 Dec 2018 20:33:18 +0800
Message-ID: <1545136398-5066-1-git-send-email-jjian.zhou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, jjian zhou <jjian.zhou@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Yong Mao <yong.mao@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: jjian zhou <jjian.zhou@mediatek.com>

This patch enables support SDIO IRQs. It enables
MMC_CAP_SDIO_IRQ & MMC_CAP2_SDIO_IRQ_NOTHREAD
and implement the ->ack_sdio_irq callback.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 53 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6334cc7..8afeaf8 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
 	u32 rawcmd;
+	unsigned long flags;

 	WARN_ON(host->cmd);
 	host->cmd = cmd;
@@ -1131,7 +1132,10 @@ static void msdc_start_command(struct msdc_host *host,
 	cmd->error = 0;
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);

+	spin_lock_irqsave(&host->lock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	writel(cmd->arg, host->base + SDC_ARG);
 	writel(rawcmd, host->base + SDC_CMD);
 }
@@ -1351,6 +1355,31 @@ static void msdc_request_timeout(struct work_struct *work)
 	}
 }

+static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
+{
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (enb)
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	else
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+
+	__msdc_enable_sdio_irq(mmc, enb);
+
+	if (enb)
+		pm_runtime_get_noresume(host->dev);
+	else
+		pm_runtime_put_noidle(host->dev);
+}
+
 static irqreturn_t msdc_irq(int irq, void *dev_id)
 {
 	struct msdc_host *host = (struct msdc_host *) dev_id;
@@ -1373,7 +1402,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		data = host->data;
 		spin_unlock_irqrestore(&host->lock, flags);

-		if (!(events & event_mask))
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
+			__msdc_enable_sdio_irq(host->mmc, 0);
+			sdio_signal_irq(host->mmc);
+		}
+
+		if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
 			break;

 		if (!mrq) {
@@ -1493,8 +1527,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	 */
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);

-	/* disable detect SDIO device interrupt function */
-	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	/* Config SDIO device detect interrupt function */
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	else
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
@@ -2013,6 +2050,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	sdr_clr_bits(host->base + EMMC_IOCON, 1);
 }

+static void msdc_ack_sdio_irq(struct mmc_host *mmc)
+{
+	__msdc_enable_sdio_irq(mmc, 1);
+}
+
 static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
@@ -2020,6 +2062,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
 	.get_cd = mmc_gpio_get_cd,
+	.enable_sdio_irq = msdc_enable_sdio_irq,
+	.ack_sdio_irq = msdc_ack_sdio_irq,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
@@ -2147,6 +2191,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	else
 		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);

+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
--
1.9.1

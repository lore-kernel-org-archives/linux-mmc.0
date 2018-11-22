From: Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH] mmc: mediatek: add MT8183 SDIO driver support
Date: Thu, 22 Nov 2018 15:05:18 +0800
Message-ID: <1542870318-10731-1-git-send-email-jjian.zhou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, jjian zhou <jjian.zhou@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Yong Mao <yong.mao@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: jjian zhou <jjian.zhou@mediatek.com>

MT8183 need SDIO driver. So it need add new code
to support it.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6334cc7..3128ee7 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
 	u32 rawcmd;
+	unsigned long flags;

 	WARN_ON(host->cmd);
 	host->cmd = cmd;
@@ -1131,7 +1132,12 @@ static void msdc_start_command(struct msdc_host *host,
 	cmd->error = 0;
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);

+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		spin_lock_irqsave(&host->lock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		spin_unlock_irqrestore(&host->lock, flags);
+
 	writel(cmd->arg, host->base + SDC_ARG);
 	writel(rawcmd, host->base + SDC_CMD);
 }
@@ -1351,6 +1357,27 @@ static void msdc_request_timeout(struct work_struct *work)
 	}
 }

+static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
+{
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	if (enb)
+		pm_runtime_get_sync(host->dev);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (enb)
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	else
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (!enb) {
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
+	}
+}
+
 static irqreturn_t msdc_irq(int irq, void *dev_id)
 {
 	struct msdc_host *host = (struct msdc_host *) dev_id;
@@ -1373,7 +1400,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		data = host->data;
 		spin_unlock_irqrestore(&host->lock, flags);

-		if (!(events & event_mask))
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
+			msdc_enable_sdio_irq(host->mmc, 0);
+			sdio_signal_irq(host->mmc);
+		}
+
+		if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
 			break;

 		if (!mrq) {
@@ -1493,8 +1525,11 @@ static void msdc_init_hw(struct msdc_host *host)
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
@@ -2013,6 +2048,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	sdr_clr_bits(host->base + EMMC_IOCON, 1);
 }

+static void msdc_ack_sdio_irq(struct mmc_host *mmc)
+{
+	msdc_enable_sdio_irq(mmc, 1);
+}
+
 static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
@@ -2020,6 +2060,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
 	.get_cd = mmc_gpio_get_cd,
+	.enable_sdio_irq = msdc_enable_sdio_irq,
+	.ack_sdio_irq = msdc_ack_sdio_irq,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
@@ -2147,6 +2189,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	else
 		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);

+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
--
1.9.1

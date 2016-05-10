From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 1/3] mmc: tmio: Add tuning support
Date: Tue, 10 May 2016 14:52:02 +0900
Message-ID: <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58429 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbcEJFwI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 01:52:08 -0400
In-Reply-To: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add tuning support for use with SDR104 mode

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v1 [Simon Horman]
* Omit start_signal_voltage_switch and tmio_mmc_card_busy changes which are
  already present in mainline in a different form
* Return num from init_tuning rather than passing an extra parameter
  to hold the return value
* Only call host->init_tuning if it is non-NULL
* Place tmio_mmc_execute_tuning() such that no new forward declarations are
  required
* Remove unused TMIO_MMC_HAS_UHS_SCC define

v0 [Ai Kyuse]
---
 drivers/mmc/host/tmio_mmc.h     |  10 ++
 drivers/mmc/host/tmio_mmc_pio.c | 249 ++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/tmio.h        |   3 +
 3 files changed, 254 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 1aac2ad8edf2..cacc64c87fa0 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -19,6 +19,7 @@
 #define TMIO_MMC_H
 
 #include <linux/dmaengine.h>
+#include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
@@ -150,6 +151,9 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
+	u32			scc_tappos;
+	bool			done_tuning;
+	struct completion	completion;
 
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	int (*clk_enable)(struct tmio_mmc_host *host);
@@ -160,6 +164,12 @@ struct tmio_mmc_host {
 			      unsigned int direction, int blk_size);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
+	bool (*inquiry_tuning)(struct tmio_mmc_host *host);
+	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
+	int (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
+	int (*select_tuning)(struct tmio_mmc_host *host, unsigned long *tap);
+	bool (*retuning)(struct tmio_mmc_host *host);
+	void (*hw_reset)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f44e2ab7aea2..4e6d80ad7bac 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
+#include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
@@ -277,6 +278,8 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 {
 	struct mmc_request *mrq;
 	unsigned long flags;
+	bool result;
+	struct mmc_command *cmd = host->cmd;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -290,7 +293,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	host->data = NULL;
 	host->force_pio = false;
 
-	cancel_delayed_work(&host->delayed_reset_work);
+	if (!(host->inquiry_tuning && host->inquiry_tuning(host) &&
+	      !host->done_tuning) || cmd != mrq->sbc)
+		cancel_delayed_work(&host->delayed_reset_work);
 
 	host->mrq = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -298,6 +303,29 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
 		tmio_mmc_abort_dma(host);
 
+	if (host->inquiry_tuning && host->inquiry_tuning(host) &&
+	     !host->done_tuning) {
+		/* call retuning() to clear SCC error bit */
+		if (host->retuning)
+			host->retuning(host);
+		/* finish processing tuning request */
+		complete(&host->completion);
+		return;
+	}
+
+	/* Check retuning */
+	if (host->retuning && host->done_tuning) {
+		result = host->retuning(host);
+		if (result || (mrq->cmd->error == -EILSEQ))
+			host->done_tuning = false;
+	}
+
+	if (cmd == mrq->sbc) {
+		/* finish SET_BLOCK_COUNT request */
+		complete(&host->completion);
+		return;
+	}
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -363,7 +391,8 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 			 * multiple block transfer
 			 */
 			if ((host->pdata->flags & TMIO_MMC_HAVE_CMD12_CTRL) &&
-			    (cmd->opcode == SD_IO_RW_EXTENDED))
+			    ((cmd->opcode == SD_IO_RW_EXTENDED) ||
+			     host->mrq->sbc))
 				c |= NO_CMD12_ISSUE;
 		}
 		if (data->flags & MMC_DATA_READ)
@@ -520,7 +549,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	schedule_work(&host->done);
 }
 
-static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
 	struct mmc_data *data;
 	spin_lock(&host->lock);
@@ -529,6 +558,9 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	if (!data)
 		goto out;
 
+	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
+	    stat & TMIO_STAT_TXUNDERRUN)
+		data->error = -EILSEQ;
 	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 		bool done = false;
@@ -577,8 +609,6 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 		goto out;
 	}
 
-	host->cmd = NULL;
-
 	/* This controller is sicker than the PXA one. Not only do we need to
 	 * drop the top 8 bits of the first response word, we also need to
 	 * modify the order of the response for short response command types.
@@ -598,14 +628,16 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 
 	if (stat & TMIO_STAT_CMDTIMEOUT)
 		cmd->error = -ETIMEDOUT;
-	else if (stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC)
+	else if ((stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC) ||
+		 stat & TMIO_STAT_STOPBIT_ERR ||
+		 stat & TMIO_STAT_CMD_IDX_ERR)
 		cmd->error = -EILSEQ;
 
 	/* If there is data to handle we enable data IRQs here, and
 	 * we will ultimatley finish the request in the data_end handler.
 	 * If theres no data or we encountered an error, finish now.
 	 */
-	if (host->data && !cmd->error) {
+	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
 			if (host->force_pio || !host->chan_rx)
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
@@ -666,7 +698,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	/* Data transfer completion */
 	if (ireg & TMIO_STAT_DATAEND) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
-		tmio_mmc_data_irq(host);
+		tmio_mmc_data_irq(host, status);
 		return true;
 	}
 
@@ -753,6 +785,157 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	return 0;
 }
 
+#define TMIO_MMC_MAX_TUNING_LOOP 40
+
+static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mmc_ios *ios = &mmc->ios;
+
+	unsigned long timeout, val;
+	unsigned long *tap;
+	int tuning_loop_counter = TMIO_MMC_MAX_TUNING_LOOP;
+	int ret, timeleft;
+
+	struct mmc_request mrq = {NULL};
+	struct mmc_command cmd = {0};
+	struct mmc_data data = {0};
+	struct scatterlist sg;
+	u8 *data_buf;
+	unsigned int num, tm = CMDREQ_TIMEOUT;
+	unsigned long flags;
+
+	if ((ios->timing != MMC_TIMING_UHS_SDR50 &&
+	     ios->timing != MMC_TIMING_UHS_SDR104) ||
+	    (host->inquiry_tuning && !host->inquiry_tuning(host)) ||
+	    host->done_tuning || !host->init_tuning)
+		return 0;
+
+	num = host->init_tuning(host);
+
+	tap = kmalloc(num * 2, GFP_KERNEL);
+	if (tap == NULL) {
+		ret = -ENOMEM;
+		goto err_tap;
+	}
+
+	data_buf = kmalloc(64, GFP_KERNEL);
+	if (data_buf == NULL) {
+		ret = -ENOMEM;
+		goto err_data;
+	}
+
+	val = 0;
+
+	/*
+	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
+	 * of loops reaches 40 times or a timeout of 150ms occurs.
+	 */
+	timeout = 150;
+	do {
+		if (host->prepare_tuning)
+			host->prepare_tuning(host, val % num);
+
+		if (!tuning_loop_counter && !timeout)
+			break;
+
+		/*
+		 * In response to CMD19, the card sends 64 bytes of tuning
+		 * block to the Host Controller. So we set the block size
+		 * to 64 here.
+		 */
+
+		spin_lock_irqsave(&host->lock, flags);
+		init_completion(&host->completion);
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+
+		cmd.opcode = opcode;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		cmd.retries = 0;
+		cmd.error = 0;
+
+		data.blksz = 64;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+		data.sg = &sg;
+		data.sg_len = 1;
+		data.error = 0;
+
+		sg_init_one(&sg, data_buf, 64);
+
+		host->mrq = &mrq;
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		ret = tmio_mmc_start_data(host, mrq.data);
+		if (ret)
+			goto out;
+
+		ret = tmio_mmc_start_command(host, mrq.cmd);
+		if (ret)
+			goto out;
+
+		timeleft = wait_for_completion_timeout(&host->completion,
+						       msecs_to_jiffies(tm));
+		if (timeleft < 0) {
+			ret = timeleft;
+			goto out;
+		}
+
+		if (!timeleft) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
+		/* Check CRC error */
+		if (cmd.error && cmd.error != -EILSEQ) {
+			ret = cmd.error;
+			goto out;
+		}
+		if (data.error && data.error != -EILSEQ) {
+			ret = data.error;
+			goto out;
+		}
+
+		tap[val] = (cmd.error | data.error);
+
+		val++;
+		tuning_loop_counter--;
+		timeout--;
+		mdelay(1);
+	} while ((val < (num * 2)) && (tuning_loop_counter || timeout));
+
+	/*
+	 * The Host Driver has exhausted the maximum number of loops allowed,
+	 * so use fixed sampling frequency.
+	 */
+	if (tuning_loop_counter || timeout) {
+		if (host->select_tuning) {
+			ret = host->select_tuning(host, tap);
+			if (ret < 0)
+				goto out;
+		}
+		host->done_tuning = true;
+	} else {
+		dev_warn(&host->pdev->dev, ": Tuning procedure failed\n");
+		ret = -EIO;
+		goto out;
+	}
+
+out:
+	kfree(data_buf);
+err_data:
+	kfree(tap);
+err_tap:
+	if (ret < 0 && host->hw_reset)
+		host->hw_reset(host);
+
+	return ret;
+
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -778,6 +961,43 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (host->inquiry_tuning && host->inquiry_tuning(host) &&
+	    !host->done_tuning) {
+		/* Start retuning */
+		ret = tmio_mmc_execute_tuning(mmc, MMC_SEND_TUNING_BLOCK);
+		if (ret)
+			goto fail;
+		/* Restore request */
+		host->mrq = mrq;
+	}
+
+	if (mrq->sbc) {
+		init_completion(&host->completion);
+		ret = tmio_mmc_start_command(host, mrq->sbc);
+		if (ret)
+			goto fail;
+		ret = wait_for_completion_timeout(&host->completion,
+					msecs_to_jiffies(CMDREQ_TIMEOUT));
+		if (ret < 0)
+			goto fail;
+		if (!ret) {
+			ret = -ETIMEDOUT;
+			goto fail;
+		}
+		host->last_req_ts = jiffies;
+		host->mrq = mrq;
+		if (host->inquiry_tuning && host->inquiry_tuning(host) &&
+		    !host->done_tuning) {
+			/* Start retuning */
+			ret = tmio_mmc_execute_tuning(mmc,
+						      MMC_SEND_TUNING_BLOCK);
+			if (ret)
+				goto fail;
+			/* Restore request */
+			host->mrq = mrq;
+		}
+	}
+
 	if (mrq->data) {
 		ret = tmio_mmc_start_data(host, mrq->data);
 		if (ret)
@@ -967,6 +1187,16 @@ static int tmio_mmc_card_busy(struct mmc_host *mmc)
 	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
 }
 
+static void tmio_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (host->hw_reset)
+		host->hw_reset(host);
+
+	host->done_tuning = false;
+}
+
 static struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
@@ -975,6 +1205,8 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
+	.execute_tuning = tmio_mmc_execute_tuning,
+	.hw_reset	= tmio_mmc_hw_reset,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
@@ -1084,6 +1316,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
+	_host->done_tuning = false;
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  mmc->caps & MMC_CAP_NONREMOVABLE ||
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 7a26286db895..6c22b21f2d73 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -104,6 +104,9 @@
  */
 #define TMIO_MMC_CLK_ACTUAL		(1 << 10)
 
+/* Some controllers have UHS-I sampling clock controller */
+#define TMIO_MMC_HAS_UHS_SCC		(1 << 11)
+
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
-- 
2.1.4


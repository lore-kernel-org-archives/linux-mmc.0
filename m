From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 2/4] mmc: tmio: Add tuning support
Date: Tue, 24 May 2016 11:43:15 +0900
Message-ID: <1464057797-29951-3-git-send-email-horms+renesas@verge.net.au>
References: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35212 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbcEXCn0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2016 22:43:26 -0400
In-Reply-To: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add tuning support for use with SDR104 mode

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3 [Simon Horman]
* As suggested by Kuninori Morimoto:
  - Do not add unused retuning callback to struct tmio_mmc_host
  - Change return type of prepare_tuning callback to void
  - Add tap_size parameter to select_tuning callback

v2 [Simon Horman]
* As suggested by Kuninori Morimoto:
  - Actually remove unnecessary TMIO_MMC_HAS_UHS_SCC define
* As suggested by Wolfram Sang:
  - Rely on core to call tuning. This simplifies things somewhat.
  - Use mmc_send_tuning()
    - A side affect of this appears to be that we now see some recoverable
      errors logged during tuning. These are typically corrected by
      subsequent tuning. It is the logging that is the apparent side effect
      of this change.
      e.g.
      sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
      sh_mobile_sdhi ee100000.sd: Tuning procedure failed
* Use bool rather than unsigned long to pass test status
  to select_tuning() callback
* Do not retune if init_tuning callback is not present or
  indicates that there are no taps present
* Retune on hardware reset

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
 drivers/mmc/host/tmio_mmc.h     |  6 +++
 drivers/mmc/host/tmio_mmc_pio.c | 85 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 1aac2ad8edf2..7d1174c78921 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -150,6 +150,7 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
+	u32			scc_tappos;
 
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	int (*clk_enable)(struct tmio_mmc_host *host);
@@ -160,6 +161,11 @@ struct tmio_mmc_host {
 			      unsigned int direction, int blk_size);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
+	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
+	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
+	int (*select_tuning)(struct tmio_mmc_host *host, bool *tap,
+			     int tap_size);
+	void (*hw_reset)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 12dc0440a487..235546e9bbfc 100644
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
@@ -363,7 +364,8 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 			 * multiple block transfer
 			 */
 			if ((host->pdata->flags & TMIO_MMC_HAVE_CMD12_CTRL) &&
-			    (cmd->opcode == SD_IO_RW_EXTENDED))
+			    ((cmd->opcode == SD_IO_RW_EXTENDED) ||
+			     host->mrq->sbc))
 				c |= NO_CMD12_ISSUE;
 		}
 		if (data->flags & MMC_DATA_READ)
@@ -756,6 +758,74 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	return 0;
 }
 
+static void tmio_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (host->hw_reset)
+		host->hw_reset(host);
+
+	mmc_retune_timer_stop(host->mmc);
+	mmc_retune_needed(host->mmc);
+}
+
+static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	unsigned int num = 0;
+	int i, ret = 0;
+	bool *tap;
+
+	if (host->init_tuning)
+		num = host->init_tuning(host);
+	if (!num) {
+		/* Tuning is not supported */
+		ret = 0;
+		goto out;
+	}
+
+	tap = kmalloc(num * 2, GFP_KERNEL);
+	if (!tap) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Issue CMD19 twice for each tap
+	 */
+	for (i = 0; i < 2 * num; i++) {
+		int err;
+
+		if (host->prepare_tuning)
+			host->prepare_tuning(host, i);
+
+		err = mmc_send_tuning(host->mmc, opcode, NULL);
+		if (err && err != -EILSEQ) {
+			ret = err;
+			goto err_free;
+		}
+		tap[i] = (err == 0);
+
+		mdelay(1);
+	}
+
+	if (host->select_tuning)
+		ret = host->select_tuning(host, tap, num * 2);
+
+err_free:
+	kfree(tap);
+out:
+	if (ret < 0) {
+		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
+		tmio_mmc_hw_reset(mmc);
+	} else {
+		host->mmc->retune_period = 0;
+	}
+
+	return ret;
+
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -781,6 +851,14 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (mrq->sbc) {
+		ret = tmio_mmc_start_command(host, mrq->sbc);
+		if (ret)
+			goto fail;
+		host->last_req_ts = jiffies;
+		host->mrq = mrq;
+	}
+
 	if (mrq->data) {
 		ret = tmio_mmc_start_data(host, mrq->data);
 		if (ret)
@@ -978,6 +1056,8 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
+	.execute_tuning = tmio_mmc_execute_tuning,
+	.hw_reset	= tmio_mmc_hw_reset,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
@@ -1202,6 +1282,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
+	mmc_retune_timer_stop(host->mmc);
+	mmc_retune_needed(host->mmc);
+
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-- 
2.1.4


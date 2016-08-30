From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 04/11] mmc: tmio: Add tuning support
Date: Tue, 30 Aug 2016 23:09:52 +0200
Message-ID: <1472591399-13907-5-git-send-email-horms+renesas@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45906 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758615AbcH3VK1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 17:10:27 -0400
In-Reply-To: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add tuning support for use with SDR104 mode

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5 [Simon Horman]
* As suggested by Ulf Hansson:
  - Move hw reset support into a separate patch
  - Reply on core to retune on hw reset
  - Use more descriptive name for callback to check for SSC error
  - Rely on core to retune in case of -EILSEQ
  - Document mandatory and optional callbacks

v4 [Simon Horman]
* As suggested by Wolfram Sang:
  - Do not perform tuning if host->select_tuning is not set:
    it seems to make little sense to do so and moreover there is currently
    no such use-case
  - Do not add mrc->sbc handling from tmio_mmc_request,
    this is a hang-over from earlier versions of this patchset which
    did not use core infrastructure for retuning
  - Tidy up local variable usage
* Correct index passed to prepare_tuning(): this seems to have
  been the last piece of resolving the timeouts during tuning puzzle
* Further cleanups to tmio_mmc_execute_tuning():
  - Ensure tap is sized proportionally to its members
  - Remove stray '*' in comment
  - Use mmc rather than host->mmc, these are equivalent but
    the former seems tidier
  - Correct inverted logic in setting tap values
* Re-introduce retuning support. This was removed in v3.

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
 drivers/mmc/host/tmio_mmc.h     |  9 ++++++
 drivers/mmc/host/tmio_mmc_pio.c | 62 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 4b71f31fba63..8c0d204563d0 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -150,6 +150,7 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
+	u32			scc_tappos;
 
 	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
@@ -165,6 +166,14 @@ struct tmio_mmc_host {
 					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	void (*hw_reset)(struct tmio_mmc_host *host);
+	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
+	bool (*check_scc_error)(struct tmio_mmc_host *host);
+
+	/* Mandatory callback for tuning to occur which is
+	 * optional for SDR50 and mandatory for SDR104 */
+	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
+	int (*select_tuning)(struct tmio_mmc_host *host, bool *tap,
+			     int tap_size);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 90758647bae6..c85ffd83ebb9 100644
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
@@ -298,6 +299,11 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
 		tmio_mmc_abort_dma(host);
 
+	if (host->check_scc_error && host->check_scc_error(host)) {
+		mmc_retune_timer_stop(host->mmc);
+		mmc_retune_needed(host->mmc);
+	}
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -762,9 +768,57 @@ static void tmio_mmc_hw_reset(struct mmc_host *mmc)
 
 	if (host->hw_reset)
 		host->hw_reset(host);
+}
+
+static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	unsigned int num;
+	int i, ret = 0;
+	bool *tap;
+
+	if (!host->init_tuning || !host->select_tuning)
+		/* Tuning is not supported */
+		goto out;
+
+	num = host->init_tuning(host);
+	if (!num)
+		/* Tuning is not supported */
+		goto out;
+
+	tap = kmalloc(num * 2 * sizeof(*tap), GFP_KERNEL);
+	if (!tap) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Issue CMD19 twice for each tap */
+	for (i = 0; i < 2 * num; i++) {
+		if (host->prepare_tuning)
+			host->prepare_tuning(host, i % num);
+
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (ret && ret != -EILSEQ)
+			goto err_free;
+		tap[i] = (ret != 0);
+
+		mdelay(1);
+	}
+
+	ret = host->select_tuning(host, tap, num * 2);
+
+err_free:
+	kfree(tap);
+out:
+	if (ret < 0) {
+		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
+		mmc_hw_reset(mmc);
+	} else {
+		host->mmc->retune_period = 0;
+	}
+
+	return ret;
 
-	mmc_retune_timer_stop(host->mmc);
-	mmc_retune_needed(host->mmc);
 }
 
 /* Process requests from the MMC layer */
@@ -982,6 +1036,7 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 	.hw_reset	= tmio_mmc_hw_reset,
+	.execute_tuning = tmio_mmc_execute_tuning,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
@@ -1207,6 +1262,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
+	mmc_retune_timer_stop(host->mmc);
+	mmc_retune_needed(host->mmc);
+
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-- 
2.7.0.rc3.207.g0ac5344


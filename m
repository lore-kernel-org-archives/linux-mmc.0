From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Wed, 27 Jul 2016 13:13:21 +0900
Message-ID: <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add tuning support for use with SDR104 mode

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v4 [Simon Horman]
As suggested by Wolfram Sang:
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

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc.h     |  7 ++++
 drivers/mmc/host/tmio_mmc_pio.c | 77 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7f63ec05bdf4..316b0c3fe745 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -150,6 +150,7 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
+	u32			scc_tappos;
 
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	int (*clk_enable)(struct tmio_mmc_host *host);
@@ -160,6 +161,12 @@ struct tmio_mmc_host {
 			      unsigned int direction, int blk_size);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
+	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
+	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
+	int (*select_tuning)(struct tmio_mmc_host *host, bool *tap,
+			     int tap_size);
+	bool (*retuning)(struct tmio_mmc_host *host);
+	void (*hw_reset)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a9d07b5f3c63..83b5148a2684 100644
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
@@ -298,6 +299,15 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
 		tmio_mmc_abort_dma(host);
 
+	if (host->retuning) {
+		int result = host->retuning(host);
+
+		if (result || (mrq->cmd->error == -EILSEQ)) {
+			mmc_retune_timer_stop(host->mmc);
+			mmc_retune_needed(host->mmc);
+		}
+	}
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -756,6 +766,68 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
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
@@ -978,6 +1050,8 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
+	.execute_tuning = tmio_mmc_execute_tuning,
+	.hw_reset	= tmio_mmc_hw_reset,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
@@ -1202,6 +1276,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
+	mmc_retune_timer_stop(host->mmc);
+	mmc_retune_needed(host->mmc);
+
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-- 
2.7.0.rc3.207.g0ac5344

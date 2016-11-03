From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v8 5/6] mmc: tmio: Add tuning support
Date: Thu,  3 Nov 2016 15:16:03 +0100
Message-ID: <1478182564-18762-6-git-send-email-horms+renesas@verge.net.au>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add tuning support for use with SDR104 mode

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v7 [Simon Horman]
* As per review by Ulf Hansson:
  - Use tmio_mmc_hw_reset() rather than mmc_hw_reset() in
    tmio_mmc_execute_tuning()
  - Do not zero host->mmc->retune_period in tmio_mmc_execute_tuning()
  - Do not perform a reset if host->select_tuning() fails in
    tmio_mmc_host_runtime_resume() retuning should be
    performed if a request subsequently fails.
* Do not implicitly trigger retuning if host->check_scc_error() returns true

v6 [Simon Horman]
* As suggested by Ulf Hansson:
  - Restore saved tuning parameters on resume

v5 [Simon Horman]
* As suggested by Ulf Hansson:
  - Move hw reset support into a separate patch
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
 drivers/mmc/host/tmio_mmc.h     | 12 ++++++++
 drivers/mmc/host/tmio_mmc_pio.c | 63 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c5adf52fc049..637581faf756 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -153,6 +153,7 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
+	u32			scc_tappos;
 
 	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
@@ -168,6 +169,17 @@ struct tmio_mmc_host {
 					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	void (*hw_reset)(struct tmio_mmc_host *host);
+	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
+	bool (*check_scc_error)(struct tmio_mmc_host *host);
+
+	/* Mandatory callback for tuning to occur which is
+	 * optional for SDR50 and mandatory for SDR104 */
+	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
+	int (*select_tuning)(struct tmio_mmc_host *host);
+
+	/* Tuning values: 1 for success, 0 for failure */
+	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
+	unsigned int tap_num;
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ce6e93758576..a0f05eb4f344 100644
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
@@ -298,6 +299,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
 		tmio_mmc_abort_dma(host);
 
+	if (host->check_scc_error)
+		host->check_scc_error(host);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -767,6 +771,56 @@ static void tmio_mmc_hw_reset(struct mmc_host *mmc)
 		host->hw_reset(host);
 }
 
+static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	int i, ret = 0;
+
+	if (!host->tap_num) {
+		if (!host->init_tuning || !host->select_tuning)
+			/* Tuning is not supported */
+			goto out;
+
+		host->tap_num = host->init_tuning(host);
+		if (!host->tap_num)
+			/* Tuning is not supported */
+			goto out;
+	}
+
+	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
+		dev_warn_once(&host->pdev->dev,
+		      "Too many taps, skipping tuning. Please consider "
+		      "updating size of taps field of tmio_mmc_host\n");
+		goto out;
+	}
+
+	bitmap_zero(host->taps, host->tap_num * 2);
+
+	/* Issue CMD19 twice for each tap */
+	for (i = 0; i < 2 * host->tap_num; i++) {
+		if (host->prepare_tuning)
+			host->prepare_tuning(host, i % host->tap_num);
+
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (ret && ret != -EILSEQ)
+			goto out;
+		if (ret == 0)
+			set_bit(i, host->taps);
+
+		mdelay(1);
+	}
+
+	ret = host->select_tuning(host);
+
+out:
+	if (ret < 0) {
+		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
+		tmio_mmc_hw_reset(mmc);
+	}
+
+	return ret;
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -984,6 +1038,7 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 	.hw_reset	= tmio_mmc_hw_reset,
+	.execute_tuning = tmio_mmc_execute_tuning,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
@@ -1230,6 +1285,11 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_suspend);
 
+static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
+{
+	return host->tap_num && mmc_can_retune(host->mmc);
+}
+
 int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
@@ -1243,6 +1303,9 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 
 	tmio_mmc_enable_dma(host, true);
 
+	if (tmio_mmc_can_retune(host) && host->select_tuning(host))
+		dev_warn(&host->pdev->dev, "Tuning selection failed\n");
+
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
-- 
2.7.0.rc3.207.g0ac5344

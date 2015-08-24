From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 1/2] mmc: core: sdio: move mmc_sdio_init_card to a separate function
Date: Mon, 24 Aug 2015 15:45:16 +0530
Message-ID: <1440411317-8813-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: adrian.hunter@intel.com, neilb@suse.de, zhonghui.fu@linux.intel.com, afenkart@gmail.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Move mmc_sdio_init_card to a separate
function (_mmc_sdio_power_restore) and invoke it from
mmc_sdio_power_restore. This is in preparation to invoke
_mmc_sdio_power_restore from mmc_sdio_runtime_resume so that
mmc_claim_host can be invoked before mmc_power_up.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/core/sdio.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b91abed..0cbbfb8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -970,15 +970,10 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_sdio_power_restore(struct mmc_host *host)
+static int _mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
-
-	mmc_claim_host(host);
-
 	/*
 	 * Reset the card by performing the same steps that are taken by
 	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
@@ -1002,14 +997,25 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 
 	ret = mmc_send_io_op_cond(host, 0, NULL);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = mmc_sdio_init_card(host, host->card->ocr, host->card,
 				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
 
-out:
+	return 0;
+}
+
+static int mmc_sdio_power_restore(struct mmc_host *host)
+{
+	int ret;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	mmc_claim_host(host);
+	ret = _mmc_sdio_power_restore(host);
 	mmc_release_host(host);
 
 	return ret;
-- 
1.7.9.5

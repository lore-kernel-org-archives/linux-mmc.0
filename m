From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 02/15] mmc: core: Enable / disable re-tuning
Date: Tue, 28 Apr 2015 16:18:14 +0300
Message-ID: <1430227094-7611-1-git-send-email-adrian.hunter@intel.com>
References: <5536287C.6060004@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2059 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965506AbbD1NUo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Apr 2015 09:20:44 -0400
In-Reply-To: <5536287C.6060004@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Enable re-tuning when tuning is executed and
disable re-tuning when card is no longer initialized.

In the case of SDIO suspend, the card can keep power.
In that case, re-tuning need not be disabled, but, if
a re-tuning timer is being used, ensure it is disabled
and assume that re-tuning will be needed upon resume
since it is not known how long the suspend will last.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V7:


	Also flag re-tune needed in SDIO 'keep_power'
	case, when a re-tuning timer is being used.


 drivers/mmc/core/core.c | 4 ++++
 drivers/mmc/core/sdio.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 92e7671..007c444 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1109,6 +1109,8 @@ int mmc_execute_tuning(struct mmc_card *card)
 
 	if (err)
 		pr_err("%s: tuning execution failed\n", mmc_hostname(host));
+	else
+		mmc_retune_enable(host);
 
 	return err;
 }
@@ -1140,6 +1142,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
  */
 void mmc_set_initial_state(struct mmc_host *host)
 {
+	mmc_retune_disable(host);
+
 	if (mmc_host_is_spi(host))
 		host->ios.chip_select = MMC_CS_HIGH;
 	else
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5bc6c7d..16e1f39 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -934,8 +934,12 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		mmc_release_host(host);
 	}
 
-	if (!mmc_card_keep_power(host))
+	if (!mmc_card_keep_power(host)) {
 		mmc_power_off(host);
+	} else if (host->retune_period) {
+		mmc_retune_timer_stop(host);
+		mmc_retune_needed(host);
+	}
 
 	return 0;
 }
-- 
1.9.1


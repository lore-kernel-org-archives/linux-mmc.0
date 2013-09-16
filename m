From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/7] mmc: core: Let mmc_set_signal_voltage take ocr as parameter
Date: Mon, 16 Sep 2013 16:17:43 +0200
Message-ID: <1379341068-27097-3-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:46501 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3IPOSE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:04 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so4352691lbh.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:18:02 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

This is yet another step of restructure code to be able to fixup the
setup of the negotiated ocr mask.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |    4 ++--
 drivers/mmc/core/core.h |    2 +-
 drivers/mmc/core/sd.c   |    3 ++-
 drivers/mmc/core/sdio.c |    3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 07e83c5..8f89e11 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1422,7 +1422,7 @@ int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
@@ -1504,7 +1504,7 @@ power_cycle:
 	if (err) {
 		pr_debug("%s: Signal voltage switch failed, "
 			"power cycling card\n", mmc_hostname(host));
-		mmc_power_cycle(host, host->ocr);
+		mmc_power_cycle(host, ocr);
 	}
 
 	mmc_host_clk_release(host);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 502769a..443a584 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -42,7 +42,7 @@ void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr);
 int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index af55e9e..5818887 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -773,7 +773,8 @@ try_again:
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
+					host->ocr);
 		if (err == -EAGAIN) {
 			retries--;
 			goto try_again;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 355c952..15cbc418 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -664,7 +664,8 @@ try_again:
 	 * it.
 	 */
 	if (!powered_resume && (ocr & R4_18V_PRESENT) && mmc_host_uhs(host)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
+					host->ocr);
 		if (err == -EAGAIN) {
 			sdio_reset(host);
 			mmc_go_idle(host);
-- 
1.7.9.5


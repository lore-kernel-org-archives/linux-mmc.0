From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] mmc: eMMC signal voltage does not use CMD11
Date: Fri, 22 Apr 2011 13:26:27 -0700
Message-ID: <ABE44455-4F1B-45A2-AED9-150C8E5DBED0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51169 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab1DVU0m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:26:42 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arindam Nath <arindam.nath@amd.com>


eMMC chips do not use CMD11 when changing voltage.  Add extra
argument to call to indicate if CMD11 needs to be sent.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/sd.c     |    4 ++--
 drivers/mmc/core/sd_ops.c |    4 ++--
 drivers/mmc/core/sd_ops.h |    3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ed6b11b..362716c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -734,7 +734,7 @@ try_again:
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 1);
 		if (err) {
 			ocr &= ~(1 << 24);
 			goto try_again;
@@ -1115,7 +1115,7 @@ int mmc_attach_sd(struct mmc_host *host)
 		host->ocr_avail = host->ocr_avail_sd;
 
 	/* Make sure we are at 3.3V signalling voltage */
-	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
+	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
 	if (err)
 		return err;
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index fc7edc4..6fd35f6 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -149,7 +149,7 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
 	return 0;
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, int cmd11)
 {
 	struct mmc_command cmd;
 	int err = 0;
@@ -160,7 +160,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
 	 */
-	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+	if (signal_voltage != MMC_SIGNAL_VOLTAGE_330 && cmd11) {
 		memset(&cmd, 0, sizeof(struct mmc_command));
 
 		cmd.opcode = SD_SWITCH_VOLTAGE;
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index d5bdda5..2670e71 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -20,7 +20,8 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
+	int cmd11);
 
 #endif
 
-- 
1.7.0.4



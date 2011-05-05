From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v4 13/15] mmc eMMC signal voltage does not use CMD11
Date: Thu,  5 May 2011 12:19:09 +0530
Message-ID: <1304578151-1775-14-git-send-email-arindam.nath@amd.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:62422 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEGxP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 02:53:15 -0400
Received: by mail-px0-f173.google.com with SMTP id 16so1439619pxi.4
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2011 23:53:15 -0700 (PDT)
In-Reply-To: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

eMMC chips do not use CMD11 when changing voltage.  Add extra
argument to call to indicate if CMD11 needs to be sent.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/core.c |    4 ++--
 drivers/mmc/core/core.h |    3 ++-
 drivers/mmc/core/sd.c   |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 78a9b51..74b4409 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -942,7 +942,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	return ocr;
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, int cmd11)
 {
 	struct mmc_command cmd;
 	int err = 0;
@@ -953,7 +953,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
 	 */
-	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+	if ((signal_voltage != MMC_SIGNAL_VOLTAGE_330) && cmd11) {
 		memset(&cmd, 0, sizeof(struct mmc_command));
 
 		cmd.opcode = SD_SWITCH_VOLTAGE;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 93f3397..3c11e17 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -41,7 +41,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
+			   int cmd11);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 851c8fc..d2a05ab 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -731,7 +731,7 @@ try_again:
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 1);
 		if (err) {
 			ocr &= ~SD_OCR_S18R;
 			goto try_again;
@@ -1104,7 +1104,7 @@ int mmc_attach_sd(struct mmc_host *host)
 	WARN_ON(!host->claimed);
 
 	/* Make sure we are at 3.3V signalling voltage */
-	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
+	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
 	if (err)
 		return err;
 
-- 
1.7.1


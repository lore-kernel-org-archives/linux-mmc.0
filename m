From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v2 3/4] mmc eMMC signal voltage does not use CMD11
Date: Fri, 13 May 2011 11:17:17 +0530
Message-ID: <1305265638-1572-4-git-send-email-arindam.nath@amd.com>
References: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62232 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab1EMFss (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2011 01:48:48 -0400
Received: by pzk9 with SMTP id 9so1030473pzk.19
        for <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 22:48:47 -0700 (PDT)
In-Reply-To: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, zhangfei.gao@gmail.com, Arindam Nath <arindam.nath@amd.com>

From: Philip Rakity <prakity@marvell.com>

eMMC chips do not use CMD11 when changing voltage.  Add extra
argument to call to indicate if CMD11 needs to be sent.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/core.c |    5 +++--
 drivers/mmc/core/core.h |    3 ++-
 drivers/mmc/core/sd.c   |    5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 72e113e..580fe82 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -942,7 +942,8 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	return ocr;
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
+	bool cmd11)
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
@@ -953,7 +954,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
 	 */
-	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+	if ((signal_voltage != MMC_SIGNAL_VOLTAGE_330) && cmd11) {
 		cmd.opcode = SD_SWITCH_VOLTAGE;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 93f3397..53d23c2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -41,7 +41,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
+			   bool cmd11);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index b461b29..b309a84 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -725,7 +725,8 @@ try_again:
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
+					     true);
 		if (err) {
 			ocr &= ~SD_OCR_S18R;
 			goto try_again;
@@ -1098,7 +1099,7 @@ int mmc_attach_sd(struct mmc_host *host)
 	WARN_ON(!host->claimed);
 
 	/* Make sure we are at 3.3V signalling voltage */
-	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
+	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, false);
 	if (err)
 		return err;
 
-- 
1.7.1


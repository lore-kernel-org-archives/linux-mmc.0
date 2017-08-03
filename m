From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH] mmc: sdhci: ignore restoring the I/O state if MMC_POWER_OFF
Date: Thu, 3 Aug 2017 12:28:40 -0700
Message-ID: <1501788520-26244-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33537 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbdHCT0B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 15:26:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com, Zhoujie Wu <zjwu@marvell.com>

One issue was found on a removable high speed sd card with
runtime pm enabled.
When SD card is unplugged, it keep printing "Switching to 3.3V
signalling voltage failed".
And found below sequence triggers the error.

mmc_rescan
	-> mmc_sd_detect
		-> mmc_power_off  -- mmc->ios.vdd is updated to 0.
	-> mmc_claim_host
		-> sdhci_runtime_resume_host
			-> sdhci_start_signal_voltage_switch
				-> mmc_regulator_set_vqmmc
					-> mmc_ocrbitnum_to_vdd

When mmc_ocrbitnum_to_vdd is called, the mmc->ios.vdd is 0, so it
always return -EINVAL. The signal switch will always fail and
print out warning.
Ignore restoring the I/O state when runtime resume if MMC_POWER_OFF.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
This patch is the updated version for my previous patch
mmc: sdhci: ignore 3.3v voltage switch if ios.vdd is 0.
Suggested by Adrian, so added his name in signed-off-by as well.

 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 98700f9..c3f67f1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2934,7 +2934,8 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED) {
+	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
+	    mmc->ios.power_mode != MMC_POWER_OFF) {
 		/* Force clock and power re-program */
 		host->pwr = 0;
 		host->clock = 0;
-- 
1.9.1


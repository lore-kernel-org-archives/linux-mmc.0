From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH] mmc: sdhci: ignore 3.3v voltage switch if ios.vdd is 0
Date: Tue, 1 Aug 2017 16:58:21 -0700
Message-ID: <1501631901-1304-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56124 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751600AbdHAXzp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2017 19:55:45 -0400
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
		-> mmc_power_off  -- mmc->ios.vdd is update to 0.
	-> mmc_claim_host
		-> sdhci_runtime_resume_host
			-> sdhci_start_signal_voltage_switch
				-> mmc_regulator_set_vqmmc
					-> mmc_ocrbitnum_to_vdd

When mmc_ocrbitnum_to_vdd is called, the mmc->ios.vdd is 0, so it
always return -EINVAL. The signal switch will always fail and
print out warning.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
Hi Ulf,
	Not sure if this is the best way to fix it. Please help to suggest. Thanks.

 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..011ebbe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1878,7 +1878,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		ctrl &= ~SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		if (!IS_ERR(mmc->supply.vqmmc)) {
+		if ((!IS_ERR(mmc->supply.vqmmc)) && mmc->ios.vdd) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
-- 
1.9.1


From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] mmc: host: use of_property_bool()
Date: Wed, 05 Aug 2015 23:50:49 +0300
Message-ID: <29992733.xbE5epXo5u@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34626 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbbHEUuw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2015 16:50:52 -0400
Received: by labow3 with SMTP id ow3so36766421lab.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2015 13:50:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Use more compact of_property_read_bool() calls instead of the of_find_property()
calls.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.

 drivers/mmc/core/host.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

Index: mmc/drivers/mmc/core/host.c
===================================================================
--- mmc.orig/drivers/mmc/core/host.c
+++ mmc/drivers/mmc/core/host.c
@@ -398,7 +398,7 @@ int mmc_of_parse(struct mmc_host *host)
 {
 	struct device_node *np;
 	u32 bus_width;
-	int len, ret;
+	int ret;
 	bool cd_cap_invert, cd_gpio_invert = false;
 	bool ro_cap_invert, ro_gpio_invert = false;
 
@@ -445,12 +445,12 @@ int mmc_of_parse(struct mmc_host *host)
 	 */
 
 	/* Parse Card Detection */
-	if (of_find_property(np, "non-removable", &len)) {
+	if (of_property_read_bool(np, "non-removable")) {
 		host->caps |= MMC_CAP_NONREMOVABLE;
 	} else {
 		cd_cap_invert = of_property_read_bool(np, "cd-inverted");
 
-		if (of_find_property(np, "broken-cd", &len))
+		if (of_property_read_bool(np, "broken-cd"))
 			host->caps |= MMC_CAP_NEEDS_POLL;
 
 		ret = mmc_gpiod_request_cd(host, "cd", 0, true,
@@ -491,41 +491,41 @@ int mmc_of_parse(struct mmc_host *host)
 	if (ro_cap_invert ^ ro_gpio_invert)
 		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	if (of_find_property(np, "cap-sd-highspeed", &len))
+	if (of_property_read_bool(np, "cap-sd-highspeed"))
 		host->caps |= MMC_CAP_SD_HIGHSPEED;
-	if (of_find_property(np, "cap-mmc-highspeed", &len))
+	if (of_property_read_bool(np, "cap-mmc-highspeed"))
 		host->caps |= MMC_CAP_MMC_HIGHSPEED;
-	if (of_find_property(np, "sd-uhs-sdr12", &len))
+	if (of_property_read_bool(np, "sd-uhs-sdr12"))
 		host->caps |= MMC_CAP_UHS_SDR12;
-	if (of_find_property(np, "sd-uhs-sdr25", &len))
+	if (of_property_read_bool(np, "sd-uhs-sdr25"))
 		host->caps |= MMC_CAP_UHS_SDR25;
-	if (of_find_property(np, "sd-uhs-sdr50", &len))
+	if (of_property_read_bool(np, "sd-uhs-sdr50"))
 		host->caps |= MMC_CAP_UHS_SDR50;
-	if (of_find_property(np, "sd-uhs-sdr104", &len))
+	if (of_property_read_bool(np, "sd-uhs-sdr104"))
 		host->caps |= MMC_CAP_UHS_SDR104;
-	if (of_find_property(np, "sd-uhs-ddr50", &len))
+	if (of_property_read_bool(np, "sd-uhs-ddr50"))
 		host->caps |= MMC_CAP_UHS_DDR50;
-	if (of_find_property(np, "cap-power-off-card", &len))
+	if (of_property_read_bool(np, "cap-power-off-card"))
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
-	if (of_find_property(np, "cap-sdio-irq", &len))
+	if (of_property_read_bool(np, "cap-sdio-irq"))
 		host->caps |= MMC_CAP_SDIO_IRQ;
-	if (of_find_property(np, "full-pwr-cycle", &len))
+	if (of_property_read_bool(np, "full-pwr-cycle"))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
-	if (of_find_property(np, "keep-power-in-suspend", &len))
+	if (of_property_read_bool(np, "keep-power-in-suspend"))
 		host->pm_caps |= MMC_PM_KEEP_POWER;
-	if (of_find_property(np, "enable-sdio-wakeup", &len))
+	if (of_property_read_bool(np, "enable-sdio-wakeup"))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
-	if (of_find_property(np, "mmc-ddr-1_8v", &len))
+	if (of_property_read_bool(np, "mmc-ddr-1_8v"))
 		host->caps |= MMC_CAP_1_8V_DDR;
-	if (of_find_property(np, "mmc-ddr-1_2v", &len))
+	if (of_property_read_bool(np, "mmc-ddr-1_2v"))
 		host->caps |= MMC_CAP_1_2V_DDR;
-	if (of_find_property(np, "mmc-hs200-1_8v", &len))
+	if (of_property_read_bool(np, "mmc-hs200-1_8v"))
 		host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
-	if (of_find_property(np, "mmc-hs200-1_2v", &len))
+	if (of_property_read_bool(np, "mmc-hs200-1_2v"))
 		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
-	if (of_find_property(np, "mmc-hs400-1_8v", &len))
+	if (of_property_read_bool(np, "mmc-hs400-1_8v"))
 		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
-	if (of_find_property(np, "mmc-hs400-1_2v", &len))
+	if (of_property_read_bool(np, "mmc-hs400-1_2v"))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);


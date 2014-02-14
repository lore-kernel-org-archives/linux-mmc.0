From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: core: Add DT bindings for SD card's UHS bus speed modes
Date: Fri, 14 Feb 2014 13:27:07 +0100
Message-ID: <1392380829-8473-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36071 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaBNM1P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Feb 2014 07:27:15 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so9161793lab.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2014 04:27:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Provide the option to configure these speed modes per host, for those
host driver's that can't distinguish this in runtime.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    5 +++++
 drivers/mmc/core/host.c                       |   10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 458b57f..bd2ce67 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -26,6 +26,11 @@ Optional properties:
   this system, even if the controller claims it is.
 - cap-sd-highspeed: SD high-speed timing is supported
 - cap-mmc-highspeed: MMC high-speed timing is supported
+- sd-uhs-sdr12: SD UHS SDR12 speed is supported
+- sd-uhs-sdr25: SD UHS SDR25 speed is supported
+- sd-uhs-sdr50: SD UHS SDR50 speed is supported
+- sd-uhs-sdr104: SD UHS SDR104 speed is supported
+- sd-uhs-ddr50: SD UHS DDR50 speed is supported
 - cap-power-off-card: powering off the card is safe
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..2644d91 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -419,6 +419,16 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_SD_HIGHSPEED;
 	if (of_find_property(np, "cap-mmc-highspeed", &len))
 		host->caps |= MMC_CAP_MMC_HIGHSPEED;
+	if (of_find_property(np, "sd-uhs-sdr12", &len))
+		host->caps |= MMC_CAP_UHS_SDR12;
+	if (of_find_property(np, "sd-uhs-sdr25", &len))
+		host->caps |= MMC_CAP_UHS_SDR25;
+	if (of_find_property(np, "sd-uhs-sdr50", &len))
+		host->caps |= MMC_CAP_UHS_SDR50;
+	if (of_find_property(np, "sd-uhs-sdr104", &len))
+		host->caps |= MMC_CAP_UHS_SDR104;
+	if (of_find_property(np, "sd-uhs-ddr50", &len))
+		host->caps |= MMC_CAP_UHS_DDR50;
 	if (of_find_property(np, "cap-power-off-card", &len))
 		host->caps |= MMC_CAP_POWER_OFF_CARD;
 	if (of_find_property(np, "cap-sdio-irq", &len))
-- 
1.7.9.5


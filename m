From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: core: Add DT bindings for eMMC high-speed DDR 1.8/1.2V
Date: Fri, 14 Feb 2014 13:27:08 +0100
Message-ID: <1392380829-8473-2-git-send-email-ulf.hansson@linaro.org>
References: <1392380829-8473-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40117 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaBNM1Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Feb 2014 07:27:16 -0500
Received: by mail-lb0-f181.google.com with SMTP id z11so8165057lbi.40
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2014 04:27:15 -0800 (PST)
In-Reply-To: <1392380829-8473-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Provide the option to configure these speed modes per host, for those
host driver's that can't distinguish this in runtime.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
 drivers/mmc/core/host.c                       |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index bd2ce67..519d952 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -34,6 +34,8 @@ Optional properties:
 - cap-power-off-card: powering off the card is safe
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
+- mmc-highspeed-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
+- mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2644d91..d014127 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -439,6 +439,10 @@ int mmc_of_parse(struct mmc_host *host)
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (of_find_property(np, "enable-sdio-wakeup", &len))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (of_find_property(np, "mmc-ddr-1_8v", &len))
+		host->caps |= MMC_CAP_1_8V_DDR;
+	if (of_find_property(np, "mmc-ddr-1_2v", &len))
+		host->caps |= MMC_CAP_1_2V_DDR;
 
 	return 0;
 
-- 
1.7.9.5


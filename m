From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] mmc: add DT bindings for more MMC capability flags
Date: Wed, 23 Jan 2013 17:45:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301231743190.26301@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58535 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab3AWQpO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 11:45:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>

Many MMC capability flags are platform-dependent and are traditionally set
in platform data. With DT often each such capability requires a special
binding. Add bindings for MMC_CAP_SD_HIGHSPEED, MMC_CAP_MMC_HIGHSPEED and
MMC_CAP_POWER_OFF_CARD capabilities. Also add code to DT parser to look
up "keep-power-in-suspend" and "enable-sdio-wakeup" bindings and set
MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ respectively, if found.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Attention: contains new DT bindings, please, comment!

 Documentation/devicetree/bindings/mmc/mmc.txt |    5 ++++-
 drivers/mmc/core/host.c                       |   11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index e180892..92ec534c 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -25,8 +25,11 @@ Optional properties:
 - max-frequency: maximum operating clock frequency
 - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
   this system, even if the controller claims it is.
+- cap-sd-highspeed: SD high-speed timing is supported
+- cap-mmc-highspeed: MMC high-speed timing is supported
+- cap-power-off-card: powering off the card is safe
 
-cd-inverted and wp-inverted properties are deprecated ans shouldn't be used,
+cd-inverted and wp-inverted properties are deprecated and shouldn't be used,
 instead pleaseuse the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings. Note,
 that the default (as defined by the SDHCI standard) CD and WP polarity is
 active-low, so, OF_GPIO_ACTIVE_LOW should normally be set, and only be left
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e4c1cbd..f3ea268 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -372,6 +372,17 @@ void mmc_of_parse(struct mmc_host *host)
 			dev_err(host->parent,
 				"Failed to request WP GPIO: %d!\n", ret);
 	}
+
+	if (of_find_property(np, "cap-sd-highspeed", &len))
+		host->caps |= MMC_CAP_SD_HIGHSPEED;
+	if (of_find_property(np, "cap-mmc-highspeed", &len))
+		host->caps |= MMC_CAP_MMC_HIGHSPEED;
+	if (of_find_property(np, "cap-power-off-card", &len))
+		host->caps |= MMC_CAP_POWER_OFF_CARD;
+	if (of_find_property(np, "keep-power-in-suspend", &len))
+		host->pm_caps |= MMC_PM_KEEP_POWER;
+	if (of_find_property(np, "enable-sdio-wakeup", &len))
+		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 
 EXPORT_SYMBOL(mmc_of_parse);
-- 
1.7.2.5


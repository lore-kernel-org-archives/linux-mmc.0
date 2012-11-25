From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 2/2] mmc: add no-1-8-v device tree flag
Date: Sun, 25 Nov 2012 13:02:54 -0500 (EST)
Message-ID: <20121125180255.DB8ADFAD06@dev.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from swan.laptop.org ([18.85.2.166]:55245 "EHLO swan.laptop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab2KYSJV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 13:09:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, jrudholm@gmail.com, prakity@nvidia.com, devicetree-discuss@lists.ozlabs.org

The OLPC XO-1.75 laptop includes a SDHCI controller which is 1.8v
capable, and it truthfully reports so in its capabilities. This
alternate voltage is used for driving new "UHS-I" SD cards at their
full speed.

However, what the controller doesn't know is that the motherboard
physically doesn't have a 1.8v supply available, so attempting to
switch to the 1.8v level will result in a situation that cannot be
recovered from without physically replugging the SD card.

Add a device tree flag that can be used on systems like these,
and hook it up to the equivalent SDHCI quirk.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 drivers/mmc/host/sdhci-pltfm.c                | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8e2e0ba..3f13702 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -21,6 +21,8 @@ Optional properties:
 - cd-inverted: when present, polarity on the cd gpio line is inverted
 - wp-inverted: when present, polarity on the wp gpio line is inverted
 - max-frequency: maximum operating clock frequency
+- no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
+  this system, even if the controller claims it is.
 
 Example:
 
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 2716445..0a16534 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -78,6 +78,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "broken-cd", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
+		if (of_get_property(np, "no-1-8-v", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+
 		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-- 
1.7.11.7


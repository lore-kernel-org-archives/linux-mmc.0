From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] mmc: sdhci-cadence: add Socionext UniPhier specific compatible string
Date: Wed, 14 Dec 2016 11:10:46 +0900
Message-ID: <1481681446-29832-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-10.nifty.com ([210.131.2.77]:48229 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbcLNCL1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2016 21:11:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Add a Socionext SoC specific compatible (suggested by Rob Herring).

No SoC specific data are associated with the compatible strings for
now, but other SoC vendors may use this IP and want to differentiate
IP variants in the future.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add "uniphier" to the compatible to make it more SoC-specific

 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt | 6 ++++--
 drivers/mmc/host/sdhci-cadence.c                        | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
index 750374f..c0f37cb 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
@@ -1,7 +1,9 @@
 * Cadence SD/SDIO/eMMC Host Controller
 
 Required properties:
-- compatible: should be "cdns,sd4hc".
+- compatible: should be one of the following:
+    "cdns,sd4hc"               - default of the IP
+    "socionext,uniphier-sd4hc" - for Socionext UniPhier SoCs
 - reg: offset and length of the register set for the device.
 - interrupts: a single interrupt specifier.
 - clocks: phandle to the input clock.
@@ -19,7 +21,7 @@ if supported.  See mmc.txt for details.
 
 Example:
 	emmc: sdhci@5a000000 {
-		compatible = "cdns,sd4hc";
+		compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 		reg = <0x5a000000 0x400>;
 		interrupts = <0 78 4>;
 		clocks = <&clk 4>;
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 1501cfd..4b0ecb9 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -262,6 +262,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sdhci_cdns_match[] = {
+	{ .compatible = "socionext,uniphier-sd4hc" },
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
-- 
2.7.4


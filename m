From: Piotr Sroka <piotrs@cadence.com>
Subject: [v2 PATCH 2/3] Documentation: bindings: add description of PHY delays for sdhci-cadence
Date: Mon, 6 Mar 2017 13:39:36 +0000
Message-ID: <1488807576-4571-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from keymaster.Cadence.COM ([158.140.2.26]:33507 "EHLO
        mx-sanjose5.cadence.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbdCFOTs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2017 09:19:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>

Add description of new DLL PHY delays.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v2:
- file was created in v2. It was a part of driver source file patch.
- most delays were moved from dts file 
  to data associated with an SoC specific compatible
- description of delays was updated to be more clearly
---
 .../devicetree/bindings/mmc/sdhci-cadence.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
index c0f37cb..77c4b99 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
@@ -19,6 +19,23 @@ if supported.  See mmc.txt for details.
 - mmc-hs400-1_8v
 - mmc-hs400-1_2v
 
+Some PHY delays can be configured by following properties.
+Each delay property represents the fraction of the clock period.
+The approximate delay value will be
+(<delay property value>/128)*sdmclk_clock_period.
+- phy-dll-delay-sdclk:
+  Value of the delay introduced on the sdclk output
+  for all modes except HS200, HS400 and HS400_ES.
+  Valid range = [0:0x7F].
+- phy-dll-delay-sdclk-hsmmc:
+  Value of the delay introduced on the sdclk output
+  for HS200, HS400 and HS400_ES speed modes.
+  Valid range = [0:0x7F].
+- phy-dll-delay-strobe:
+  Value of the delay introduced on the dat_strobe input
+  used in HS400 / HS400_ES speed modes.
+  Valid range = [0:0x7F].
+
 Example:
 	emmc: sdhci@5a000000 {
 		compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
@@ -29,4 +46,5 @@ Example:
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		mmc-hs400-1_8v;
+		phy-dll-delay-sdclk = <0>;
 	};
-- 
2.2.2


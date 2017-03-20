From: Piotr Sroka <piotrs@cadence.com>
Subject: [v4 2/3] dt-bindings: mmc: add description of PHY delays for sdhci-cadence
Date: Mon, 20 Mar 2017 11:20:42 +0000
Message-ID: <1490008842-26854-1-git-send-email-piotrs@cadence.com>
References: <1490008372-16372-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:46687 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753662AbdCTLWg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 07:22:36 -0400
In-Reply-To: <1490008372-16372-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>

DTS properties are used instead of fixed data
because PHY settings can be different for different chips/boards.
Add description of new DLL PHY delays.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v2:
- file was created in v2. It was a part of driver source file patch.
- most delays were moved from dts file
  to data associated with an SoC specific compatible
- description of delays was updated to be more clearly
---
Changes for v3:
- move all delays back to dts because they are also boards dependent
- prefix all of the Cadence-specific properties with cdns prefix
---
Changes for v4:
- change the beginning of the commit subject
---
 .../devicetree/bindings/mmc/sdhci-cadence.txt      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
index c0f37cb..c341820 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
@@ -19,6 +19,53 @@ if supported.  See mmc.txt for details.
 - mmc-hs400-1_8v
 - mmc-hs400-1_2v
 
+Some PHY delays can be configured by following properties.
+PHY DLL input delays:
+They are used to delay the data valid window, and align the window
+to sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
+and it is increased by 2.5ns in each step.
+- cdns,phy-input-delay-sd-highspeed:
+  Value of the delay in the input path for SD high-speed timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-legacy:
+  Value of the delay in the input path for SD legacy timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-sd-uhs-sdr12:
+  Value of the delay in the input path for SD UHS SDR12 timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-sd-uhs-sdr25:
+  Value of the delay in the input path for SD UHS SDR25 timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-sd-uhs-sdr50:
+  Value of the delay in the input path for SD UHS SDR50 timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-sd-uhs-ddr50:
+  Value of the delay in the input path for SD UHS DDR50 timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-mmc-highspeed:
+  Value of the delay in the input path for MMC high-speed timing
+  Valid range = [0:0x1F].
+- cdns,phy-input-delay-mmc-ddr:
+  Value of the delay in the input path for eMMC high-speed DDR timing
+  Valid range = [0:0x1F].
+
+PHY DLL clock delays:
+Each delay property represents the fraction of the clock period.
+The approximate delay value will be
+(<delay property value>/128)*sdmclk_clock_period.
+- cdns,phy-dll-delay-sdclk:
+  Value of the delay introduced on the sdclk output
+  for all modes except HS200, HS400 and HS400_ES.
+  Valid range = [0:0x7F].
+- cdns,phy-dll-delay-sdclk-hsmmc:
+  Value of the delay introduced on the sdclk output
+  for HS200, HS400 and HS400_ES speed modes.
+  Valid range = [0:0x7F].
+- cdns,phy-dll-delay-strobe:
+  Value of the delay introduced on the dat_strobe input
+  used in HS400 / HS400_ES speed modes.
+  Valid range = [0:0x7F].
+
 Example:
 	emmc: sdhci@5a000000 {
 		compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
@@ -29,4 +76,5 @@ Example:
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		mmc-hs400-1_8v;
+		cdns,phy-dll-delay-sdclk = <0>;
 	};
-- 
2.2.2


From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 05/10] dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
Date: Thu, 26 Jul 2018 15:26:51 +0300
Message-ID: <1532608016-14319-6-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add bindings documentation for pad pull up and pull down offset values to be
programmed before executing automatic pad drive strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 95010cf..c3d8a15 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -24,6 +24,7 @@ Required properties:
 Optional properties:
 - power-gpios : Specify GPIOs for power control
 
+Optional properties for Tegra210 and Tegra186:
 Example:
 
 sdhci@c8000200 {
@@ -47,6 +48,35 @@ Optional properties for Tegra210 and Tegra186:
   pinctrl-1.
 - nvidia,only-1-8-v : The presence of this property indicates that the
   controller operates at a 1.8 V fixed I/O voltage.
+- nvidia,pad-autocal-pull-up-offset-3v3,
+  nvidia,pad-autocal-pull-down-offset-3v3 : Specify drive strength
+  calibration offsets for 3.3 V signaling modes.
+- nvidia,pad-autocal-pull-up-offset-1v8,
+  nvidia,pad-autocal-pull-down-offset-1v8 : Specify drive strength
+  calibration offsets for 1.8 V signaling modes.
+- nvidia,pad-autocal-pull-up-offset-3v3-timeout,
+  nvidia,pad-autocal-pull-down-offset-3v3-timeout : Specify drive
+  strength used as a fallback in case the automatic calibration times
+  out on a 3.3 V signaling mode.
+- nvidia,pad-autocal-pull-up-offset-1v8-timeout,
+  nvidia,pad-autocal-pull-down-offset-1v8-timeout : Specify drive
+  strength used as a fallback in case the automatic calibration times
+  out on a 1.8 V signaling mode.
+- nvidia,pad-autocal-pull-up-offset-sdr104,
+  nvidia,pad-autocal-pull-down-offset-sdr104 : Specify drive strength
+  calibration offsets for SDR104 mode.
+- nvidia,pad-autocal-pull-up-offset-hs400,
+  nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
+  calibration offsets for HS400 mode.
+
+  Notes on the pad calibration pull up and pulldown offset values:
+    - The property values are drive codes which are programmed into the
+      PD_OFFSET and PU_OFFSET sections of the
+      SDHCI_TEGRA_AUTO_CAL_CONFIG register.
+    - A higher value corresponds to higher drive strength. Please refer
+      to the reference manual of the SoC for correct values.
+    - The SDR104 and HS400 timing specific values are used in
+      corresponding modes if specified.
 
 Example:
 sdhci@700b0000 {
@@ -60,5 +90,9 @@ sdhci@700b0000 {
 	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 	pinctrl-0 = <&sdmmc1_3v3>;
 	pinctrl-1 = <&sdmmc1_1v8>;
+	pad-autocal-pull-up-offset-3v3 = <0x00>;
+	pad-autocal-pull-down-offset-3v3 = <0x7d>;
+	pad-autocal-pull-up-offset-1v8 = <0x7b>;
+	pad-autocal-pull-down-offset-1v8 = <0x7b>;
 	status = "disabled";
 };
-- 
2.7.4

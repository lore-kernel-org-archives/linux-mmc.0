From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 04/40] dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
Date: Wed, 1 Aug 2018 19:31:54 +0300
Message-ID: <1533141150-10511-5-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Document the Tegra SDHCI inbound and outbound sampling trimmer values.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 2e973b5..3c7960a 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -68,6 +68,10 @@ Optional properties for Tegra210 and Tegra186:
 - nvidia,pad-autocal-pull-up-offset-hs400,
   nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
   calibration offsets for HS400 mode.
+- nvidia,default-tap : Specify the default inbound sampling clock
+  trimmer value for non-tunable modes.
+- nvidia,default-trim : Specify the default outbound clock trimmer
+  value.
 
   Notes on the pad calibration pull up and pulldown offset values:
     - The property values are drive codes which are programmed into the
@@ -78,6 +82,13 @@ Optional properties for Tegra210 and Tegra186:
     - The SDR104 and HS400 timing specific values are used in
       corresponding modes if specified.
 
+  Notes on tap and trim values:
+    - The values are used for compensating trace length differences
+      by adjusting the sampling point.
+    - The values are programmed to the Vendor Clock Control Register.
+      Please refer to the reference manual of the SoC for correct
+      values.
+
 Example:
 sdhci@700b0000 {
 	compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
-- 
2.7.4

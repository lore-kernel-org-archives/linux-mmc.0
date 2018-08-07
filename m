From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Date: Tue, 7 Aug 2018 16:59:57 +0300
Message-ID: <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Document HS400 DQS trim value device tree property.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 3c7960a..7d294f3 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
   trimmer value for non-tunable modes.
 - nvidia,default-trim : Specify the default outbound clock trimmer
   value.
+- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
 
   Notes on the pad calibration pull up and pulldown offset values:
     - The property values are drive codes which are programmed into the
@@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
     - The values are programmed to the Vendor Clock Control Register.
       Please refer to the reference manual of the SoC for correct
       values.
+    - The DQS trim values are only used on controllers which support
+      HS400 timing.
 
 Example:
 sdhci@700b0000 {
-- 
2.7.4

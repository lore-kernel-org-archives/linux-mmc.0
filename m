From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Date: Tue, 15 Jan 2019 11:03:50 -0800
Message-ID: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add supports-cqe optional property for Tegra SDMMC.

Tegra186 and Tegra194 supports HW Command queue only
on SDMMC4 controller. This property is used to identify
command queue support controller in the tegra sdhci driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 32b4b4e41923..fb14c2c8d7ee 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
 - nvidia,default-trim : Specify the default outbound clock trimmer
   value.
 - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
+- supports-cqe : The presence of this property indicates that the
+  corresponding controller supports HW command queue feature.
+  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
+  controller supports HW Command Queue with eMMC device.
 
   Notes on the pad calibration pull up and pulldown offset values:
     - The property values are drive codes which are programmed into the
-- 
2.7.4

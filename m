From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive strength config
Date: Wed, 2 Jan 2019 12:57:52 -0800
Message-ID: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
Tegra210 sdmmc which has pad configuration registers in the pinmux
reigster domain.
Pad drive strengths for Tegra186 and Later are
part of SDMMC device node itself.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 32b4b4e41923..2cecdc71d94c 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -39,12 +39,16 @@ sdhci@c8000200 {
 	bus-width = <8>;
 };
 
-Optional properties for Tegra210 and Tegra186:
+Optional properties for Tegra210, Tegra186 and Tegra194:
 - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
   configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
   for controllers supporting multiple voltage levels. The order of names
   should correspond to the pin configuration states in pinctrl-0 and
   pinctrl-1.
+- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
+  Tegra210 where pad config registers are in the pinmux register domain
+  for pull-up-strength and pull-down-strength values configuration when
+  using pads at 3V3 and 1V8 levels.
 - nvidia,only-1-8-v : The presence of this property indicates that the
   controller operates at a 1.8 V fixed I/O voltage.
 - nvidia,pad-autocal-pull-up-offset-3v3,
-- 
2.7.4

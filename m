From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 02/40] dt-bindings: mmc: tegra: Add pad voltage control properties
Date: Wed, 1 Aug 2018 19:31:52 +0300
Message-ID: <1533141150-10511-3-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Document the pinctrl bindings used by the SDHCI driver to reconfigure
pad voltages on controllers supporting multiple voltage levels.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 9bce578..90c214d 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -38,3 +38,25 @@ sdhci@c8000200 {
 	power-gpios = <&gpio 155 0>; /* gpio PT3 */
 	bus-width = <8>;
 };
+
+Optional properties for Tegra210 and Tegra186:
+- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
+  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
+  for controllers supporting multiple voltage levels. The order of names
+  should correspond to the pin configuration states in pinctrl-0 and
+  pinctrl-1.
+
+Example:
+sdhci@700b0000 {
+	compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
+	reg = <0x0 0x700b0000 0x0 0x200>;
+	interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
+	clock-names = "sdhci";
+	resets = <&tegra_car 14>;
+	reset-names = "sdhci";
+	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+	pinctrl-0 = <&sdmmc1_3v3>;
+	pinctrl-1 = <&sdmmc1_1v8>;
+	status = "disabled";
+};
-- 
2.7.4

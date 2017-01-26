From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v4 9/13] arm64: allwinner: a64: Add MMC pinctrl nodes
Date: Thu, 26 Jan 2017 10:06:02 +0100
Message-ID: <500c1efeb3a8ec75d60d6ebbea2d1139abf98455.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

The A64 only has a single set of pins for each MMC controller. Since we
already have boards that require all of them, let's add them to the DTSI.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 ++++++++++++++++++++-
 1 file changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d0ee7abe3b87..7b79c319ad3c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -244,6 +244,31 @@
 				function = "i2c1";
 			};
 
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3",
+				       "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC1", "PC5", "PC6", "PC8", "PC9",
+				       "PC10","PC11", "PC12", "PC13",
+				       "PC14", "PC15", "PC16";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			uart0_pins_a: uart0@0 {
 				pins = "PB8", "PB9";
 				function = "uart0";
-- 
git-series 0.8.11

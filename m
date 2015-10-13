From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 4/4] arm64: dts: mediatek:: Add HS200/HS400/SDR50/SDR104 support
Date: Tue, 13 Oct 2015 17:37:58 +0800
Message-ID: <1444729078-26585-5-git-send-email-chaotian.jing@mediatek.com>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Hans de Goede <hdegoede@redhat.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, srv_heup
List-Id: linux-mmc@vger.kernel.org

Add HS200/HS400 support for EMMC
Add SDR50/SDR104 support for SD
Add 400Mhz source clock

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 21 ++++++++++++++++-----
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  5 +++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4be66ca..123dc82 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -70,8 +70,12 @@
 	pinctrl-0 = <&mmc0_pins_default>;
 	pinctrl-1 = <&mmc0_pins_uhs>;
 	bus-width = <8>;
-	max-frequency = <50000000>;
+	max-frequency = <200000000>;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-hw-reset;
+	hs400-ds-delay = <0x14015>;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
 	non-removable;
@@ -83,9 +87,10 @@
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_uhs>;
 	bus-width = <4>;
-	max-frequency = <50000000>;
+	max-frequency = <200000000>;
 	cap-sd-highspeed;
-	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	cd-gpios = <&pio 132 0>;
 	vmmc-supply = <&mt6397_vmch_reg>;
 	vqmmc-supply = <&mt6397_vmc_reg>;
@@ -154,13 +159,19 @@
 				 <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
 				 <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
 			input-enable;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <MTK_DRIVE_4mA>;
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 
 		pins_clk {
 			pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_2mA>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_ds {
+			pinmux = <MT8173_PIN_67_MSDC0_DSL__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_6mA>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
 		};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..3b03d7e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -450,8 +450,9 @@
 			reg = <0 0x11230000 0 0x1000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_MSDC30_0>,
-				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
-			clock-names = "source", "hclk";
+				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
+				 <&topckgen CLK_TOP_MSDCPLL_D2>;
+			clock-names = "source", "hclk", "400mhz";
 			status = "disabled";
 		};
 
-- 
1.8.1.1.dirty

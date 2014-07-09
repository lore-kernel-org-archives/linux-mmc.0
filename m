From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 06/10] ARM: STi: DT: Add sdhci controller for stih415
Date: Wed,  9 Jul 2014 16:07:37 +0100
Message-ID: <1404918461-25390-7-git-send-email-peter.griffin@linaro.org>
References: <1404918461-25390-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404918461-25390-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

This patch adds device tree config for the sdhci controller
on the stih415 SoC.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih415.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index a0f6f75..9198c12 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -218,5 +218,17 @@
 			resets	= <&powerdown STIH415_KEYSCAN_POWERDOWN>,
 				  <&softreset STIH415_KEYSCAN_SOFTRESET>;
 		};
+
+		mmc0: sdhci@fe81e000 {
+			compatible      = "st,sdhci";
+			status          = "disabled";
+			reg             = <0xfe81e000 0x1000>;
+			interrupts      = <GIC_SPI 145 IRQ_TYPE_NONE>;
+			interrupt-names = "mmcirq";
+			pinctrl-names   = "default";
+			pinctrl-0       = <&pinctrl_mmc0>;
+			clock-names     = "mmc";
+			clocks          = <&clk_s_a1_ls 1>;
+		};
 	};
 };
-- 
1.9.1

From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 06/10] ARM: STi: DT: Add sdhci controller for stih415
Date: Wed,  4 Jun 2014 17:07:30 +0100
Message-ID: <1401898054-686-7-git-send-email-peter.griffin@linaro.org>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401898054-686-1-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This patch adds device tree config for the sdhci controller
on the stih415 SoC.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stih415.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index d6f254f..c81dce4 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

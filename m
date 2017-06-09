From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: omap3-overo: Remove "vqmmc-supply" property from MMC dt node
Date: Fri, 9 Jun 2017 14:11:41 +0530
Message-ID: <20170609084141.15582-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

commit 94647a30124e2c7 ("ARM: dts: omap3-overo: Enable WiFi/BT combo")
while enabling WiFi/BT combo added regulator to trigger the nReset
signal of the Bluetooth module in vqmmc-supply. However BT should be
handled by UART. Moreover "vqmmc" is not a defined binding for
omap_hsmmc. While "vqmmc" in mmc2 hasn't caused any issues so far,
mmc2 will start to mis-behave once omap_hsmmc defines "vqmmc"
binding.

Remove "vqmmc-supply" property in mmc2 here.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 401fae838fe9..cd220342a805 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -74,16 +74,6 @@
 		gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;		/* gpio_16: WiFi nReset */
 		startup-delay-us = <10000>;
 	};
-
-	/* Regulator to trigger the nReset signal of the Bluetooth module */
-	w3cbw003c_bt_nreset: regulator-w3cbw003c-bt-nreset {
-		compatible = "regulator-fixed";
-		regulator-name = "regulator-w3cbw003c-bt-nreset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;		/* gpio_164: BT nReset */
-		startup-delay-us = <10000>;
-	};
 };
 
 &omap3_pmx_core {
@@ -191,7 +181,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&w3cbw003c_npoweron>;
-	vqmmc-supply = <&w3cbw003c_bt_nreset>;
 	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
 	bus-width = <4>;
 	cap-sdio-irq;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

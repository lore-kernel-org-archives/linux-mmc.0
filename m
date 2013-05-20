From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V3 07/10] ARM: mvebu: Use standard MMC binding for all users of mvsdio
Date: Tue, 21 May 2013 01:01:48 +0200
Message-ID: <1369090911-1479-8-git-send-email-gmbnomis@gmail.com>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:21542 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335Ab3ETXCg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2013 19:02:36 -0400
In-Reply-To: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

In order to prepare the switch to the standard MMC device tree parser
for mvsdio, adapt all current uses of mvsdio in the dts files to the
standard format.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/armada-370-db.dts                |    1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |    1 +
 arch/arm/boot/dts/armada-370-rd.dts                |    1 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |    4 ++++
 arch/arm/boot/dts/armada-xp-db.dts                 |    1 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |    1 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    2 ++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |    2 +-
 arch/arm/boot/dts/kirkwood-topkick.dts             |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |    4 ++++
 10 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 2353b1f..beee169 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -74,6 +74,7 @@
 				 */
 				status = "disabled";
 				/* No CD or WP GPIOs */
+				broken-cd;
 			};
 
 			usb@50000 {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 14e36e1..45b1077 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -99,6 +99,7 @@
 				 * No CD or WP GPIOs: SDIO interface used for
 				 * Wifi/Bluetooth chip
 				 */
+				 broken-cd;
 			};
 
 			usb@50000 {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 130f839..89c2110 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -64,6 +64,7 @@
 				pinctrl-names = "default";
 				status = "okay";
 				/* No CD or WP GPIOs */
+				broken-cd;
 			};
 
 			usb@50000 {
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 272bbc6..031894e 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -142,6 +142,10 @@
 				reg = <0xd4000 0x200>;
 				interrupts = <54>;
 				clocks = <&gateclk 17>;
+				bus-width = <4>;
+				cap-sdio-irq;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index d6cc8bf..7c22a20 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -97,6 +97,7 @@
 				pinctrl-names = "default";
 				status = "okay";
 				/* No CD or WP GPIOs */
+				broken-cd;
 			};
 
 			usb@50000 {
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 289e51d..be16a84 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -79,6 +79,7 @@
 			pinctrl-names = "default";
 			status = "okay";
 			/* No CD or WP GPIOs */
+			broken-cd;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index 44fd97d..484a2a6 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -72,6 +72,8 @@
 
 		mvsdio@90000 {
 			status = "okay";
+			/* No CD or WP GPIOs */
+			broken-cd;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 7588241..bf3a58c 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -136,7 +136,7 @@
 			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
 			pinctrl-names = "default";
 			status = "okay";
-			cd-gpios = <&gpio1 15 0>;
+			cd-gpios = <&gpio1 15 1>;
 			/* No WP GPIO */
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 66eb45b..7dc14f4 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -154,6 +154,7 @@
 			pinctrl-names = "default";
 			status = "okay";
 			/* No CD or WP GPIOs */
+			broken-cd;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index fada7e6..e2a28db 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -200,6 +200,10 @@
 			reg = <0x90000 0x200>;
 			interrupts = <28>;
 			clocks = <&gate_clk 4>;
+			bus-width = <4>;
+			cap-sdio-irq;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5


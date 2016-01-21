From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 14/15] ARM: dts: sun9i: a80-optimus: Enable hardware reset and HS-DDR for eMMC
Date: Thu, 21 Jan 2016 13:26:41 +0800
Message-ID: <1453354002-28366-15-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

mmc2 has a special pin for eMMC hardware reset, which is controllable
from the controller. Add the "mmc-cap-hw-reset" property to denote that
this controller supports this function, and the pins are actually used.

Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index c0060e4f7379..958160e40fd0 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -174,9 +174,15 @@
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+};
+
 &reg_usb1_vbus {
 	pinctrl-0 = <&usb1_vbus_pin_optimus>;
 	gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-- 
2.7.0.rc3

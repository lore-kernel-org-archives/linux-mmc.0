From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 11/15] ARM: dts: sun8i: sina33: Enable hardware reset and HS-DDR for eMMC
Date: Thu, 21 Jan 2016 13:26:38 +0800
Message-ID: <1453354002-28366-12-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54948 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934079AbcAUFdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:41 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

mmc2 has a special pin for eMMC hardware reset, which is controllable
from the controller. Add the "mmc-cap-hw-reset" property to denote that
this controller supports this function, and the pins are actually used.

Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 13ce68f06dd6..bd2a3beb4629 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -109,10 +109,13 @@
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
 &mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 	/* eMMC is missing pull-ups */
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
-- 
2.7.0.rc3


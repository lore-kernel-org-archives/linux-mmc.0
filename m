From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 10/15] ARM: dts: sun8i: Include SDC2_RST pin in mmc2_8bit_pins
Date: Thu, 21 Jan 2016 13:26:37 +0800
Message-ID: <1453354002-28366-11-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

mmc2_8bit_pins is used with eMMC chips, which also have a reset pin.
The MMC controller also has a reset output that is supported.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 6f88fb0ddbc7..7e05e09e61c7 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -381,7 +381,7 @@
 				allwinner,pins = "PC5", "PC6", "PC8",
 						 "PC9", "PC10", "PC11",
 						 "PC12", "PC13", "PC14",
-						 "PC15";
+						 "PC15", "PC16";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.7.0.rc3

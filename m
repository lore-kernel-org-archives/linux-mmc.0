From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 4/4] arm: dts: rockchip: Enable post_ios_power_on and pre-power-on-delay-ms
Date: Mon,  6 Mar 2017 15:17:16 +0100
Message-ID: <20170306141716.19120-5-romain.perier@collabora.com>
References: <20170306141716.19120-1-romain.perier@collabora.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57611 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdCFORu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2017 09:17:50 -0500
In-Reply-To: <20170306141716.19120-1-romain.perier@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

This enables the property post_ios_power_on. With this property, the
driver pwrseq_simple will do its entire power sequence at the end of the
mmc_power_up() function. The property pre-power-on-delay-ms adds a delay
of 1ms between the enablement of the clk and the assertion of the reset
line.

It fixes the power-up sequence for the Wifi chipset AP6335.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3288-rock2-square.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 818c4bf..9bf2991 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -106,6 +106,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable>;
 		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		pre-power-on-delay-ms = <1>;
+		post-ios-power-on;
 	};
 
 	vcc_usb_host: vcc-host-regulator {
-- 
2.9.3


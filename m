From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 14/14] ARM: dts: exynos: Fix LAN and HUB after bootloader
 initialization on Odroid U3
Date: Thu, 09 Jun 2016 11:44:31 +0200
Message-ID: <1465465471-28740-15-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@v
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Odroid U3 (Exynos4412-based) board if USB was initialized by
bootloader (in U-Boot "usb start" before tftpboot), the HUB (usb3503)
and LAN (smsc95xx) after after successful probing were not visible in the
system ("lsusb").

In such case the devices had to be fully reset before configuring.
Reset by GPIO (called RESET_N pin) and by RESET field in STCD register
in usb3503 HUB are not sufficient. Instead full reset has to be done by
disabling and enabling regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 31cdc036fda4..8fd50061d91b 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -99,11 +99,15 @@
 	clock-names = "refclk";
 	clocks = <&pmu_system_controller 0>;
 	refclk-frequency = <24000000>;
+
+	power-sequence;
+	vdd-supply = <&buck8_reg>;
 };
 
 &ehci {
 	port@1 {
 		status = "okay";
+		usb-pwrseq = <&usb3503>;
 	};
 	port@2 {
 		status = "okay";
-- 
1.9.1

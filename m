From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 7/8] ARM: dts: bcm283x: switch from &sdhci to &sdhost
Date: Fri,  3 Feb 2017 13:11:52 +0100
Message-ID: <1486123913-31705-8-git-send-email-kraxel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-mmc@vger.kernel.org

sdcard access with the sdhost controller is faster.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 7d89af2..e6beecb 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -65,13 +65,13 @@
 &sdhci {
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio48>;
-	status = "okay";
 	bus-width = <4>;
 };
 
 &sdhost {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdhost_gpio48>;
+	status = "okay";
 	bus-width = <4>;
 };
 
-- 
1.8.3.1

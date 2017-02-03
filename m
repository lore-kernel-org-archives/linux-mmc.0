From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/8] mmc: bcm2835: add sdhost controller to devicetree
Date: Fri,  3 Feb 2017 13:11:48 +0100
Message-ID: <1486123913-31705-4-git-send-email-kraxel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 0b73f9c..7d89af2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -69,6 +69,12 @@
 	bus-width = <4>;
 };
 
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	bus-width = <4>;
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index a3106aa..180f359 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -450,6 +450,16 @@
 			status = "disabled";
 		};
 
+		sdhost: mmc@7e202000 {
+			compatible = "brcm,bcm2835-sdhost";
+			reg = <0x7e202000 0x100>;
+			interrupts = <2 24>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
+			dmas = <&dma 13>, <&dma 13>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		hvs@7e400000 {
 			compatible = "brcm,bcm2835-hvs";
 			reg = <0x7e400000 0x6000>;
-- 
1.8.3.1

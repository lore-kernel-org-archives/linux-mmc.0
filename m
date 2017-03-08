From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 3/7] mmc: bcm2835: add sdhost controller to devicetree
Date: Wed,  8 Mar 2017 10:19:05 +0100
Message-ID: <1488964751-22763-6-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lee@kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 1e00a28..8b95832 100644
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
index 9798bc9..19099a5 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -350,6 +350,16 @@
 			arm,primecell-periphid = <0x00241011>;
 		};
 
+		sdhost: mmc@7e202000 {
+			compatible = "brcm,bcm2835-sdhost";
+			reg = <0x7e202000 0x100>;
+			interrupts = <2 24>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>;
+			dmas = <&dma 13>;
+			dma-names = "rx-tx";
+			status = "disabled";
+		};
+
 		i2s: i2s@7e203000 {
 			compatible = "brcm,bcm2835-i2s";
 			reg = <0x7e203000 0x20>,
-- 
1.8.3.1

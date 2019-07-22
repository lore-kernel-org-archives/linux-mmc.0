From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 05/18] ARM: dts: bcm283x: Define memory at board level
Date: Mon, 22 Jul 2019 07:54:36 +0200
Message-ID: <1563774880-8061-6-git-send-email-wahrenst@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org

Now with the varity of several RPi boards, the memory should be defined
at board level. This step gives us the chance to fix the memory size
of the RPi 1 B+, Zero (incl. W) and Compute Module 1.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts   | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-a.dts        | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts   | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts   | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-b.dts        | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi     | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts   | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts     | 5 +++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi         | 5 -----
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 1 +
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 1 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi     | 1 +
 14 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index cb3f08d..5b42e9a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -8,6 +8,11 @@
 	compatible = "raspberrypi,model-a-plus", "brcm,bcm2835";
 	model = "Raspberry Pi Model A+";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 2d167d9..b716214 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -8,6 +8,11 @@
 	compatible = "raspberrypi,model-a", "brcm,bcm2835";
 	model = "Raspberry Pi Model A";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 83a3a60..3318082 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -9,6 +9,11 @@
 	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
 	model = "Raspberry Pi Model B+";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x20000000>;
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index b6b4fea..97d7eb5 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -9,6 +9,11 @@
 	compatible = "raspberrypi,model-b-rev2", "brcm,bcm2835";
 	model = "Raspberry Pi Model B rev2";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index b5782fa..37e02a1 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -9,6 +9,11 @@
 	compatible = "raspberrypi,model-b", "brcm,bcm2835";
 	model = "Raspberry Pi Model B";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x10000000>;
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi b/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
index ef22c2d..58059c2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
@@ -10,6 +10,11 @@
 		};
 	};

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x20000000>;
+	};
+
 	reg_3v3: fixed-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 5ecc403..f38f388 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -12,6 +12,11 @@
 	compatible = "raspberrypi,model-zero-w", "brcm,bcm2835";
 	model = "Raspberry Pi Zero W";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x20000000>;
+	};
+
 	chosen {
 		/* 8250 auxiliary UART instead of pl011 */
 		stdout-path = "serial1:115200n8";
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index 84c7035..5fd0686 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -12,6 +12,11 @@
 	compatible = "raspberrypi,model-zero", "brcm,bcm2835";
 	model = "Raspberry Pi Zero";

+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x20000000>;
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 40bac52e..f5125b7 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,11 +1,6 @@
 #include <dt-bindings/power/raspberrypi-power.h>

 / {
-	memory@0 {
-		device_type = "memory";
-		reg = <0 0x10000000>;
-	};
-
 	leds {
 		compatible = "gpio-leds";

diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index f97ec95..6a89999 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -10,6 +10,7 @@
 	model = "Raspberry Pi 2 Model B";

 	memory@0 {
+		device_type = "memory";
 		reg = <0 0x40000000>;
 	};

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
index 7f4437a..0e29aaa 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -14,6 +14,7 @@
 	};

 	memory@0 {
+		device_type = "memory";
 		reg = <0 0x20000000>;
 	};

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index c6fa34c..a1487ae 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -15,6 +15,7 @@
 	};

 	memory@0 {
+		device_type = "memory";
 		reg = <0 0x40000000>;
 	};

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index ce71f57..a36bfdb 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -15,6 +15,7 @@
 	};

 	memory@0 {
+		device_type = "memory";
 		reg = <0 0x40000000>;
 	};

diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
index 81399b2..7c3cb7e 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
@@ -5,6 +5,7 @@

 / {
 	memory@0 {
+		device_type = "memory";
 		reg = <0 0x40000000>;
 	};

--
2.7.4

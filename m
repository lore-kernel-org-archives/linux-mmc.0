Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6D7C19F39
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3803B60F38
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhHGLHr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhHGLHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:45 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhUQ7-1mpnqe10N9-00eeQQ; Sat, 07 Aug 2021 13:07:11 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 06/10] ARM: dts: bcm283x-rpi: Move Wifi/BT into separate dtsi
Date:   Sat,  7 Aug 2021 13:06:37 +0200
Message-Id: <1628334401-6577-7-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:QmjLhRlmSvymuTwXZC2Fma9HjVesmN+wkmjc/fvETI6wB+MsCTW
 Yiqq6XGCBkypDc74pPhM6wM6gj1QqQ1T+sqq86GozDW4pCpQ/PLnS60fpcxQY699chlA1a+
 Hz3Q7EUk1jnkeqaHar+r0K94Tuhgiozxqn7UtrsC0EkZDyHqJJZT9mus/wonjlhV41T5rFW
 WmbStwCGU+huPk/ABzXWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:usvl7TM8DkQ=:FbuLfKL4eZgnYN/6DODpAY
 n2mS2duxtMGfzH2X8cOCldlA81fx1wGqna4EPEF5o9jjtOef3gmfqtwVeZMcN1oADKIVEREl6
 yzoLV89cYLx4z8nx7rwWsZyIeWtm+dN9CsO9H/GqqsjmwQ7TkgeDiNVG6KBWLAUE3oMyuCIXm
 gBN8TG9iFRKfmifbfHmRWmIzkfuX+qUAN0wL2U1+mbkKmka97nB5vb2NuYqyvxSMy81wZZ5pR
 6MC264gIiEEGNcoCkIRQxCczIe2ycuLjOszou2OWrzG5Ys9xJOC158eBJf4aSGioDzs3nBE3L
 ldEg+nDxxeINobYuZfJDtozAkBzoDkazfGGe9TzxvCpB5R7gvzjLJgBOS1SYt/X/09Gj5HGwA
 mhBzfXezB3pBbnMrvApmpOmN1H3WlH3dWkehUwXN1R6VAxii6w1arYqkqiSBSgxtwCvwI5SiN
 egsGLRdHMSzoMLmQn57yR2SKMOcUekfkPScrnwztCupHi23e0c2Ta3m8zt/DyTfpH5TmNgcur
 UkBw4ILbphkKo+859v9v5Agy6KEkXFbtQtJQBLQ5Dqu9dEYM4a4X8NAmsJVl7YtB+d2bAJQnn
 1uO3bUBLcMD1NPKDI4mCpq2qYsGebVKJ+17mCaQl97U0AtwTKfsNG1c6r1JUpyjvNRIWOXU4E
 tRYEYYg3De2oAHSqCaMMDO1YjQ9onkunhaqUf0AoNnHnEXI3KsNlWcD8mYqvxQQrmrGDEIaxn
 oIv2ZY1hCFOCNxI8qwTDF+ChGzeNTlYrLJDrkfXMkcc+aTg9jd4igzt1tpVOmqMlhT3uF+/JL
 SZVYvDraN/gvyXO0n0EJIE5FciaF+bmRnYD1pZ4FmL9+woyNKSDnEZaY5+7ILFJFqqk915Sp+
 WD3Y/AU92HAA+02k9fvA==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A Wifi/BT chip is quite common for the Raspberry Pi boards. So move those
definitions into a separate dtsi in order to avoid copy & paste. This
change was inspired by a vendor tree patch from Phil Elwell.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts      | 38 +++++++-----------------------
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts   | 31 +++++++-----------------
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 36 ++++++----------------------
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 36 +++++++---------------------
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 36 +++++++---------------------
 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi | 34 ++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index abf8298..c54ba5cf 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -3,6 +3,7 @@
 #include "bcm2711.dtsi"
 #include "bcm2711-rpi.dtsi"
 #include "bcm283x-rpi-usb-peripheral.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
@@ -26,11 +27,6 @@
 		};
 	};
 
-	wifi_pwrseq: wifi-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
-	};
-
 	sd_io_1v8_reg: sd_io_1v8_reg {
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-sd-io";
@@ -56,6 +52,10 @@
 	};
 };
 
+&bt {
+	shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
+};
+
 &ddc0 {
 	status = "okay";
 };
@@ -178,23 +178,6 @@
 	status = "okay";
 };
 
-/* SDHCI is used to control the SDIO for wireless */
-&sdhci {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_gpio34>;
-	bus-width = <4>;
-	non-removable;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
 /* EMMC2 is used to drive the SD card */
 &emmc2 {
 	vqmmc-supply = <&sd_io_1v8_reg>;
@@ -236,13 +219,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32>;
 	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <2000000>;
-		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
-	};
 };
 
 /* uart1 is mapped to the pin header */
@@ -259,3 +235,7 @@
 &vec {
 	status = "disabled";
 };
+
+&wifi_pwrseq {
+	reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 33b2b77..243236b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -7,6 +7,7 @@
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-usb-otg.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
 
 / {
 	compatible = "raspberrypi,model-zero-w", "brcm,bcm2835";
@@ -27,11 +28,10 @@
 			gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
 		};
 	};
+};
 
-	wifi_pwrseq: wifi-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
-	};
+&bt {
+	shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
 };
 
 &gpio {
@@ -110,19 +110,7 @@
 };
 
 &sdhci {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
-	bus-width = <4>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	non-removable;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
 };
 
 &sdhost {
@@ -135,13 +123,6 @@
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <2000000>;
-		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
-	};
 };
 
 &uart1 {
@@ -149,3 +130,7 @@
 	pinctrl-0 = <&uart1_gpio14>;
 	status = "okay";
 };
+
+&wifi_pwrseq {
+	reset-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
index 77099a7..d73daf5 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -3,6 +3,7 @@
 #include "bcm2837.dtsi"
 #include "bcm2836-rpi.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
 
 / {
 	compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
@@ -130,28 +131,6 @@
 	status = "okay";
 };
 
-/*
- * SDHCI is used to control the SDIO for wireless
- *
- * WL_REG_ON and BT_REG_ON of the CYW43455 Wifi/BT module are driven
- * by a single GPIO. We can't give GPIO control to one of the drivers,
- * otherwise the other part would get unexpectedly disturbed.
- */
-&sdhci {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_gpio34>;
-	status = "okay";
-	bus-width = <4>;
-	non-removable;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
 /* SDHOST is used to drive the SD card */
 &sdhost {
 	pinctrl-names = "default";
@@ -160,16 +139,15 @@
 	bus-width = <4>;
 };
 
-/* uart0 communicates with the BT module */
+/* uart0 communicates with the BT module
+ *
+ * WL_REG_ON and BT_REG_ON of the CYW43455 Wifi/BT module are driven
+ * by a single GPIO. We can't give GPIO control to one of the drivers,
+ * otherwise the other part would get unexpectedly disturbed.
+ */
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32 &gpclk2_gpio43>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <2000000>;
-	};
 };
 
 /* uart1 is mapped to the pin header */
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index 6101026..e12938b 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -4,6 +4,7 @@
 #include "bcm2836-rpi.dtsi"
 #include "bcm283x-rpi-lan7515.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
 
 / {
 	compatible = "raspberrypi,3-model-b-plus", "brcm,bcm2837";
@@ -31,11 +32,10 @@
 			linux,default-trigger = "default-on";
 		};
 	};
+};
 
-	wifi_pwrseq: wifi-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
-	};
+&bt {
+	shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
 };
 
 &firmware {
@@ -137,23 +137,6 @@
 	status = "okay";
 };
 
-/* SDHCI is used to control the SDIO for wireless */
-&sdhci {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_gpio34>;
-	status = "okay";
-	bus-width = <4>;
-	non-removable;
-	mmc-pwrseq = <&wifi_pwrseq>;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
 /* SDHOST is used to drive the SD card */
 &sdhost {
 	pinctrl-names = "default";
@@ -166,13 +149,6 @@
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32 &gpclk2_gpio43>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <2000000>;
-		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
-	};
 };
 
 /* uart1 is mapped to the pin header */
@@ -181,3 +157,7 @@
 	pinctrl-0 = <&uart1_gpio14>;
 	status = "okay";
 };
+
+&wifi_pwrseq {
+	reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index dd4a486..42b5383 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -4,6 +4,7 @@
 #include "bcm2836-rpi.dtsi"
 #include "bcm283x-rpi-smsc9514.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
 
 / {
 	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
@@ -24,11 +25,10 @@
 			gpios = <&expgpio 2 GPIO_ACTIVE_HIGH>;
 		};
 	};
+};
 
-	wifi_pwrseq: wifi-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
-	};
+&bt {
+	shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
 };
 
 &firmware {
@@ -134,13 +134,6 @@
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <2000000>;
-		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
-	};
 };
 
 /* uart1 is mapped to the pin header */
@@ -150,23 +143,6 @@
 	status = "okay";
 };
 
-/* SDHCI is used to control the SDIO for wireless */
-&sdhci {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_gpio34>;
-	status = "okay";
-	bus-width = <4>;
-	non-removable;
-	mmc-pwrseq = <&wifi_pwrseq>;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
 /* SDHOST is used to drive the SD card */
 &sdhost {
 	pinctrl-names = "default";
@@ -174,3 +150,7 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&wifi_pwrseq {
+	reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi b/arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
new file mode 100644
index 0000000..0b64cc1
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+	};
+};
+
+/* SDHCI is used to control the SDIO for wireless */
+&sdhci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio34>;
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* uart0 communicates with the BT module */
+&uart0 {
+	status = "okay";
+
+	bt: bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <2000000>;
+	};
+};
-- 
2.7.4


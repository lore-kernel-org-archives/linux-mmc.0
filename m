From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND 3/3] arm64: dts: r8a7795: salvator-x: enable SDHI0
 & 3
Date: Mon, 22 Feb 2016 13:35:30 +0900
Message-ID: <20160222043530.GA16107@verge.net.au>
References: <1455548510-1690-1-git-send-email-wsa@the-dreams.de>
 <1455548510-1690-4-git-send-email-wsa@the-dreams.de>
 <20160219175823.GA1392@katana>
 <20160222023910.GA19765@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43422 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbcBVEfj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Feb 2016 23:35:39 -0500
Content-Disposition: inline
In-Reply-To: <20160222023910.GA19765@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, Feb 22, 2016 at 11:39:12AM +0900, Simon Horman wrote:
> On Fri, Feb 19, 2016 at 06:58:23PM +0100, Wolfram Sang wrote:
> > On Mon, Feb 15, 2016 at 04:01:50PM +0100, Wolfram Sang wrote:
> > > From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > > 
> > > Add the exposed SD card slots. The on-board eMMC needs to wait until we
> > > fixed the 8bit support (it works with 4bit if you really want it now).
> > > 
> > > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Simon, if you apply this, can you drop the sentence inside the brackets?
> > It is probably not true until I fix the timeout handling. Or do you want
> > me to resend?
> 
> 
> Sure, I have dropped the text in ().
> 
> 
> I have queued up the following after resolving a minor conflict.
> There was also some fuzz when I applied patch 2/2 so I'd appreciate it if
> you could double check that too.

There was a syntax error in my previous effort.
Please look over this one instead.

From: Ai Kyuse <ai.kyuse.uw@renesas.com>
Date: Mon, 15 Feb 2016 16:01:50 +0100
Subject: [PATCH] arm64: dts: r8a7795: salvator-x: enable SDHI0 & 3

Add the exposed SD card slots. The on-board eMMC needs to wait until we
fixed the 8bit support.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 31ace9c1f79d..1af67579e07a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -33,6 +33,7 @@
 
 /dts-v1/;
 #include "r8a7795.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Renesas Salvator-X board based on r8a7795";
@@ -61,6 +62,54 @@
 		clock-frequency = <24576000>;
 	};
 
+	vcc_sdhi0: regulator@1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator@2 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi3: regulator@3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI3 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi3: regulator@4 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI3 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
 	audio_clkout: audio_clkout {
 		/*
 		 * This is same as <&rcar_sound 0>
@@ -119,6 +168,16 @@
 		renesas,function = "avb";
 	};
 
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi3_pins: sd3 {
+		renesas,groups = "sdhi3_data4", "sdhi3_ctrl";
+		renesas,function = "sdhi3";
+	};
+
 	sound_pins: sound {
 		renesas,groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
 		renesas,function = "ssi";
@@ -228,6 +287,30 @@
 	status = "okay";
 };
 
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&sdhi3 {
+	pinctrl-0 = <&sdhi3_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi3>;
+	vqmmc-supply = <&vccq_sdhi3>;
+	cd-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &ssi1 {
 	shared-pin;
 };
-- 
2.1.4


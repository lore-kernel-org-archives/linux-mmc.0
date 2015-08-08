From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH] ARM: dts: rockchip: Add wifi support for firefly
Date: Sat, 08 Aug 2015 23:05:53 +0200
Message-ID: <5702275.SOOuh5NPWf@diego>
References: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart6770447.510etFuR2m"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:59116 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992726AbbHHVF5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Aug 2015 17:05:57 -0400
In-Reply-To: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, dianders@chromium.org, romain.perier@gmail.com, FUKAUMI Naoki <naobsd@gmail.com>

This is a multi-part message in MIME format.

--nextPart6770447.510etFuR2m
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Michael,

Am Freitag, 7. August 2015, 16:12:05 schrieb Michael Trimarchi:
> This patch enable wifi support for the firefly board.
> Card answer to me that support from 2.0V but regulator is connected
> to 1.8V, so voltage capability is wrong. In order to avoid this
> we just defined a fixed regulator trigger by the wifi enable gpio
> that report 2.0V.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/rk3288-firefly.dtsi | 43
> +++++++++++++++++++++++++++++++++-- 1 file changed, 41 insertions(+), 2
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi
> b/arch/arm/boot/dts/rk3288-firefly.dtsi index 0b42372..fcf234e 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -116,6 +116,28 @@
>  		vin-supply = <&vcc_io>;
>  	};
> 
> +	io_domains: io-domains {
> +		compatible = "rockchip,rk3288-io-voltage-domain";
> +		rockchip,grf = <&grf>;
> +
> +		wifi-supply = <&vcc_18>;
> +		audio-supply = <&vcca_33>;
> +	};

should be a separate patch and include the other interesting io-domains as 
well.

> +
> +	vcc_wifi: wifi-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdio0_pwr>;
> +		regulator-name = "vcc_wifi";
> +		regulator-min-microvolt = <2000000>;
> +		regulator-max-microvolt = <2000000>;
> +		startup-delay-us = <100000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +
>  	vcc_flash: flash-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc_flash";
> @@ -437,13 +459,30 @@
>  &sdio0 {
>  	broken-cd;
>  	bus-width = <4>;
> +	clock-freq-min-max = <400000 50000000>;
>  	disable-wp;
>  	non-removable;
> +	cap-sd-highspeed;
>  	num-slots = <1>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
> -	vmmc-supply = <&vcc_18>;
> +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
> +
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	sd-uhs-ddr50;

we don't have mmc tuning capabilities yet, so please no sd-uhs-* stuff. That 
way you should also be able to leave out the clock-freq-min-max above, as 
regular "highspeed" does not venture above the 50MHz limit.

> +	cap-sdio-irq;
> +
> +	vmmc-supply = <&vcc_wifi>;

the original supply is actually wrong in the dts. vcc_18 is the io voltage 
used on the 
pins _to_ the card, not to supply the card itself. So vcc_18 is actually the 
so called vqmmc-supply.
vmmc-supply is done regularly from vcc_io. So your voltage hack above can go 
away too.

Bringup should also use a mmc-power-sequency so you can make sure the 
rtc_clock is running, which is also needed by the wifi module.


>  	status = "okay";

missing #address-cells and #size-cells values for the subnodes

> +
> +	brcmf: bcrmf@0 {
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&gpio4>;
> +		reg = <0>;
> +		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "host-wake";
> +		status = "okay";
> +	};
>  };
> 
>  &sdmmc {

I took the liberty to move stuff around how it should look like, but did not 
find the time to actually test this. So maybe you can take a look at the 
attached patches.


Heiko
--nextPart6770447.510etFuR2m
Content-Disposition: attachment; filename="0001-ARM-dts-rockchip-add-rk3288-firefly-io-domains.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-ARM-dts-rockchip-add-rk3288-firefly-io-domains.patch"

>From 1a255ca2a4281b6257eca95ed3edabe74818bc1e Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 8 Aug 2015 22:14:57 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: add rk3288-firefly io-domains

This adds the io-domain description for the different io supplies on
the rk3288 firefly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 20fa0ef..0b2b496 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -55,6 +55,20 @@
 		clock-output-names = "ext_gmac";
 	};
 
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		audio-supply = <&vcca_33>;
+		bb-supply = <&vcc_io>;
+		flash0-supply = <&vcc_flash>;
+		gpio1830-supply = <&vcc_io>;
+		gpio30-supply = <&vcc_io>;
+		lcdc-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		pinctrl-names = "default";
@@ -325,7 +339,12 @@
 				regulator-always-on;
 			};
 
-			vcc_18: REG11 {
+			/*
+			 * vcc_18 has an alias named vccio_wl.  We'll add this
+			 * aliase here just to make it easier to follow the
+			 * schematic.
+			 */
+			vccio_wl: vcc_18: REG11 {
 				regulator-name = "vcc_18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-- 
2.1.4


--nextPart6770447.510etFuR2m
Content-Disposition: attachment; filename="0002-ARM-dts-rockchip-add-address-and-size-cells-to-dw-ms.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-ARM-dts-rockchip-add-address-and-size-cells-to-dw-ms.patch"

>From e89204f15a1c1c9066013e2517bc5bb80d067601 Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 8 Aug 2015 22:37:52 +0200
Subject: [PATCH 2/3] ARM: dts: rockchip: add #address- and #size-cells to
 dw-mshc nodes

The mmc subsystem allows to specifiy function subnodes to specify data
for embedded boards like wifi sdio modules use there.
The address of these submodules is the slot-id they are connected to,
so set #address-cells and #size-cells accordingly to prevent boards from
having to repeat these settings in each dts.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++++++
 arch/arm/boot/dts/rk3xxx.dtsi | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..7bd0a30 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -227,6 +227,8 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0c0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -238,6 +240,8 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0d0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -249,6 +253,8 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0e0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -260,6 +266,8 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0f0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4497d28..e09b752 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -218,6 +218,8 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <256>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -228,6 +230,8 @@
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <256>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
@@ -238,6 +242,8 @@
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <256>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
-- 
2.1.4


--nextPart6770447.510etFuR2m
Content-Disposition: attachment; filename="0003-ARM-dts-rockchip-Add-wifi-support-for-firefly.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-ARM-dts-rockchip-Add-wifi-support-for-firefly.patch"

>From 62bd4e7d8e78296089a675575df4354e605723c9 Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Fri, 7 Aug 2015 16:12:05 +0200
Subject: [PATCH 3/3] ARM: dts: rockchip: Add wifi support for firefly

This patch enables wifi support for the firefly board.

The core supply of the wifi modules comes from vcc_io but aliased to
vbat_wl, so add this alias too to make reading the schematics easier.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 38 ++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 0b2b496..506bd00 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -110,6 +110,17 @@
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_reg_on>;
+
+		/* On the module itself this is WL_REG_ON */
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	};
+
 	vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -428,6 +439,12 @@
 		};
 	};
 
+	sdio {
+		wifi_reg_on: wifi-reg-on {
+			rockchip,pins = <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_pwr: sdmmc-pwr {
 			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -457,15 +474,30 @@
 };
 
 &sdio0 {
+	status = "okay";
+
 	broken-cd;
 	bus-width = <4>;
 	disable-wp;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
-	vmmc-supply = <&vcc_18>;
-	status = "okay";
+	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vccio_wl>;
+
+	brcmf: bcrmf@0 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
+		status = "okay";
+	};
 };
 
 &sdmmc {
-- 
2.1.4


--nextPart6770447.510etFuR2m--


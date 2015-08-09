From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [RFC PATCH] ARM: dts: rockchip: Add wifi support for firefly
Date: Sun, 9 Aug 2015 10:26:44 +0200
Message-ID: <20150809082640.GA5459@panicking>
References: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com>
 <5702275.SOOuh5NPWf@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37433 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932911AbbHII0W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Aug 2015 04:26:22 -0400
Received: by wibhh20 with SMTP id hh20so113474528wib.0
        for <linux-mmc@vger.kernel.org>; Sun, 09 Aug 2015 01:26:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5702275.SOOuh5NPWf@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, dianders@chromium.org, romain.perier@gmail.com, FUKAUMI Naoki <naobsd@gmail.com>

Hi

On Sat, Aug 08, 2015 at 11:05:53PM +0200, Heiko St=FCbner wrote:
> Hi Michael,
>=20
> Am Freitag, 7. August 2015, 16:12:05 schrieb Michael Trimarchi:
> > This patch enable wifi support for the firefly board.
> > Card answer to me that support from 2.0V but regulator is connected
> > to 1.8V, so voltage capability is wrong. In order to avoid this
> > we just defined a fixed regulator trigger by the wifi enable gpio
> > that report 2.0V.
> >=20
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >  arch/arm/boot/dts/rk3288-firefly.dtsi | 43
> > +++++++++++++++++++++++++++++++++-- 1 file changed, 41 insertions(+=
), 2
> > deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi
> > b/arch/arm/boot/dts/rk3288-firefly.dtsi index 0b42372..fcf234e 1006=
44
> > --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> > +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> > @@ -116,6 +116,28 @@
> >  		vin-supply =3D <&vcc_io>;
> >  	};
> >=20
> > +	io_domains: io-domains {
> > +		compatible =3D "rockchip,rk3288-io-voltage-domain";
> > +		rockchip,grf =3D <&grf>;
> > +
> > +		wifi-supply =3D <&vcc_18>;
> > +		audio-supply =3D <&vcca_33>;
> > +	};
>=20
> should be a separate patch and include the other interesting io-domai=
ns as=20
> well.
>=20

Yes, fine

> > +
> > +	vcc_wifi: wifi-regulator {
> > +		compatible =3D "regulator-fixed";
> > +		enable-active-high;
> > +		gpio =3D <&gpio4 28 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&sdio0_pwr>;
> > +		regulator-name =3D "vcc_wifi";
> > +		regulator-min-microvolt =3D <2000000>;
> > +		regulator-max-microvolt =3D <2000000>;
> > +		startup-delay-us =3D <100000>;
> > +		regulator-always-on;
> > +		vin-supply =3D <&vcc_io>;
> > +	};
> > +
> >  	vcc_flash: flash-regulator {
> >  		compatible =3D "regulator-fixed";
> >  		regulator-name =3D "vcc_flash";
> > @@ -437,13 +459,30 @@
> >  &sdio0 {
> >  	broken-cd;
> >  	bus-width =3D <4>;
> > +	clock-freq-min-max =3D <400000 50000000>;
> >  	disable-wp;
> >  	non-removable;
> > +	cap-sd-highspeed;
> >  	num-slots =3D <1>;
> >  	pinctrl-names =3D "default";
> > -	pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
> > -	vmmc-supply =3D <&vcc_18>;
> > +	pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_=
int>;
> > +
> > +	sd-uhs-sdr50;
> > +	sd-uhs-sdr104;
> > +	sd-uhs-ddr50;
>=20
> we don't have mmc tuning capabilities yet, so please no sd-uhs-* stuf=
f. That=20
> way you should also be able to leave out the clock-freq-min-max above=
, as=20
> regular "highspeed" does not venture above the 50MHz limit.
>=20

Ok, I have tested without it too and it works with a small hack on the =
code.
Agree with you

> > +	cap-sdio-irq;
> > +
> > +	vmmc-supply =3D <&vcc_wifi>;
>=20
> the original supply is actually wrong in the dts. vcc_18 is the io vo=
ltage=20
> used on the=20
> pins _to_ the card, not to supply the card itself. So vcc_18 is actua=
lly the=20
> so called vqmmc-supply.
> vmmc-supply is done regularly from vcc_io. So your voltage hack above=
 can go=20
> away too.
>=20
> Bringup should also use a mmc-power-sequency so you can make sure the=
=20
> rtc_clock is running, which is also needed by the wifi module.
>=20

Hack is used to because when sdio subsystem compare the wifi voltage ca=
pability
returned by a specific message on the bus with the possible voltage lev=
els that
hardware connection provides and take the minimal. The card return to s=
upport
from 2V up and this is the reason to declare it at 2V. I will retest ag=
ain

>=20
> >  	status =3D "okay";
>=20
> missing #address-cells and #size-cells values for the subnodes
>

Correct

> > +
> > +	brcmf: bcrmf@0 {
> > +		compatible =3D "brcm,bcm4329-fmac";
> > +		interrupt-parent =3D <&gpio4>;
> > +		reg =3D <0>;
> > +		interrupts =3D <30 IRQ_TYPE_EDGE_FALLING>;
> > +		interrupt-names =3D "host-wake";
> > +		status =3D "okay";
> > +	};
> >  };
> >=20
> >  &sdmmc {
>=20
> I took the liberty to move stuff around how it should look like, but =
did not=20
> find the time to actually test this. So maybe you can take a look at =
the=20
> attached patches.
>=20

Perfect, I will retest as soon as I can and go back to you. Right now
I have two hardware design around firefly that use the wifi

>=20
> Heiko

Michael

> From 1a255ca2a4281b6257eca95ed3edabe74818bc1e Mon Sep 17 00:00:00 200=
1
> From: Heiko Stuebner <heiko@sntech.de>
> Date: Sat, 8 Aug 2015 22:14:57 +0200
> Subject: [PATCH 1/3] ARM: dts: rockchip: add rk3288-firefly io-domain=
s
>=20
> This adds the io-domain description for the different io supplies on
> the rk3288 firefly.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288-firefly.dtsi | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dt=
s/rk3288-firefly.dtsi
> index 20fa0ef..0b2b496 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -55,6 +55,20 @@
>  		clock-output-names =3D "ext_gmac";
>  	};
> =20
> +	io_domains: io-domains {
> +		compatible =3D "rockchip,rk3288-io-voltage-domain";
> +		rockchip,grf =3D <&grf>;
> +
> +		audio-supply =3D <&vcca_33>;
> +		bb-supply =3D <&vcc_io>;
> +		flash0-supply =3D <&vcc_flash>;
> +		gpio1830-supply =3D <&vcc_io>;
> +		gpio30-supply =3D <&vcc_io>;
> +		lcdc-supply =3D <&vcc_io>;
> +		sdcard-supply =3D <&vccio_sd>;
> +		wifi-supply =3D <&vccio_wl>;
> +	};
> +
>  	ir: ir-receiver {
>  		compatible =3D "gpio-ir-receiver";
>  		pinctrl-names =3D "default";
> @@ -325,7 +339,12 @@
>  				regulator-always-on;
>  			};
> =20
> -			vcc_18: REG11 {
> +			/*
> +			 * vcc_18 has an alias named vccio_wl.  We'll add this
> +			 * aliase here just to make it easier to follow the
> +			 * schematic.
> +			 */
> +			vccio_wl: vcc_18: REG11 {
>  				regulator-name =3D "vcc_18";
>  				regulator-min-microvolt =3D <1800000>;
>  				regulator-max-microvolt =3D <1800000>;
> --=20
> 2.1.4
>=20

> From e89204f15a1c1c9066013e2517bc5bb80d067601 Mon Sep 17 00:00:00 200=
1
> From: Heiko Stuebner <heiko@sntech.de>
> Date: Sat, 8 Aug 2015 22:37:52 +0200
> Subject: [PATCH 2/3] ARM: dts: rockchip: add #address- and #size-cell=
s to
>  dw-mshc nodes
>=20
> The mmc subsystem allows to specifiy function subnodes to specify dat=
a
> for embedded boards like wifi sdio modules use there.
> The address of these submodules is the slot-id they are connected to,
> so set #address-cells and #size-cells accordingly to prevent boards f=
rom
> having to repeat these settings in each dts.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 8 ++++++++
>  arch/arm/boot/dts/rk3xxx.dtsi | 6 ++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288=
=2Edtsi
> index 906e938..7bd0a30 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -227,6 +227,8 @@
>  		fifo-depth =3D <0x100>;
>  		interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		reg =3D <0xff0c0000 0x4000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> @@ -238,6 +240,8 @@
>  		fifo-depth =3D <0x100>;
>  		interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  		reg =3D <0xff0d0000 0x4000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> @@ -249,6 +253,8 @@
>  		fifo-depth =3D <0x100>;
>  		interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  		reg =3D <0xff0e0000 0x4000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> @@ -260,6 +266,8 @@
>  		fifo-depth =3D <0x100>;
>  		interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  		reg =3D <0xff0f0000 0x4000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx=
=2Edtsi
> index 4497d28..e09b752 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -218,6 +218,8 @@
>  		clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
>  		clock-names =3D "biu", "ciu";
>  		fifo-depth =3D <256>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> @@ -228,6 +230,8 @@
>  		clocks =3D <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
>  		clock-names =3D "biu", "ciu";
>  		fifo-depth =3D <256>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> @@ -238,6 +242,8 @@
>  		clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
>  		clock-names =3D "biu", "ciu";
>  		fifo-depth =3D <256>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		status =3D "disabled";
>  	};
> =20
> --=20
> 2.1.4
>=20

> From 62bd4e7d8e78296089a675575df4354e605723c9 Mon Sep 17 00:00:00 200=
1
> From: Michael Trimarchi <michael@amarulasolutions.com>
> Date: Fri, 7 Aug 2015 16:12:05 +0200
> Subject: [PATCH 3/3] ARM: dts: rockchip: Add wifi support for firefly
>=20
> This patch enables wifi support for the firefly board.
>=20
> The core supply of the wifi modules comes from vcc_io but aliased to
> vbat_wl, so add this alias too to make reading the schematics easier.
>=20
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/rk3288-firefly.dtsi | 38 +++++++++++++++++++++++++=
+++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dt=
s/rk3288-firefly.dtsi
> index 0b2b496..506bd00 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -110,6 +110,17 @@
>  		};
>  	};
> =20
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		clocks =3D <&hym8563>;
> +		clock-names =3D "ext_clock";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&wifi_reg_on>;
> +
> +		/* On the module itself this is WL_REG_ON */
> +		reset-gpios =3D <&gpio4 28 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	vcc_sys: vsys-regulator {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "vcc_sys";
> @@ -428,6 +439,12 @@
>  		};
>  	};
> =20
> +	sdio {
> +		wifi_reg_on: wifi-reg-on {
> +			rockchip,pins =3D <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	sdmmc {
>  		sdmmc_pwr: sdmmc-pwr {
>  			rockchip,pins =3D <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -457,15 +474,30 @@
>  };
> =20
>  &sdio0 {
> +	status =3D "okay";
> +
>  	broken-cd;
>  	bus-width =3D <4>;
>  	disable-wp;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	mmc-pwrseq =3D <&sdio_pwrseq>;
>  	non-removable;
>  	num-slots =3D <1>;
>  	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
> -	vmmc-supply =3D <&vcc_18>;
> -	status =3D "okay";
> +	pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_in=
t>;
> +	vmmc-supply =3D <&vcc_io>;
> +	vqmmc-supply =3D <&vccio_wl>;
> +
> +	brcmf: bcrmf@0 {
> +		compatible =3D "brcm,bcm4329-fmac";
> +		reg =3D <0>;
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <30 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names =3D "host-wake";
> +		status =3D "okay";
> +	};
>  };
> =20
>  &sdmmc {
> --=20
> 2.1.4
>=20


--=20
| Michael Nazzareno Trimarchi                     Amarula Solutions BV =
|
| COO  -  Founder                                      Cruquiuskade 47 =
|
| +31(0)851119172                                 Amsterdam 1018 AM NL =
|
|                  [`as] http://www.amarulasolutions.com               =
|

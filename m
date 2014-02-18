From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7 5/8] ARM: dts: sun7i: Add support for mmc
Date: Tue, 18 Feb 2014 15:22:21 +0100
Message-ID: <20140218142221.GJ3142@lukather>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100241.15040.24836.stgit@pagira.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQG2RWMAKGQELELA7SI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140217100241.15040.24836.stgit-pgFh0Jf6HD9Xzn/AsuzBOg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2014 at 11:02:41AM +0100, David Lanzend=F6rfer wrote:
> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |    8 +++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |    8 +++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   23 +++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |   61 +++++++++++++++++=
++++++
>  4 files changed, 100 insertions(+)
>=20

I'd prefer to have three patches here:
   - One that add the controllers
   - One that add the pin muxing options
   - One that enable the controllers on the various boards.

> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/=
dts/sun7i-a20-cubieboard2.dts
> index 5c51cb8..ae800b6 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -34,6 +34,14 @@
>  			};
>  		};
> =20
> +		mmc0: mmc@01c0f000 {
> +			pinctrl-names =3D "default", "default";
> +			pinctrl-0 =3D <&mmc0_pins_a>;
> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;

This can be made a single pinctrl group, you don't need the pinctrl-1
stuff, it only complicates the node.

> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			led_pins_cubieboard2: led_pins@0 {
>  				allwinner,pins =3D "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/d=
ts/sun7i-a20-cubietruck.dts
> index f9dcb61..370cef84 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -19,6 +19,14 @@
>  	compatible =3D "cubietech,cubietruck", "allwinner,sun7i-a20";
> =20
>  	soc@01c00000 {
> +		mmc0: mmc@01c0f000 {
> +			pinctrl-names =3D "default", "default";
> +			pinctrl-0 =3D <&mmc0_pins_a>;
> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			led_pins_cubietruck: led_pins@0 {
>  				allwinner,pins =3D "PH7", "PH11", "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/b=
oot/dts/sun7i-a20-olinuxino-micro.dts
> index ead3013..685ec06 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -34,7 +34,30 @@
>  			};
>  		};
> =20
> +		mmc0: mmc@01c0f000 {
> +			pinctrl-names =3D "default", "default";
> +			pinctrl-0 =3D <&mmc0_pins_a>;
> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
> +			status =3D "okay";
> +		};
> +
> +		mmc3: mmc@01c12000 {
> +			pinctrl-names =3D "default", "default";
> +			pinctrl-0 =3D <&mmc3_pins_a>;
> +			pinctrl-1 =3D <&mmc3_cd_pin_olinuxinom>;
> +			cd-gpios =3D <&pio 7 11 0>; /* PH11 */
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
> +			mmc3_cd_pin_olinuxinom: mmc3_cd_pin@0 {
> +				allwinner,pins =3D "PH11";
> +				allwinner,function =3D "gpio_in";
> +				allwinner,drive =3D <0>;
> +				allwinner,pull =3D <1>;
> +			};
> +
>  			led_pins_olinuxino: led_pins@0 {
>  				allwinner,pins =3D "PH2";
>  				allwinner,function =3D "gpio_out";
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index 9ff0948..5b55414 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -355,6 +355,46 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		mmc0: mmc@01c0f000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c0f000 0x1000>;
> +			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <0 32 4>;
> +			bus-width =3D <4>;

This belongs to the board, the controller itself is able to handle
several bus width.

> +			status =3D "disabled";
> +		};
> +
> +		mmc1: mmc@01c10000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c10000 0x1000>;
> +			clocks =3D <&ahb_gates 9>, <&mmc1_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <0 33 4>;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		mmc2: mmc@01c11000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c11000 0x1000>;
> +			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <0 34 4>;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		mmc3: mmc@01c12000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c12000 0x1000>;
> +			clocks =3D <&ahb_gates 11>, <&mmc3_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <0 35 4>;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
>  		pio: pinctrl@01c20800 {
>  			compatible =3D "allwinner,sun7i-a20-pinctrl";
>  			reg =3D <0x01c20800 0x400>;
> @@ -432,6 +472,27 @@
>  				allwinner,drive =3D <0>;
>  				allwinner,pull =3D <0>;
>  			};
> +
> +			mmc0_pins_a: mmc0@0 {
> +				allwinner,pins =3D "PF0","PF1","PF2","PF3","PF4","PF5";
> +				allwinner,function =3D "mmc0";
> +				allwinner,drive =3D <3>;
> +				allwinner,pull =3D <0>;
> +			};
> +
> +			mmc0_cd_pin_reference_design: mmc0_cd_pin@0 {
> +				allwinner,pins =3D "PH1";
> +				allwinner,function =3D "gpio_in";
> +				allwinner,drive =3D <0>;
> +				allwinner,pull =3D <1>;
> +			};
> +
> +			mmc3_pins_a: mmc3@0 {
> +				allwinner,pins =3D "PI4","PI5","PI6","PI7","PI8","PI9";
> +				allwinner,function =3D "mmc3";
> +				allwinner,drive =3D <3>;
> +				allwinner,pull =3D <0>;
> +			};
>  		};
> =20
>  		timer@01c20c00 {
>=20

Looks good otherwise.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTA2ydAAoJEBx+YmzsjxAgcmcQAKfuIrN8XPBH5jzMw/6KVL3O
Q1cQbWgEB3vXV4Cfl7ZqqFb8GBlktiST5IrP99ZeDauh6OZMFqU6aQ07PMfdFKZz
NM0O7jwW6khtDaM3xLCy87fCLoWWOM730fS3M7lGsx5BTdLFzHIGl57c4pOxOonf
FsBEXfc3aBJyw5Y8ldkHWLpE5M67fYmww7l1YYoz//+3wo70BjxPeQCoj3wLb0hw
igUBk2at12+SMRO9wNmu7VX4ELSKFx4AgH22QWo92iA2ddQD1yTl6GfuOUdxJ8Mb
ewenpAuZ38NmNnz4jY9HRmXQKwpfmGPdFdHgPk8+odInhX0iGI8TqAS1lcWTtc1n
JPnJ7G9sf8xx/K9UKkghrtp8NdVHO8yOvyVJ9j9QS9OVCS74+k2zR/FKgC1YlPho
Isd9M40d9DRh+ceR+DHgwyF+nIiPNJGyO98NRH5ftCGFYAr5qbAj/hZOt9IGJaOL
4xP523/FInZqaxyiBdIpH3TsmQ6rzlDLGZgkfXu0VF5fvW1vMOjITkXay2VhQpcw
LxMSg8WfGzUvToahZMz0XT+0q/7Oey8r72lY/W9L0BoH940RThhxak27D5VzMWMC
Mdgnicr9K2bkQyLHhXaeSBZPPTDHdRrSdnvzQ7kzUg+s+kzU1O+2A+Gn82rLTJNv
4XO4clOXYhqTSdI9lBa4
=pkGO
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--

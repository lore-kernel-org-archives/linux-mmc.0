From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
Date: Sun, 15 Dec 2013 14:58:54 +0100
Message-ID: <20131215135854.GF3651@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-3-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="je2i5r69C8+2chMc"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB3XLW2KQKGQEVFDMMUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387058295-20641-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--je2i5r69C8+2chMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Dec 14, 2013 at 10:58:12PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Commit-log :)

> ---
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 16 ++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10.dtsi           | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/d=
ts/sun4i-a10-cubieboard.dts
> index 425a7db..d193937 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -42,7 +42,23 @@
>  			};
>  		};
> =20
> +		sdc0: sdc@01c0f000 {
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&sdc0_pins_a>;
> +			pinctrl-1 =3D <&mmc0_cd_pin_cubieboard>;
> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
> +			cd-mode =3D <1>;
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
> +			mmc0_cd_pin_cubieboard: mmc0_cd_pin@0 {
> +				allwinner,pins =3D "PH1";
> +				allwinner,function =3D "gpio_in";
> +				allwinner,drive =3D <0>;
> +				allwinner,pull =3D <0>;
> +			};
> +

You seem to be using mmc and sdc without any real distinction. Please
try to be consistent and use only one of the two (and I have a slight
preference for mmc :))

>  			led_pins_cubieboard: led_pins@0 {
>  				allwinner,pins =3D "PH20", "PH21";
>  				allwinner,function =3D "gpio_out";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 4dccdb0..13bccd5 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -306,6 +306,15 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		sdc0: sdc@01c0f000 {
> +			compatible =3D "allwinner,sun4i-mmc";
> +			reg =3D <0x01c0f000 0x1000>;
> +			clocks =3D <&ahb_gates 8>, <&mmc0>;
> +			interrupts =3D <32>;
> +			bus-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +

The A10 has much more mmc controller doesn't it?

Could you add all of them in the DT ?

>  		intc: interrupt-controller@01c20400 {
>  			compatible =3D "allwinner,sun4i-ic";
>  			reg =3D <0x01c20400 0x400>;
> @@ -376,6 +385,13 @@
>  				allwinner,drive =3D <0>;
>  				allwinner,pull =3D <0>;
>  			};
> +
> +			sdc0_pins_a: sdc0@0 {
> +				allwinner,pins =3D "PF0","PF1","PF2","PF3","PF4","PF5";
> +				allwinner,function =3D "mmc0";
> +				allwinner,drive =3D <3>;
> +				allwinner,pull =3D <1>;

Wow, you need both the pullups and a 40mA output?

Ideally, I'd like this patch to be splitted into three:
  - One that adds the MMC controller nodes to the DTSI
  - One that adds the muxing options you need to the pinctrl node
  - One that enables the controller on the boards

Thanks,

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--je2i5r69C8+2chMc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSrbWeAAoJEBx+YmzsjxAgSnQP/3wsuAgOMU/dXLNJB3X5yX5w
3W3UJdATUflBsHJJQjUSitRl4Cl1N0fKDI7qmNodOurWy1s6WnadwPurnIUFr6gE
wl9t2ENvvYMYr9dqqQc2zO4ky9lMHBGUlHI5MfueDeZ0LXIfnr1F1j4uNCsJWwrz
lTNtwf81/wrGKVsi4bhyMp7Pnxw2NGTbN+XcIP+DbzVrSCPOAEqZGxSK9wedy8fQ
RieQK/Q6lu3bCIBW/mJHUGrmOtr3d2EfDdRwKbqwvtqJ/Ym4WA/MZIDKVw1gjaGP
VDiZsw67U1Vjpthy+b1rCip12B0Y8jGQlzXJUgxiVwddQFJ3xpH4vgGbw/UL+c3w
swp4+jyaljd2kc8okDDBWtYlMkDtIqZdxjIMy0DQBNw3W9Auy4uVTuTGkMfBq909
HM8V/I+6uDQN3g/kSMpmAWs2aDzO7dphAIfsNyPLTQvBTbOz1lXnCF1B6wbJ92M3
CHVY7kOabbCvDLBD57AomZotIpbaYnrEN7+u/kO81Jqv8ESZqEG5NcpibrOxZ6vk
L/OkbhIJMWF9MAUJwJ+zFw/f0w3zjqD38+ypD6FqEz8OSvsZF0Enp1ND4fYTScWc
hIz262l1cXpwRcXAcVx+pmvLuEqrpQYJ63T7XXrT13viYxr5RqFhP8S7n4dPFIjr
h9PU6HB7roVYpvfp1ouF
=M8Ew
-----END PGP SIGNATURE-----

--je2i5r69C8+2chMc--

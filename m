From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 07/17] ARM: dts: sun5i: Add mmc
 controller nodes
Date: Wed, 23 Apr 2014 11:48:40 +0200
Message-ID: <20140423094840.GL24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-8-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBZMZ32NAKGQERKQAQVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398164497-14212-8-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 01:01:27PM +0200, Hans de Goede wrote:
> From: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>=20
> Add nodes for the 3 mmc controllers found on A10s SoCs and for the 2 mmc
> controllers found on A13 SoCs.
>=20
> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi  | 18 ++++++++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-=
a10s.dtsi
> index 79989ed..12113f9 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -338,6 +338,33 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		mmc0: mmc@01c0f000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c0f000 0x1000>;
> +			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <32>;
> +			status =3D "disabled";
> +		};
> +
> +		mmc1: mmc@01c10000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c10000 0x1000>;
> +			clocks =3D <&ahb_gates 9>, <&mmc1_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <33>;
> +			status =3D "disabled";
> +		};
> +
> +		mmc2: mmc@01c11000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c11000 0x1000>;
> +			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <34>;
> +			status =3D "disabled";
> +		};
> +
>  		usbphy: phy@01c13400 {
>  			#phy-cells =3D <1>;
>  			compatible =3D "allwinner,sun5i-a13-usb-phy";
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a=
13.dtsi
> index f01c315..a0e55e8 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -320,6 +320,24 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		mmc0: mmc@01c0f000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c0f000 0x1000>;
> +			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <32>;
> +			status =3D "disabled";
> +		};
> +
> +		mmc2: mmc@01c11000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c11000 0x1000>;
> +			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
> +			clock-names =3D "ahb", "mod";
> +			interrupts =3D <34>;
> +			status =3D "disabled";
> +		};
> +

The A13 user manual reports that there is 3 of them in the A13, just
like on the A10s. Have you forgotten one?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTV4x3AAoJEBx+YmzsjxAgL70P/2pZ6AbioFTkbeRbeXYN1msR
2WNAg/kqG8YhccIvMqFmbqZngnvdg7pUr2shkuQW4crel+aBn3o/QsTMkYlKeHX2
b54spwK8dhG08/Tr/s3L6AsO2XZWX46P1KH05K+c1ls0lzCyr6P0BxqAfPy/DXQy
3MVse53QPrhYLA+3xptk+bi/IgXFZZalvRjr61pdSlsX4jYbG56jf7tOwpNUK8UO
hYgY8YLqxT9yNsR/x9SVzEFAfUrkko2JclQc3rxRHdDN+yv0O7QubwZ1mQw0wDgu
qPwQcMdyMkQdQ7Hv0QO9M5+Wpyi73s88QWNz36I4Y4GPTMjjwRmGzo5nQl6U8Y5C
0DgHFoQr0AdMrFmhT33EHn65SgTDNfqJoO0yCDzT0EOPj5LYQiTfqdIKT4x0LpjR
VNPOR0Tm+vWdyYaEjGL2jjZXJYBRy488tgjhJeo5OT5XphT9//AILT7gWwUlIbLx
ww01R0e8qMofgnZdHa9+vgfZ15gQtuG6jWksXtq6TC44+ALnePlz6F0QJbVgkWA+
wRP2ZzlKWtuvDD86j9xsxpIPMqxKumXGt+dTCh2DhQWCLD9LB65KhYsAuTFG2tbD
MP+naVyH/6ZdhAhR/uvp+jw8WW23olw0En4gwxRTY3mp/vbhtkEyL4SSQIkq+FYi
BS4+5+o1+ZSaaq+oOJpA
=Ou2W
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--

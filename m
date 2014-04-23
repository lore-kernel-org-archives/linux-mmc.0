From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 11/17] ARM: dts: sun6i: Add mmc
 controller nodes
Date: Wed, 23 Apr 2014 11:50:29 +0200
Message-ID: <20140423095029.GM24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-12-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBGU432NAKGQE65WNKKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398164497-14212-12-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 01:01:31PM +0200, Hans de Goede wrote:
> Add nodes for the 4 mmc controllers found on A31 SoCs to
> arch/arm/boot/dts/sun6i-a31.dtsi.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 52 ++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a=
31.dtsi
> index 12bcc17..a27afc8 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -269,6 +269,58 @@
>  		#size-cells =3D <1>;
>  		ranges;
> =20
> +		mmc0: mmc@01c0f000 {
> +			compatible =3D "allwinner,sun5i-a13-mmc";
> +			reg =3D <0x01c0f000 0x1000>;
> +			clocks =3D <&ahb1_gates 8>, <&mmc0_clk>;
> +			clock-names =3D "ahb", "mod";
> +			resets =3D <&ahb1_rst 8>;
> +			reset-names =3D "ahb";
> +			interrupts =3D <0 60 4>;
> +			bus-width =3D <4>;
> +			cd-inverted;

The two last items should be in the DTS.

Looks good otherwise.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTV4zkAAoJEBx+YmzsjxAg8X4QAJBN5ta4fb8XxcYoBA4ONTmS
6zK9kfCTNPo0YDtPwyyFnP5f4ceK4aWxZoP+tXj4f6k6zes0MqMyVnr7pbTZE6NJ
vYqLR+TTNe6UHAD2d0V9B1rf6wTTHJTwV1JDG8fnLCFToj69l8D5dEVFnR3MavuL
BhF4FlM8vFhjZybBw1Q4FOkSaOfrH4M9Ic6OoLi4LXsbFZdSBD49ac5KNU05cId+
2Oc64pe0cXziykuadoP41cUsqjjgv8eHg9ejaNwN16qi1kKjs4iDwtFnSkifDc/i
sA+NFYCqF4uuXDOAujzGko6xidxpKutwxSzHWCVbt/B5lACEDUZA5U3VXHJNneuK
dYB7m9WbiFIDOcZN2Ek2koI6vN3FXbKk/Zr1EKa+TGf76gel7w5yinhrs8R+b9+n
MyrGYjz6UP/TZ8wxk6dwtQ0/dL/voZ/rDlr7xLWjDvZ+MxslfuleYhQ3+y2faN1K
43tiap9S2SrMboPtEuIYqIC8+eaq3DqWUMzPJudlcfvx3pl8tPAMBWWXdzS9dw+q
pNGhkn8WKG5VcZc2gTuSsql4CSH1+uRQix0+/AA7kLj3MhWTHBccsYYAIeZB+zB4
m/JyqAQxzKrTRTvqPzHsUULzBYip4JW4czdXzoTsNbR7dmC1K6RzAA2vCrsrHhGk
GkqqEFo++3l0LOSp9a3K
=Osi0
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--

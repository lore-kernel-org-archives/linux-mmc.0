From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v9 10/17] ARM: dts: sun6i: Add mmc clocks
Date: Mon, 28 Apr 2014 12:37:53 -0700
Message-ID: <20140428193753.GJ3134@lukather>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-11-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPTHnM80CEnHQ2WJ"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBGO57KNAKGQEWDCJMRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398507381-5614-11-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--mPTHnM80CEnHQ2WJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2014 at 12:16:14PM +0200, Hans de Goede wrote:
> Add clk-nodes for the mmc clocks.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a=
31.dtsi
> index d45efa7..12bcc17 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -198,6 +198,38 @@
>  					"apb2_uart4", "apb2_uart5";
>  		};
> =20
> +		mmc0_clk: clk@01c20088 {
> +			#clock-cells =3D <0>;
> +			compatible =3D "allwinner,sun4i-a10-mod0-clk";

And this is not misleading but wrong. The MMC clocks have the phase
control feature that mod0 clock don't have, so they should have a
compatible of their own.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--mPTHnM80CEnHQ2WJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTXq4RAAoJEBx+YmzsjxAgoZcP/RfKF53+bwZI3Qvt1M8nnvQq
ZNJnP91UuOpqpBvhi5w3GlWXMyjqyboXezpnLmN7MczN38aJfKoAOb2Nqj6Iszk9
ltc1vK4UNigrTVljX5X2iEQiZm3RbB6V4cYXX0EB1nL7mF+oDamJkfj1batKb8vG
QYORViZdesohnRIIzOzHrypLB15zv8RBT6VgMsEh9u2Gj3qRT0RTz9IHFe6bislo
efEBrj7PiaIWauWsHgWW7+yjSVqnCyR3u5wDnPOoz8/ImQvsKwHB6J620e6++Siw
OnPS5zjimreme+5UMxIwbhmCcV1TNLVvrBIy3mLnwh4idqAfuotZEF7+4eGCjljo
d3uspLuJk4Qei11TBt+uqys5G7t+HFqMyCMINbeXsTa6kc1tygUHCRbT2w/4eH7V
LxSbkSsXOPHdM7Jdi6yesjmGwHwnNvgSSAg2s4dBV5hsnModbr+XUsVATEm7PACe
N/MhctGdQykKI/Uo2YI717D4eopWnROxhIwQpZDIOAslTq+eJd8CJc6DdH5GqS0Y
VQfWMfKYECEnOYl6XVkdV81QAkBeh/ZDdZJh2UYGy0pASBsRMwzTaIOUUFRTn1be
ycquASnwSDrnYMrxd9gkg9ixqPtXsg+9h9wKdfXPLMFzZ7M9cv/OkEUn2A4PFIXe
9a6F09Swimv1yAEG/CuE
=3XK9
-----END PGP SIGNATURE-----

--mPTHnM80CEnHQ2WJ--

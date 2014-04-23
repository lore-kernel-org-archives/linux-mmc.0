From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 10/17] ARM: dts: sun6i: Add mmc clocks
Date: Wed, 23 Apr 2014 11:44:26 +0200
Message-ID: <20140423094426.GK24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-11-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLUX32NAKGQE6XI433I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398164497-14212-11-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 01:01:30PM +0200, Hans de Goede wrote:
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

This is simply not true.

module0 clocks don't have any kind of phase control, while we do here.

You should introduce a new compatible.

(and change the clock-names content accordingly)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTV4t5AAoJEBx+YmzsjxAgGHQP/R6hRYNk+W5oDkTc/88oVqiO
9QTiFdBxZjR0C2cwhw92jSmhsu0mmSYI5oLmq064HE/Eub9nNONxC7sWyk1NTKD9
px9PUI2Z7QoSN0qHl33L7YoUMAHXTyN9b8j/qkHlP8Gf+A2GoCU6Vonm13NQEFSS
Ksxuat2ueAKloVan/xidodC57z12JfxGKWm/3mWyjw2F8T7niN4bYcyK8ILDaxo0
qDlqMpyHMLXHs2l7JjoLZieKJ87m1CmlWZiAm8jF10vVpv9qAUJIDNrjF0D1bVNC
IfVqR0/WwHIWM8RFdFSbNe17fUDPN75KFrcjFc3orB6PrS82ZRWFmy/tandI0eUa
EccYe5+KhSsFJeELYjwWMw+bw0rxX01X/frcUTwpOAubeWs7j8ZTu+8LrbUfCFlT
phpx62YfPzryQvSleu13oOqb1SahXk0AcEdqhzZkrRS0KjRlLFssJBKEpj8a6Knr
/8Uf6CMEZkCNwU4XD/sUmGa7hBkO5JFNev9pTfiIp0dXkHAl6hnmfUAHYNE7BBsB
z6oAo0ftCqu9aX5AS6iGRP/me4s5xaDZaBijAE4Ycs1S7VTz7cEdW+YpMdzHIeDn
XKFIvPIxDDFwvukkcvuleQSOMDJ4uhNu0F/bW0BJ0CMETWUbOR+eGnxukspeCggy
HYvNYPMUP1/z/kT5D/5J
=o+rn
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--

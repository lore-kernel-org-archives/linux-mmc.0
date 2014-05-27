From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 02/11] pinctrl: sunxi: add
 IRQCHIP_SKIP_SET_WAKE flag for pinctrl irq chip
Date: Tue, 27 May 2014 10:07:46 +0200
Message-ID: <20140527080746.GB4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-3-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBWUQSGOAKGQEYUBKDCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401090486-4414-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 09:47:57AM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>=20
> The sunxi pinctrl irq chip driver does not support wakeup at the
> moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work with drivers
> using wakeup.
>=20
> Also add a name to the irq chip.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunx=
i/pinctrl-sunxi.c
> index db9ccd6..ec60c2e 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -646,6 +646,8 @@ static struct irq_chip sunxi_pinctrl_irq_chip =3D {
>  	.irq_mask_ack	=3D sunxi_pinctrl_irq_mask_ack,
>  	.irq_unmask	=3D sunxi_pinctrl_irq_unmask,
>  	.irq_set_type	=3D sunxi_pinctrl_irq_set_type,
> +	.name		=3D "sunxi-pio",
> +	.flags		=3D IRQCHIP_SKIP_SET_WAKE,

I'd rather see the name set to dev_name() or something like that. This
will not work that great with multiple pin controller supporting
interrupts.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThEfSAAoJEBx+YmzsjxAgemUP/3yI6XcdPZgPYFYTPh0RX0I2
b7IlgHuWJ2jnYiyk15jZ5n0afd4EJngy646fXE7VqZYpGaQ239llJCIEkwlPe03r
RaFD3Aft4S4dJd8qlTBk0q+NXEEmlee4aC8fAnxxfMZfZAXA/kNTmMNcqnlF78Oh
fRtgu4Zj1EYTSx4BNOaSnonSn09hFqWcojtHwHgP7TagJCZkAb4fExHsntGiUnyr
NQdvUOt7yD2ZrIwAs6USbJNcV+wOBS4JY8t/zN1vT8Dd8Xet6CnbMgLzp95JG5ZL
xAiJcga2O9u3KRcu1/RkSqp379VSsyYM61u9SrAXhlefrixJVZhLACh6bWATxquW
2ImCrdw2LpLNnXi/Uecjwf8BlE6pKPB1CNWIbIOXPFldAXUKRo0n7AfO+LKfX/AY
OAHbv8rtIro6eoK4+NwyYqW27GTWW/gWI4/eB9U0u751OE5h5RQO9lXBjFOxnSWd
UgWqBpAVJaaTL3Cqaj6hjRrwLqnULYNbukkF4zwcR06o3Nfi5FY45bf+ipRDC3nS
gl5cfGiXdP4NBH8ojKA6e+/I8Bii9e0XKh/qZf9UesGnY16InwqLL6qjkjEIAstT
jZwjAnXkofVt3b/AyFgQanVZiKbQqXNgi/XrZIVA528QEu6YdpTxnVqNrQ8Z3KTo
3aeOeT4KGeEKjb0Yxtkz
=JPY0
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

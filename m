From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 03/11] pinctrl: sunxi: Move setting of mux
 to irq type from unmask to set_type
Date: Wed, 28 May 2014 11:36:53 +0200
Message-ID: <20140528093653.GN4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
 <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB465S2OAKGQEQN5MYMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2014 at 04:18:29PM +0200, Linus Walleij wrote:
> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrot=
e:
>=20
> > With level triggered interrupt mask / unmask will get called for each
> > interrupt, doing the somewhat expensive mux setting on each unmask thus=
 is
> > not a good idea. Instead move it to the set_type callback, which is typ=
ically
> > done only once for each irq.
> >
> > Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> Yes move it out of mask/unmask but no, not into set_type().
>=20
> Can you not use the irqchip startup()/shutdown() callbacks
> instead?

I think we can use irq_request_resources then
https://lkml.org/lkml/2014/3/12/307

We could even merge the gpio_to_irq code into it.

It's called in __setup_irq, so it's guaranteed to be called, and it
will bail out early without doing anything, since it's one of the
first thing __setup_irq does.

> And how come we have no clean separation between gpiochip
> and the pinmux parts here, why cant we just call
> pinctrl_request_gpio() and pinctrl_free_gpio() here instead?
> Or maybe pinctrl_gpio_direction_input() and have that set
> up the muxing in the pinctrl driver side?

Because the function it has to be muxed to is neither gpio_in or
gpio_out, and it's not even considered a gpio. It really is just
another muxing function, like i2c or mmc.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTha41AAoJEBx+YmzsjxAg4tcP/1UvvatNfABOs5guVCHqh4Tr
YnK8WvmzQJkSsmXb7Tktl29YU9aUWacvc+cKf8t+ByWZgyOUefJWVgMO/PT7f1id
mr/Ux9w5UqgcNEJ6r69pYJoXb8GVkT2aXGaJ2jwQY4zrPuY0DlLObbTK/aKTJv/r
LhdSN3VFkRIfJroPCZdKdU8/lTes7lAhUAI0J1UHniYof3pZsx/+q45PvB2TxbeG
plnex8U0yRGe+kEL0waf3G/K64PS2mP71WBVHnksZpb2JhHhp53PwCEvnl/g4qRd
YUW7oRXwFiner+ASyAwkHuzOumGPb2MbndEAQvT+CM6uOuIpT6IeaAd1le9Kytp6
EjQ4PQeZIjCsETy6yN5whF/RfUgz2FqvwkJmEBKDdRuWC2p3y/O2l1LbEFO2txay
+s3scBoP0tfMPv3uWfwPz05U24QPuSMCpAG1+XhvekW4f2PGgn+WTJxA7M9tYAF9
655p2aYWYwPBWtLXYeHy3BPf2R4DwkDQrTkhVwM3s+6e5FoAAI/hQlr4un6pSX0Y
A5X+Tlvwh1XyPLSOEGPwamWWiwgTLanRwpgjC/9NYlk48Zg5C2vCo2s8+XFuJcQz
6wGinKnQ03mm6GdcMHi43ykK2rC3pPGVf1RmPNoXySI1S4bKNVZ8xK05lGZzjXCq
2V4qiKjeHXHRoM+fXYpp
=oL2X
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--

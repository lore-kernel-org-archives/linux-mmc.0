From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 03/11] pinctrl: sunxi: Move setting of mux
 to irq type from unmask to set_type
Date: Wed, 28 May 2014 12:33:51 +0200
Message-ID: <20140528103351.GQ4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
 <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com>
 <20140528093653.GN4730@lukather>
 <5385B1B8.8070803@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0UhZIN3Sa23/ILEd"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBV7XS2OAKGQEPWIOT3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5385B1B8.8070803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--0UhZIN3Sa23/ILEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2014 at 11:51:52AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 05/28/2014 11:36 AM, Maxime Ripard wrote:
> > On Tue, May 27, 2014 at 04:18:29PM +0200, Linus Walleij wrote:
> >> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> w=
rote:
> >>
> >>> With level triggered interrupt mask / unmask will get called for each
> >>> interrupt, doing the somewhat expensive mux setting on each unmask th=
us is
> >>> not a good idea. Instead move it to the set_type callback, which is t=
ypically
> >>> done only once for each irq.
> >>>
> >>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>
> >> Yes move it out of mask/unmask but no, not into set_type().
> >>
> >> Can you not use the irqchip startup()/shutdown() callbacks
> >> instead?
> >=20
> > I think we can use irq_request_resources then
> > https://lkml.org/lkml/2014/3/12/307
>=20
> Sounds good, I'll modify the patch to move it here before posting a v2 of
> this series. Note v2 likely won't happen till this weekend, -ENOTIME.
>=20
> > We could even merge the gpio_to_irq code into it.
>=20
> Erm, no we need that as a separate function for the gpio_chip's to_irq
> callback.

Linus sent a patch stating otherwise a few weeks ago, and was
suggesting moving it to irq_startup.

https://lkml.org/lkml/2014/5/9/50

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--0UhZIN3Sa23/ILEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThbuPAAoJEBx+YmzsjxAglxgP/0k/zqqXxIaurdLrYu3NWmZI
SFMbcggtnBu9z8xL4xviBmGOplDfJHMMvodkf8BOkr8n+RyW0HZFB5kKEpguC8LQ
/v4x3GL1sQMbQx5qWmJTcFkCCrUZOEcwZl8ulKOEzkBqDRn2awOu2bR2KkF75PZt
LkSxmn+fEkleURuu3RtiXNNcov5rNS0DNFTkgxHP1Z/ZP6ddcknJKtj0YJvdniWJ
G8hhPS/ssAHXkUAkukmUflxyCETwJQRyKCkXp8QLs0hY/EhRSdaolzoGL7VGTLIq
i5BgBhqgUz/m1JSLlP3RcGXLj4S50/dPfzSUOHvB1pN32k227Vt+PyjMoVkV5RSF
v8k3QwmF8QP8CqF519PMIGJHFKV9xsl3VYlyu8O63dm5Kavjh74PpB8umQL59aiA
gl5Agvcu84GRO+IvujdCe6hdxb2kzV0k0RZVR2iP1QHIYeR3IW29Cj1GliF8Eh4D
nB1BKHztRrX/xgWixd8C+p5CPx7p7puTfhsbTePTatkPhv1CCL83NBfftsH2x7iY
wFpsb0Z02jzAxeIt3J4ActH4c/2TmLFMvtB8x8LDfYd64UDM/nGBRhJceskiWOKO
+rR5Sw3+SeKtBLvQVgAx65DEvMt8k1upZRZtw5cecDDpo7qUZK/AaaFNjs7hyqyD
9qROitLKhNzKUjaEHneb
=b4iU
-----END PGP SIGNATURE-----

--0UhZIN3Sa23/ILEd--

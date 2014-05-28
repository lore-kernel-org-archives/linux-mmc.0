From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 03/11] pinctrl: sunxi: Move setting of mux
 to irq type from unmask to set_type
Date: Wed, 28 May 2014 11:39:06 +0200
Message-ID: <20140528093906.GO4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
 <20140527080952.GC4730@lukather>
 <5384544F.6000806@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB5G5S2OAKGQEWOHZ67Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5384544F.6000806-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2014 at 11:01:03AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 05/27/2014 10:09 AM, Maxime Ripard wrote:
> > On Mon, May 26, 2014 at 09:47:58AM +0200, Hans de Goede wrote:
> >> With level triggered interrupt mask / unmask will get called for each
> >> interrupt, doing the somewhat expensive mux setting on each unmask thu=
s is
> >> not a good idea. Instead move it to the set_type callback, which is ty=
pically
> >> done only once for each irq.
> >=20
> > *This* is the bad idea. Nothing prevents you from calling
> > gpio_get_value whenever you just got your interrupt, that will change
> > the muxing, and never change it back, effectively breaking the
> > interrupts.
>=20
> Hmm, interesting point, but your assuming 2 things which are both not tru=
e:
>=20
> 1) That calling gpiod_get_value changes the muxing, which is not true, all
> gpiod_get_value variants end up in drivers/gpio/gpiolib.c _gpiod_get_raw_=
value()
> which does no such thing

Somehow I was convinced it was the case, but yeah, it doesn't really
make much sense, especially since you can get the value of an output,
without wanting to change it to input.

>=20
> 2) That unmask will always get called after the gpio_get_value to restore=
 the mux
> setting for us, which is not guaranteed at all. Before this patch set pin=
ctrl-sunxi.c
> was using handle_simple_irq which does not mask / unmask at all.
>=20
> And even with an irq-handler which masks / unmasks, what if the irq wakes=
 up
> a thread and that thread then does the gpio_get_value ?
>=20
> Note this is *exactly* what e.g. the mmc gpio card-detect code does, it u=
ses
> a thread to read the gpio for debouncing.
>=20
> Luckily 2. is not a problem, since 1. means that the mux won't get change=
d at all
> so we don't need to change it back.

Ok.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTha66AAoJEBx+YmzsjxAgUr8QALuQMqsa7xEoyVm956BpvhM9
94MPksjtcXOgDr0DQtUMTRKsr0dOP2PQhuyKTwLiH9lqtm9LIlc3EO9SSVlYGVGl
RUvl0XOpaZZgODDzwnc/o41uiA/NQ3Ufc0dINAf+Avai0DTNjIBd42pSA6b95wHz
qwv2BA7l4ezb8KgGz0vXzZfVF+FxPadW2wWw6GtS3LUpa2YpL2Fqr6GURzigIVpu
Ji1/5GoeRztoUJ54881EZWXWrVKuQxPPDaTfF1HLqMDhkX2BgeUSyWpwQBsA2ydu
+9N2pEQFQwspARzdzJ03bNWasha7aVBOBAQmZaPqr6+jird1tqPjYqLWbNp1/13a
G5U1/qn01rT1+GL1wEzI6mUPbU3GMlEnqNKdekvm1KG3xHLRSuUQnt97b/zI5u21
MxgGbjHrNbqVejjqQRmplyNaRjK1xJvImYQpJIeY0qO6gmn1aYIL/qEa4njhXo92
GdNkI/tSwUaci2WbYhvojIptDkskYiH8jcc7EfJkFJje9ZlU1KsyoRIyfpdNdwGe
sV+pNewmagHRPOQWnKtV+arXNN3v0RuSxGKhRDiCVknLGOTkZs6vozmViDZh16xZ
HejH/fO1bMxsEjzhR0lRJBZIJ0x0hf9IWoro7D9NadsIyliqfu6nn4t42FEo55nB
8irL58/Z52y/wRD31shr
=vCef
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--

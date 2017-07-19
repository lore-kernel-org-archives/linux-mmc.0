From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 05/11] mmc: sunxi: Support controllers that
 can use both old and new timings
Date: Wed, 19 Jul 2017 13:28:56 +0200
Message-ID: <20170719112856.7vjcsel5cj6f5s5h@flea>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-6-wens@csie.org>
 <20170717091747.kcrlifbp7meihszm@flea>
 <CAGb2v67VmdfrMNLFH=6hhbGAHr15e0q4toDUbJ17d3exS3maFw@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bd2jix6f475lfyof"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBA4FXXFQKGQEXWIGCBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAGb2v67VmdfrMNLFH=6hhbGAHr15e0q4toDUbJ17d3exS3maFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--bd2jix6f475lfyof
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 04:59:23PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 17, 2017 at 5:17 PM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Hi,
> >
> > On Fri, Jul 14, 2017 at 02:42:56PM +0800, Chen-Yu Tsai wrote:
> >> On the SoCs that introduced the new timing mode for MMC controllers,
> >> both the old (where the clock delays are set in the CCU) and new
> >> (where the clock delays are set in the MMC controller) timing modes
> >> are available, and we have to support them both. However there are
> >> two bits that control which mode is active. One is in the CCU, the
> >> other is in the MMC controller. The settings on both sides must be
> >> the same, or nothing will work.
> >>
> >> The CCU's get/set_phase callbacks return -ENOTSUPP when the new
> >> timing mode is active. This provides a way to know which mode is
> >> active on that side, and we can set the bit on the MMC controller
> >> side accordingly.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >> ---
> >>  drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
> >>  1 file changed, 30 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc=
.c
> >> index 0fb4e4c119e1..56e45c65b52d 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -22,6 +22,7 @@
> >>  #include <linux/err.h>
> >>
> >>  #include <linux/clk.h>
> >> +#include <linux/clk/sunxi-ng.h>
> >>  #include <linux/gpio.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/spinlock.h>
> >> @@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
> >>       /* Does DATA0 needs to be masked while the clock is updated */
> >>       bool mask_data0;
> >>
> >> -     bool needs_new_timings;
> >> +     bool has_new_timings;
> >
> > I think we should have both, it's a bit different. Newer SoCs like the
> > A64 can only operate using new timings, while the older ones can
> > operate in both modes.
> >
> > In one case, we're forced to use it, in the other one it's a
> > policy. We should differentiate both cases.
>=20
> For the A64's case, the limit is implied by not having any clk_delays.

FWIW, I'm really not a big fan of that either :)

Explicit is better than implicit.=C2=A9

> But yes, I'll keep "needs_new_timings", and rename the new option to
> "has_timing_switch" to make things clearer.

Great, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--bd2jix6f475lfyof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZb0J4AAoJEBx+YmzsjxAglo8QALargjCFyEB5hU3tIpW6Ra7E
c0XfzP2gdl60I5JiNl/iEuI+maNS6rwON70hmq0JW58rmCc1pGDf5WoLfT8U8tKi
GwXhMqHpCHBpX5y+x5YDdEgOTEiKAVNotmtEgZkaIEnolsxUvYiMD8iTmoYUW6PD
OKSt1HLXCmpsdx0vpYNiHAi0JpEpwBa+WTuzdas6+g4FF4WLx6fhqG03FvwIQ74d
gainmHvUhWMzir8XXq9tSsV9aslCYCn8WmCQT6YWEMdmlxWDUHXxAI1lytd9GosE
kuR4Y//zRk9M9KZuaNeGxy9Pp5+dK0ReX48GkcXTNz0L9hdk7qr1YYW6Xe046i0L
Fliu7OZMw4mAOM0rqHZO5UIONTQ8ltl5N0/ZjsI1T9+A73Zi/+cpHWj9V6Gx8Uj9
aZV8b+mYwptJQOACR74EYWVdTn/EPFFT1MDuBfppE88BMPJaBf4LnZw6Aid/8Q/G
gpULc33RIAmu4sQHJvo4FOOAQ/3uWj0FZQYgkPHFsMXrdswHFbzRvzU0LSCjbuRn
mDUM/aKdJFBPPfhT++5nvCt55sGvczf6i8FVYBg5bigzFoeNUiXNFQ2KAEcAx27q
Z5Yko/t0O6QCSrifvbr206TkIuYnHCRIrcTpzTGq49QRizbz/nAwBrI1Bg8MZQgO
lbb/OtQWwY9RjweQIgqa
=D0Fp
-----END PGP SIGNATURE-----

--bd2jix6f475lfyof--

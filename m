From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: mmc: sunxi: limit A64 MMC2 to
 8K DMA buffer
Date: Tue, 10 Jan 2017 15:06:00 +0100
Message-ID: <20170110140600.wr7qyz3d2ri536mt@lukather>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
 <20170104140750.7qs4pvggwjdj5cma@rob-hp-laptop>
 <20170105175746.fq6crpc3krz7tzxi@lukather>
 <87b26848-4f86-f2d2-3f82-db0937c572e2@arm.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2qmu4zrtesiijmpm"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBU6U2PBQKGQEIEJ77AQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <87b26848-4f86-f2d2-3f82-db0937c572e2-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--2qmu4zrtesiijmpm
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 11:33:28PM +0000, Andr=C3=A9 Przywara wrote:
> On 05/01/17 17:57, Maxime Ripard wrote:
> > Hi Rob,
> >=20
> > On Wed, Jan 04, 2017 at 08:07:50AM -0600, Rob Herring wrote:
> >> On Mon, Jan 02, 2017 at 11:03:43PM +0000, Andre Przywara wrote:
> >>> From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >>>
> >>> Unlike the A64 user manual reports, the third MMC controller on the
> >>> A64 (and the only one capable of 8-bit HS400 eMMC transfers) has a
> >>> DMA buffer size limit of 8KB (much like the very old Allwinner SoCs).
> >>> This does not affect the other two controllers, so introduce a new
> >>> DT compatible string to let the driver use different settings for tha=
t
> >>> particular device. This will also help to enable the high-speed trans=
fer
> >>> modes of that controller later.
> >>>
> >>> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >>> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
> >>>  drivers/mmc/host/sunxi-mmc.c                        | 7 +++++++
> >>>  2 files changed, 8 insertions(+)
> >>
> >> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >=20
> > Some kind of a digression on this: we have three MMC controllers on
> > this SoC. Like this patch shows, the third one is clearly different,
> > and supports both more modes, a wider bus, and specific quirks. We
> > need a new compatible for this one, everything's perfect.
> >=20
> > However, the other two are mostly the same, but seems to need
> > different tuning parameters to get more performances out of the
> > controller (but this is unclear yet). How do we usually deal with
> > that?
>=20
> I guess you wanted to hear Rob's opinion ;-), but "get more performance"
> sounds like we add one (or more) properties to tune those values.
> If I get this right, it works with default values, but is sub-optimal?

That would be my understanding too, at least, it works in a decent way
without fiddling with those parameters.

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

--2qmu4zrtesiijmpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYdOpEAAoJEBx+YmzsjxAgp+EP/3hVaW9DMYH6QpzxZR2sH1Xv
usHFZMrX2IlFUk9Dp5GdMZ1B1Lf0u90CW0kh2pnY3FPEKjsGFiFXjHISQB1NKBc8
Wk9agm+c0FvfKZQ7IQNkx5T6DWRXoibWxJUbjW8+wdG4isR7vwmJkLCSsNzZG8H8
RtjE1tTZjeYiDDXl0osu9M1ozqc26Yoyu3yhTVApzkhG9Z2UANjwItTmcb/lv+Sb
8mFPx5ra9KnWTmL9tJnLVTIC8e+zThcCJtH8IUZJQNqshTJ1WBilnJIuK3HzD2wO
Ew0vkcNjx8h1uxLwNOI4hKi/zch5dwDNuHf+OUv3vMR1nB+Rs2x33rq0rwh3HtNw
001AYRG1Q8Dalf2z0PrWN+bLf+t/LxheXRknwQcqOFZ0KQMNZj0DEO8PXJZe8MMl
vBM6Bfhc83slszRzDcFMKBLl9ryN4nop7SsvgKR7wsROWCXKvXw7jMXOo/2EOTrI
rmqDbL7OiToDyofil4yGuGYxMd3/mDpWcsAnJwMxKzpVd2NiiGQ1aJQPgDDxyzBn
YCO//ZH+RPtgYPJGWfzLeaRNPyHpg4h7cX7AJMnlmf2pbi/it0sD1O2vRNGEsCA2
7cliUT6RFaY5HcSRFFSb3aZq67K1WfaBMYWlx98jCAP7MDdQMyJpbIVNNRaikT4F
4B6igcgJAH43Y3iNdyRH
=tXUP
-----END PGP SIGNATURE-----

--2qmu4zrtesiijmpm--

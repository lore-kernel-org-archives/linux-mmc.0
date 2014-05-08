From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 03/15] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Thu, 8 May 2014 10:35:25 -0500
Message-ID: <20140508153525.GW7047@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-4-git-send-email-hdegoede@redhat.com>
 <CAPDyKFoinhyob7GZLgH4Dm7KdHCxj1+OpuZYKDK3OkU8RFsY8A@mail.gmail.com>
 <53678DB4.60209@redhat.com>
 <CAPDyKFpAGNLaKagJ_RPt1vbz70pNWJzo-s6Ao50Mh0gFrRLN0g@mail.gmail.com>
 <536B69FA.5090600@redhat.com>
 <CAPDyKFqbN61EgiTbktL-vm+L7q06OTeedCTVXJsP16ZZZd8g8A@mail.gmail.com>
 <536B78FF.2020808@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E5HUUwS3R9LcK7+r"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBV6KV2NQKGQEC5M2EUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <536B78FF.2020808-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--E5HUUwS3R9LcK7+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 02:30:55PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 05/08/2014 02:17 PM, Ulf Hansson wrote:
> > On 8 May 2014 13:26, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >> Hi,
> >>
> >> On 05/05/2014 10:33 PM, Ulf Hansson wrote:
> >>> [snip]
> >>>
> >>>> On 05/05/2014 02:41 PM, Ulf Hansson wrote:
> >>>>>> +struct sunxi_mmc_host {
> >>>>>> +       struct mmc_host *mmc;
> >>>>>> +       struct regulator *vmmc;
> >>>>>
> >>>>> Instead of having a specific regulator for this driver, please use =
the
> >>>>> mmc_regulator_get_supply API.
> >>>>
> >>>> We cannot use mmc_regulator_get_supply because for the sunxi mmc con=
troller
> >>>> not only vqmmc but also vmmc itself is optional, and mmc_regulator_g=
et_supply
> >>>> calls devm_regulator_get rather then devm_regulator_get_optional for=
 vmmc.
> >>>
> >>> Is that because the mmc controller handle the power to the card or
> >>> because you have a fixed supply?
> >>>
> >>> Having a fixed regulator supply could easily be set up in DT, which
> >>> then also dynamically gives you the ocr mask instead of having a them
> >>> "hard coded".
> >>
> >> It is because the sdcard slot power tends to be hooked directly to the=
 3.3V
> >> of the board. So in a sense this is a fixed regulator, but I really, R=
EALLY
> >> don't want to add fixed regulator boilerplate to all sunxi dts files f=
or this.
> >=20
> > So, how would you then distinguish between let's say a 3.1V and 3.3V
> > fixed regulator? That is something that is board specific, thus I
> > don't think you can get away from not adding them to DT.
>=20
> All boards I've seen sofar use 3.3V which seems sensible since that is
> what the spec says you must supply to SDSC cards. I agree that if a board
> differs from the standard 3.3V, a fixed regulator node specifying the
> voltage should be added.

I think we introduced the sunxi-regulators DTSI just for this :)

I'd really like to start stabilizing a bit the DT and at least
consider being able to use an older DT on a newer kernel. If we take
such approach, I'm afraid it will break at some point.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--E5HUUwS3R9LcK7+r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTa6Q9AAoJEBx+YmzsjxAgUK8P/j9RBrfHcpZxZfKpEwcIclpU
LXyofwtM4+lC+cIcLQzdHusGJApZVQEqL5e5mG+IsXpw7U2zmi2JhncpHrFeCd/n
5ihsseNn759D3xEVvVHageOAPNQrMmY4O529uaephh6CfBXrMiw5u9e+sdpo4O9M
cJ8PntCz3qQh8N6TL9Bzop/FCKDgqvVJmeGhpfj9DBfGJDjwHAZZL4x6SdnTEY2l
XYQh445rUc2TwUe8k36er5QtgBWqdivpKBMahJQqosq2iPlk51NRHQuykbcQbaCv
zslseOlNdh02PLSkAtKa9UHrD+StxNDtp5Ww8NtMtTod0DgoRI071VVbfQFOuMvW
sATcDigZ65P5252C5bo21cjsAoOCn69lbJuk3vurpojzeP4Hhs9ZV85IWD97vQQZ
OxbXmO85EUQoEnaQkSdbtvEgfFcaaXNXkam+IXS7dinChp3ph7aOZboLQzMGTotz
wUi9WDYViyFkQvjkk1+C6jbhaSJZL5EHNs1naFHfFcG+x+qBYh9SEJ0Jd5eH8H7F
RREUTHMoFDJE9PKhx926wLWSUN+SPcbyRsi3iw5F1dliEnvvOm8bHUZd1st0DKxE
1X8vo1Mv8ZzzCyTx0gvcf+H56DVZ3HNnkzvPE2pkGJ7YKw1seGsZQCthof4RWU05
YODMP823h2QrUroTpEyV
=gXN+
-----END PGP SIGNATURE-----

--E5HUUwS3R9LcK7+r--

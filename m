From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Wed, 28 May 2014 17:43:26 +0100
Message-ID: <20140528164326.GB5099@sirena.org.uk>
References: <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
 <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
 <5385AF94.90004@redhat.com>
 <5385CCE6.9070204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5385CCE6.9070204-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2014 at 01:47:50PM +0200, Tomasz Figa wrote:

> Moreover, there are already WLAN chips available that can use HSIC as
> their host interface and I'm not talking here about some exotic
> products, but rather widely recognized products of Broadcom (BCM4335),
> Marvell (88W8797) or Qualcomm Atheros (AR6004).

> My conclusion is that I see the discussion here being too much focused
> on MMC, especially considering the fact that the whole problem doesn't
> have anything to do with MMC, which is just used as (one of possible)
> host interface.

Right, the other example I keep mentioning for this is Slimbus where
some sort of external power control is required to trigger enumeration
in normal operation for common use cases.

> IMHO, all we need here is a way to tell the MMC (or HSIC) core when to
> look for a new device and when not (e.g. power down the host controller
> completely). Anything else, including proper power sequencing is up to
> the platform driver of such non-discoverable device - it's only its host
> interface that is discoverable when enabled. I believe this simplistic
> approach would lead to much less new code added, better reusability of
> code (power sequencing independent of host interface) and no need to
> create overly generic code, which usually turns out to be not generic
> enough.

We then have the problem of working out where that platform driver comes
=66rom, for many of these buses the device can be completely described as
just a device on the parent bus with some resources connected.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThhIrAAoJELSic+t+oim9YM8P/jCLT64RKMgIpuhagVEUy8CC
o/5rYRld2j/kTt/zmJp3rX0DTBIbv1qCPYiAU/wf+2uBsyYVN2xBKAdlO3kk8iGd
D+djZMBbvnQy06goV7Znz5Osqe3hxoARK1bW9Vn5R0gSfLtxqiVqiXGTuZonXh9t
ydQxUh5EWdgbl2iiwMZM4GT+Xf0WjTN2FW7O8eSt/6ZhOkstOWwjI8hn8QpfO9nY
C1uLaaJCzuSk01obiYmNP+3wiZQurMPCnpDxermRZbLDFSuHH3WUpW9T8vlzKR1Y
GW7toAq7OPTbOHPzzuIHcczPwKAh0trJqtHn4zlhTQCsJQUu5LyfOEOvxfeWYnv9
sizY9JFYUtr4qqNPIwiIyoKSt3TtHm80f5cWzfCIcW81VGwkIB74hFXDZ5PNihMg
h3xA5dPX6Am62SfRa6IeX2fpkL2FvFgsMu3Hce+g1yET1jflFuJGEMloup5d5/Yy
Me2O+bvljtPhO0oJft6wu0FDRuvKQ3WO0LvTZdA/vlAkKMHCeMLMLwgMUhJyerwN
yfmP/UuZODsfsJman3gHlMcS5FuVkqsnXKW9DH4gt9Qr0mX33x070ghddJVgTtHX
KxQ21/z0L3ooGUdM9+yiDFR7HrxSuVj55t9pVToyGKaXh7vFdXAwb4rC5idCKfO7
KJQu6ogrUSv8qPLgQnrt
=VSW1
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

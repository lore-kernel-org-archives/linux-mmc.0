From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Mon, 24 Oct 2016 13:11:06 +0200
Message-ID: <20161024111106.GD1440@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
 <SG2PR06MB11652EB5B1A40583636F8FB28AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20161020231245.GB2199@katana>
 <SG2PR06MB1165F5878C8417068E7364628AD40@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20161021215639.GB1450@katana>
 <CAMuHMdU3q5PTXumWgizK1RG1nK6X6nCq1ySZ6z0DCH0uy+ZB2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46010 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757344AbcJXLLW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 07:11:22 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3q5PTXumWgizK1RG1nK6X6nCq1ySZ6z0DCH0uy+ZB2Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Brandt <Chris.Brandt@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2016 at 01:06:38PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Fri, Oct 21, 2016 at 11:56 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> For the VERSION register, the low byte is the version of the IP, but
> >> the upper byte is a number that the design group that made the part
> >
> > I know. It is just that I haven't seen this one "in the wild" so far.
>=20
> I think you can also see it on your tamed Genmai ;-)

I intentionally did not write "couldn't have seen this" ;)


--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDexJAAoJEBQN5MwUoCm29rsP/RQAAIWwW0bpLj+mdMKLTiIb
o3xH3D4YqLt6emAdra+jsOZ3iua/XAZaKFglG0xFfVNb//8rJdjIvRka7wUnTKSL
WmkKjCMMlfxEFjRZl4/s7vHJmjadRBlFaQAWuReJzZ8NYXNJSwpTfx5Wuux6qy86
8z8BuxqeqdlBMSFM8sLSML32VqdPpHOCD7Q8PhV+p5rj2gG86i3Lh9MCiR2veQ5C
N7MYg0bDjrYpXHrCuY00lefKfnTstTYQvypMTmkR9EXvDWH+yOdXphFq8CZPM6KE
BSnuJg895aVAVtMH8/Krx/Bh+nSQctbp4STlEQVMZfEmgRrqK4JIc8Pk1lIRxPmv
wBzeKM1MfOHlv3qu+Kej3rbqr5dYstKhuQkGPjYe4nea/ZXWEoDjEox4jw17a3D8
8Exi2XAw16zaZhXFXynTyJ4kb28KQVtuQ32JoTrtJhLEJoTuoVvz8eA0+LXwSsVW
zNL75S/jrExrM/J6zdvgwBtJMdDFDKyqCjfyPI5s/OmgrQPoxqsFxrfxumAQceMn
iR6AXW/L2CVsQ+eLWTAC9U8OhfPzlujaWF+JLPLuwTU/PiH4UzKC1ByHuyg9YZNs
X8Fx9X6YL+BVjdOM/Mk2+lI1TwkHP0BYJhhE3HEHB15/Hy9nLJs5/cSNpssiJ6XX
s+Ci/kUC26ARMtTET0qR
=zZ+M
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

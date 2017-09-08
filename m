From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Fri, 8 Sep 2017 10:51:09 +0200
Message-ID: <20170908085109.GA16834@amd>
References: <20170905194739.GA31241@amd>
 <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>
 <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
 <CAPDyKFp3QdVm3oxkMvozuf+hifJi64Fn8T27Gy7Mq8SVpAYTSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp3QdVm3oxkMvozuf+hifJi64Fn8T27Gy7Mq8SVpAYTSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-09-07 14:06:52, Ulf Hansson wrote:
> [...]
>=20
> >
> > From: Adrian Hunter <adrian.hunter@intel.com>
> > Date: Thu, 7 Sep 2017 10:40:35 +0300
> > Subject: [PATCH] mmc: block: Fix incorrectly initialized requests
> >
> > mmc_init_request() depends on card->bouncesz so it must be calculated
> > before blk_init_allocated_queue() starts allocating requests.
> >
> > Reported-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> > Fixes: 304419d8a7e92 ("mmc: core: Allocate per-request data using the b=
lock layer core")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>=20
> Thanks, applied for fixes!

Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmyWf0ACgkQMOfwapXb+vJQxACfXyiTS5MhvJc+sflO25FbPSNA
XjcAnRLJ6+tGkLBRHBolSN7SAdvzxj9B
=clFE
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/29] regulator: fix devm_regulator_put() to call
 regulator_put() explicitly
Date: Fri, 18 May 2012 16:10:55 +0100
Message-ID: <20120518151055.GC4039@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-5-git-send-email-g.liakhovetski@gmx.de>
 <20120503165606.GR3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181053510.23140@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205181053510.23140@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2012 at 10:54:26AM +0200, Guennadi Liakhovetski wrote:

> > > +	regulator_put(regulator);
> > >  	rc = devres_destroy(regulator->dev, devm_regulator_release,
> > >  			    devm_regulator_match, regulator);

> So, shall we rather use your new devres_release() here?

Yes, I already have a patch queued for 3.6 after things propagate
through in the merge window and have a fix based on the current API in
the regulator tree for 3.5 that doesn't have the double free issue.

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtmZ5AAoJEBus8iNuMP3dlq0P/jVIODZDAvbpV4V6g/pxLXqc
6YT2PXTlqiGrIEIAXgDSFckzVy+cCG7H7LcBEvte+A8MghQsOSzhqN5juQe8x743
aEbYm2G4ed+ieacjokFggXMKkwWbUvFLADbffcFjV//LFS9ajqAM7b2GGJZMyGeq
mh2A9EF6nKTjguCccEAEb0aEuKkCgakY9cku7mQWJNeXU1xBvoyR/jTTk1igmSvd
FlPovrGF/7meRk443mGmbCqImmJDxJyX8vBHFjzAtBnGiFWc25GPY8SobX5u/Fix
IHRoZ7Oqdr1NDJtR9KWYK0rPgADBqaqxrl6NOh+5Tv/FaPq0tlPgMv/HAePam1yt
AmynHenYb1HgI+l8BKNYSeS4iCzvgXTm+4WpcQepqtTv9WmTSF49z4b0O7NS19F8
3HQ6Bs5GesN64kJPwjWldVOYqKqmcXj3T6Yo31hRCppWRDF3+FM/oqhHf0QJzHl4
Ik62WlXeEGjqC2O7jFYQkamML3tsvm6b5A/0pz1HdiUqGwa9CE/m4o2JcgyyuBgD
7YsNbEQtcCl/2HiDmsLtmKWj2HLs9+UgkLO9gIH2IQhAygRGc81QmBYuZS7DGlVL
hQA6tR/mWRGJoPzL0kcJHFp9z6jJ/UfQWlpIp00A6QY2iqkx1anT9mYYz6/4DG1i
pUW3WHmyFHl5JM7iQBGz
=6ibH
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

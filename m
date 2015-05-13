From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
Date: Wed, 13 May 2015 16:32:46 +0100
Message-ID: <20150513153246.GY2761@sirena.org.uk>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
 <20150513110915.GG3066@sirena.org.uk>
 <CAPDyKFpkLhC7k+HNCYV_U7M6B615o4RgFktJ1wCXd_SxT0xiQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="72btQdUC6twB1rwh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpkLhC7k+HNCYV_U7M6B615o4RgFktJ1wCXd_SxT0xiQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--72btQdUC6twB1rwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 03:06:47PM +0200, Ulf Hansson wrote:
> On 13 May 2015 at 13:09, Mark Brown <broonie@kernel.org> wrote:

> > Right, and this is probably going beyond the delays that the regulator
> > API is handling since it's not something the regulator hardware is
> > actively managing.

> Thanks for elaborating from the regulator perspective. So may I apply
> your ack for this one?

I guess, yes.

--72btQdUC6twB1rwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU26dAAoJECTWi3JdVIfQUIYH/3eMeM6EavF6dWjGwLZBaf80
GKCuD8peZkrTCCasEblooxND/sBPk+9AoRskhJ/lGwhk4EW3yAn8pBr/inrNTNYG
kEy7j8ZcdxOBjxgvra/sQLJ8J9NS1Yj3PeJ2C6o1p1VvDURqayyBuMNPdWpPORht
C+t+fHCi0DuNCdVAPimTNvu3VfrLrItddx3bRTanyYn8VIu7tCnSAdYtQP3GAEiO
0F90VEJXeaQo6hXEDypNtviC49c3TLd0DWUmgLeRXXA5uTpe6mwBPFwyEfYe4QPe
XGntr4bQX6jxkksPIaQ5NKNafOk/iVln+nX4fwxjV5o/fpPtOOV/uNxb1PhzGa4=
=D3Kx
-----END PGP SIGNATURE-----

--72btQdUC6twB1rwh--

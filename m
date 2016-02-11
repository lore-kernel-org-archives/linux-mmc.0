From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 18:36:40 +0000
Message-ID: <20160211183640.GB1953@sirena.org.uk>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
 <20160211150806.GS19432@atomide.com>
 <20160211155255.GA1953@sirena.org.uk>
 <20160211173620.GU19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211173620.GU19432@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 11, 2016 at 09:36:20AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [160211 07:54]:

> > This does sound like there's been a change in the interface compared to
> > what users are actually doing - is this an actual problem or is it just
> > a divergence from docs?

> It's an actual problem at least on omaps as the omap_device code
> is very picky about the hardware state.

> Depending how the PM runtime is implemented, it may be a problem
> for some other cases too.

Or people just aren't testing mainline that well (if this is broken in
v4.5 that suggests nobody noticed in -next) - do you know when this
broke?  It really seems like we may need to spin round on how this is
deployed.

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWvNSNAAoJECTWi3JdVIfQvDAH/R33v0iExbqNxZ4R/3MlQqpq
Qqjd9BwzT+U6WESAIOqLPV9lJkO35qpHGTZAaDJ2mbetnW+Lw/K3KQeE/Kho6Tz3
ZYJagutqNHbP2fIA4pKHlKwY1MO3O49ca5dD4mO6GCCuYtUy+ytE69N6FHAY5OpY
/Q+rvzVec9zuVOfGmITxE7hhMFxs1MmVCKiIwhxhyV2oo8y8IOs8ZKRvUpQM3Whn
JCXoZWriYDgjbxN6TqCjYooscXXPahNY6/26uJEcEWs6+YDoVApKJklMLkd2510C
hLM2D/o7j5goUqIsNuN81ztD6XOgTJzpUkSJNIrOszgInIiTCXYjlyU4obSSWzY=
=ncHq
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

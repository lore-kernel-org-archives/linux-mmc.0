From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 11:51:28 +0000
Message-ID: <20160211115128.GF13270@sirena.org.uk>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DEfZqDS1MPR2ysog"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455145370-20301-4-git-send-email-tony@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org


--DEfZqDS1MPR2ysog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2016 at 03:02:46PM -0800, Tony Lindgren wrote:

> Mark, I'd like to merge this along with other related fixes via
> the ARM SoC tree if no objections, please review and ack if this
> look OK to you.

Why, I'm not seeing any dependencies here?  I'd also expect to be seeing
an awful lot more changes like this, this shouldn't be an OMAP thing -
do we need to fix the core API and then roll out the transition in a
different way?

--DEfZqDS1MPR2ysog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWvHW/AAoJECTWi3JdVIfQeZAH/R2Kzo+fNp+2bzMytHvEdP24
MptS9ziFSJZXnoIJhTlW+4v1e0UKdfV+0sMx6NAuiWbu0XTz/hBSddIDsDPxejTn
cgLPRl4bJ//U0lZ5SHZVcYAyKTy6bniVzTBulaugKkPNVgmYrirtAvSylyK8p7Ov
eE6RB89yHmP1xzyNY8NupOcg3BVv2Ho73Q3CHdr04dMu6j09ahv7+5VDultCewm0
LDXp1yyF/HqY3bIrYka3f5SYMG6bs2RP8FOSsWKJRzCvOHInqQ3JGBYQ63S9OaLD
xFyq+qEPJWNdqoMsyrc15zQbeXQnsHaYZmqjOuZl3znVe0iVZKX/Mt3mUC4udmw=
=3xLd
-----END PGP SIGNATURE-----

--DEfZqDS1MPR2ysog--

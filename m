From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 15:52:55 +0000
Message-ID: <20160211155255.GA1953@sirena.org.uk>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
 <20160211150806.GS19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211150806.GS19432@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 11, 2016 at 07:08:06AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [160211 03:52]:

> > Why, I'm not seeing any dependencies here?  I'd also expect to be seeing
> > an awful lot more changes like this, this shouldn't be an OMAP thing -
> > do we need to fix the core API and then roll out the transition in a
> > different way?

> Please feel free to pick up this one if you have other fixes
> lined up, nothing stopping that.

I'll take it myself unless there is a strong reason to merge it as part
of another series.

> There will be likely more fixes like this to make drivers follow
> the PM runtime API documentation. These were just the initial
> ones that were obvious.

This does sound like there's been a change in the interface compared to
what users are actually doing - is this an actual problem or is it just
a divergence from docs?

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWvK5WAAoJECTWi3JdVIfQE7QH/3g03VkdaXgc2bDPCzrmonTA
y2oDDu1KuPFAZ51kG7Lv6oBOErT0IeqtBa81h/RVV9Mwfq4dhezSoOA0CrB8NN8K
frG7VzvivMz+qqeu2wj2KIJdtlZIdkn4qr4iKQPQ561NY7l3h7apM6CKeX1j+xiJ
43DL6DK9YUDwLTqs6Ti91bRoSZZ7kaWOazwv4UbjdgD2wIxBBk5ADLpHUTScd+va
UPFoxo3ePs6S10LujriLF1Afq8/pV7Xg3v0mib26sp4Ccg4LBrzGZPYgKj7xTiO1
HloVZPizcXel9tIpfJ9wuF95+pR/1Jr7RlQ8aDBxcBPzYuSIKiwVIaqGcMJ7m+8=
=7zKN
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

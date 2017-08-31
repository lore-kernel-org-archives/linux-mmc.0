From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
Date: Thu, 31 Aug 2017 14:50:50 +0100
Message-ID: <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kk3gqfqn2gwwy4o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ravikumar Kattekola <rk@ti.com>, Sekhar Nori <nsekhar@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--3kk3gqfqn2gwwy4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:

> This patch should be merged along with the 1st patch of the series "mmc: host:
> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
> omap_hsmmc driver.

I can sign a tag if it's needed for a cross tree merge.

--3kk3gqfqn2gwwy4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmoFDoACgkQJNaLcl1U
h9CwHwgAhu/tV8PTV80mZ6LlEt6Rm22iqIkUnjS7WRzHhcWaKHjUNY39a8aXoQMT
cgwLQShDMPYPy+Sr7gqKdJRxoDSa2Opav5pR6UI9LUg7rzvzBvmVGaqNE2hZEWO0
goK+RgIIh5XAjO2Y+y7l3eqRgqtSFF3UhWdZ1oDkSOMw65AYsFGttaPphirNp3vk
OSq4mPbRWzwr691lBdJHNXyanyuIIYNhhRU3bNA2uPp2c+KfNR9PVMFFsozY6IpN
w6HZRfBN/JS4LMkR5T1vpi6XCRnhsAcL25+UV/XXGYBHw9TPQIMbTEiIqDgPhhIS
lCGDTibfaIb03zw8YuI9mnGXsouTAA==
=+9NY
-----END PGP SIGNATURE-----

--3kk3gqfqn2gwwy4o--

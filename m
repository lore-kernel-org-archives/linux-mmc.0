From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 01/10] clk: sunxi-ng: Add interface to query or
 configure MMC timing modes.
Date: Tue, 25 Jul 2017 09:32:29 +0200
Message-ID: <20170725073229.fbm7ead455oudftc@flea>
References: <20170724135905.28855-1-wens@csie.org>
 <20170724135905.28855-2-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wzyrrs3i7h2wwp77"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724135905.28855-2-wens@csie.org>
Sender: linux-clk-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org


--wzyrrs3i7h2wwp77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 09:58:56PM +0800, Chen-Yu Tsai wrote:
> Starting with the A83T SoC, Allwinner introduced a new timing mode for
> its MMC clocks. The new mode changes how the MMC controller sample and
> output clocks are delayed to match chip and board specifics. There are
> two controls for this, one on the CCU side controlling how the clocks
> behave, and one in the MMC controller controlling what inputs to take
> and how to route them.
>=20
> In the old mode, the MMC clock had 2 child clocks providing the output
> and sample clocks, which could be delayed by a number of clock cycles
> measured from the MMC clock's parent.
>=20
> With the new mode, the 2 delay clocks are no longer active. Instead,
> the delays and associated controls are moved into the MMC controller.
> The output of the MMC clock is also halved.
>=20
> The difference in how things are wired between the modes means that the
> clock controls and the MMC controls must match. To achieve this in a
> clear, explicit way, we introduce two functions for the MMC driver to
> use: one queries the hardware for the current mode set, and the other
> allows the MMC driver to request a mode.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wzyrrs3i7h2wwp77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZdvQNAAoJEBx+YmzsjxAgo7sP/A7YmHobs5IO97Mpq4X53u7Z
XC6NfQLYXxSAidX+g/Uusrt+R6RdAdyuKZdrNq0AuxA5lhLbAAb910IiTOH0vATJ
zFQLp3VhpNE2OhyU8eoQyO9OWRNLEVRQrSIj6vwpm1AVYT5sDx8+DCBbLxvnEf7k
fafo+tmnQqIU2qgD0yGnDLsOrVTYHotyHmHCigdi4uVxfpa9i4cfYKlycoi7h9YQ
65iZPdFiDf5pvUEVQUDCh8H+b5wik6S/W1DDYEBuWeg7dwdVEZAL1gHRYm4gwgOn
027/Hefy7+WNj6OEiEGas1/bzJ9Y0afK4eWHgzIjiOzeqeaJeGKRmesy+RoeOkOJ
CAobLroRSzGzToibhA/8dRNZV9mCmonVOOGWRAwtJz5ght7WN5VXhJaoFQWmphaI
AQnlJuby7eEn26IVQ4b/IwiZsDXovphgUH031ND6jXJWo9KT/yHkaEFUm4yS+qPx
j3GGfEyyaZ/1oSqI47g2mVrLia8nFRRPLcZSD5Y3a1qxjF0n/q/aD9Be3Xb391Gn
N/m7qIJNplHo46KvIM9G6alh6irBjY728438xr2BrSXG1t6oOtz3noBMX9nr/gie
ENJGOM6+edKcOEjuBgy7B5xZfLbBcBIEnN3CfImHwUZKSCLNjJhPWTsKk+g4fgHG
BNx4jrO48UqdBNxXYu9o
=5sjE
-----END PGP SIGNATURE-----

--wzyrrs3i7h2wwp77--

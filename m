From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for
 MT8516
Date: Tue, 16 Apr 2019 15:28:14 +0100
Message-ID: <20190416142814.GB4834@sirena.org.uk>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-20-fparent@baylibre.com>
 <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 09:55:41AM +0200, Matthias Brugger wrote:
> On 23/03/2019 22:16, Fabien Parent wrote:
> > Add binding documentation of spi-mt65xx for MT8516 SoC.

> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
> >  1 file changed, 1 insertion(+)

> applied to v5.1-next/dts64

> Mark let me know if you want to take it through your tree and I drop the patch.

Yes, DT bindings generally get reviewed in the subsystem :(

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly15n0ACgkQJNaLcl1U
h9DZ1gf9H2Yrq00KAenFGyeh+9in9sO60dj3xTkLjw+cqBEC68iT6kOwJF1bGe49
cTerjLC7g1Z4O7Fas/ExIVqn6vQ2DYvGTRDEQ/3OyrGJa0mL8WZe5ZxSPBrIqFGN
DM83Tt+WHi26ZhKZ7F3eLtoN8TZcs7mNt9OAi2YF4OnoOS51JSyrOKA1sQn00xGf
uQi9IfnJkLOxel+qQhsefoWYKwNZFcIz2qV4K1eKjcnvZKVW+3OeZ2QJok7qWFNf
g/JHvvdaPgHk0ObyQXGNH83a2urwHLFrWNFWZIIHlR1HfpsOUXcTy4luxYlikFxg
1F4MbBZ6WhZuYSlOJ2pQaNJHhEamgQ==
=t4yQ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

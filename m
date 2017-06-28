From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v3 3/4] mmc: renesas-sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Wed, 28 Jun 2017 16:35:52 +0200
Message-ID: <20170628143552.frzeob5fcwye2pwd@ninjato>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
 <1498053630-7780-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ratlid4iixgu6wu"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498053630-7780-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--3ratlid4iixgu6wu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 04:00:29PM +0200, Simon Horman wrote:
> Add a new variant of the SDHI driver to support R-Car Gen3 with DMA via
> on-chip bus mastering.  Since the DMAC is in a part of the SDHI module it
> is not suitable to be used via DMA Engine.
>=20
> Clearing of DM_CM_INFO1 after DMA thanks to Dirk Behme
>=20
> Cc: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--3ratlid4iixgu6wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTvsgACgkQFA3kzBSg
Kbb18g/+IV6mo3Nk+ef+irmmasWFR7+Cr3pTsV+ZKXSCFNmlk8yMwmipmmJpLbNn
wTYzZCIO9U6ZBVMZPe2nioWeyRklUzWdi4e01YGu6NDHU4U25lAqLS32HULuc9rb
24f/h5D5QIWdHOeBISccWvxzyP2rILkiFIUggDIvW1IqmxSua8/zkZcLv7sVZYZd
oqHnYLuOalmw8MCiexIAUfMEy3BTklh3HJxh+//ZvhuYcT112GeZAAspkgBuDyz3
204SOsrJd/WUAtnWhny0psnD0abBDurKbbPj/aiysfr6cngJSSCE5+s0t0APjafi
BmKGJNLbbWjvqfdCvSKNra5FqH1NaXwhK3wBFIfItp0VANEB1RCEohiMsqCepNFW
IXS/hbA9crKP+OEpyA3b6S68B+XIoRhaY4du7tvaijc7hzzVuOz53JRK2Eg3NJJ+
dzXDy7I3d6bEvjJqpAQ5hWq4mrGy46pQ/OvABubtW2IFWBATTUEPTWQc+rjYitxY
ErU/OXs4M5b+pn/ZeHvkdDPlI/hDzAwWf+xODy+1TBXmzwoCiJLgxBRaXEZrf747
NkoVAS29kmDvqJv7lsLBm/Pk8QVpf+uJVtmEXlqT+yp81vLrYTpnArr8u8JAQpMM
RR9QfHOyuSAYsMwZSOrVcahhTZKHd+2rkzUnVYAbO7SfS1UL6Pw=
=9cf2
-----END PGP SIGNATURE-----

--3ratlid4iixgu6wu--

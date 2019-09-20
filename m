From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] mmc: tegra: Use proper DMA mask
Date: Fri, 20 Sep 2019 18:17:10 +0200
Message-ID: <20190920161710.GA14499@ulmo>
References: <20190920145317.11972-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190920145317.11972-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2019 at 04:53:15PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi,
>=20
> this puts together the two patches from this thread:
>=20
> 	http://patchwork.ozlabs.org/patch/1146705/
>=20
> there hasn't been any activity there for a couple of weeks, so I thought
> I'd just throw them together and update the second patch to work on top
> of the first one.
>=20
> The goal here is to avoid the use of bounce buffers and fix IOVA space
> issues when an IOMMU gets involved. The first patch introduces the
> ->set_dma_mask() host operation as proposed by Adrian and the second
> patch is just a rebase of Nicolin's Tegra SDHCI patch that uses the new
> host operation rather than doing it as part of ->enable_dma().
>=20
> Thierry
>=20
>=20
> Adrian Hunter (1):
>   mmc: sdhci: Let drivers define their DMA mask
>=20
> Nicolin Chen (1):
>   mmc: tegra: Implement ->set_dma_mask()
>=20
>  drivers/mmc/host/sdhci-tegra.c | 48 ++++++++++++++++++++--------------
>  drivers/mmc/host/sdhci.c       | 12 +++------
>  drivers/mmc/host/sdhci.h       |  1 +
>  3 files changed, 33 insertions(+), 28 deletions(-)

Ugh, great. I misspelled linux-mmc@vger.kernel.org in my aliases file...

Ulf, Adrian, do you want me to resend for archival purposes?

Thierry

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2E+4QACgkQ3SOs138+
s6GPBBAAk7XJ/Lol5uZEzvcyyk08wiz0RTwLbRzmTL3kDd+2Ee9FyCjFpGdDnhtQ
ytD4cErUshQ0la0jw0hYrVutGIbOA1F5LOAYflc40D6EXiMAdUYmWUWOfXEzwgQg
rbQnsJqmBTcJ+W1g97BsBSZxRc+ou5w9MBdIaG2As7VAg9+9KjoGMfhN6u5MiGlb
Kz9IAfzDPIyZvDnbW5323tjprroVl4fF3CFEB/k+sSivoEb50dHj6fgXNskji9Pd
SEiTDYXNKHRCHRkmIFGwFR+V0/0sOHucvS5arAaXRRslhXzUHh0aFxrG4nPV0hSZ
u8oW0RF9WCd7Ba+Apu6LnMMKj4zUsWyrejN6sw3A+0DbX14flLXWDA2S26YqSfBu
kt/dloh5rfOj6YhvkHjW2tWZY7A0LlbJGYjMeJ5Qg28oLqOZVbBbFizeo1KCPmCZ
JfPh+qTfmWAyoL9zRj7GfFXBhMUntnMAM0HWl3TIETAzjSKqNnwfM0n6NzxjC1Jq
mWgZcBin6PIjjmiU/LOc22vbvMZWWrd5IMIL+YfPy4MdkvbMGex1Hl4IRWHHYfvA
FpUFMQjuSklTSw5svmHmvJ9O4ZO/lbBU1vdktYT6+tx8wouTnFczfqpAGy2SNyXy
/sTEDBJOKeB7pDl8QFTTmraThmihFgYPytelzYE5VpVlqv1ldww=
=AdTM
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

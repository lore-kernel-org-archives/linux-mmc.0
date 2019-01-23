From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V10 1/4] dt-bindings: mmc: Add supports-cqe property
Date: Wed, 23 Jan 2019 10:15:07 +0100
Message-ID: <20190123091507.GA24072@ulmo>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 11:56:30AM -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for MMC hosts.
>=20
> This property is used to identify the specific host controller
> supporting command queue.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V10]: This patch version moves supports-cqe property from vendor
> 	specific MMC property to common MMC property.
>=20
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIMJgACgkQ3SOs138+
s6HG3w//cxrFZWZQwgA1NKCvuES8D+RpOE/c1K8+foWs8q/kyfEOJ4ormoKWaM72
o6aHTxNbIaoJY8PXgd8Dx3IsBy9DJ6mGbLTz6LZD1+TMegRFxjy4gOAFCe2UljXY
H4tAXZEeeKQ++dsz0UPOddcmlnCQeROSFILth5Em2RQV81NTGSZEYh4xTL9207pw
w2t6dpyt302cM7A1RO7bYWtIk+jW/VHM9UGzs8h5p4oXknzj50KlqL+2YuQ16vAO
3iBQbzNofRyM7yMn9pzIQR2Lr/VAHqGEgbuf5ceVIwo5il/gnj27oyN8luZyXELC
LZcjYnob4L87LdiQL/vnymcr03UrzIdEFXov7kGmLrhRD3WKrrpj8oqvnDJISFEH
QToBuPGp9RIaKWtgimpI81XR0AcztuuMkOPZsDvzwItKr6v4iLvt9/1h3h+bSxWv
I6fWcyfJYSjI8xlXmoWPRGyCcxi+U6y4l1X7c5EPD/uW9C3KYf4IPIsM8JuIb1YK
yLepArovnU/hzIrkPNZimVk5l24lmgsXB6elorbauumiUUsTvxnV7VTxNcE4+IC9
Ty/moEjN8CsWIqHxpJLO1I972RA+LH2an86mBHMO0OAEg4d5+a+n+E+/u+vKwa6a
AOp7fU1HSoih5mf/vRJCZNErDP3AAmcXXx/HNZbiEtoAdMnAyXE=
=doj9
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

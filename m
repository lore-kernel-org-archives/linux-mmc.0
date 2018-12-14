From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V1] mmc: tegra: Fix for SDMMC pads autocal parsing from dt
Date: Fri, 14 Dec 2018 09:46:59 +0100
Message-ID: <20181214084659.GA19965@ulmo>
References: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:25:43PM -0800, Sowjanya Komatineni wrote:
> Some of the SDMMC pads auto calibration values parsed from
> devicetree are assigned incorrectly. This patch fixes it.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTbgEACgkQ3SOs138+
s6G/Hw/9FRc0rkwbf8rQpR3O0Hqm4mr9fInom3F1We8s9MJAMFM8j+ZwcCi3fVir
tBZn2vSvdm6H0isoXDa6ZaHERGWcgcKOO+K3gyMf+iC8qQyLfjEiv6UKWfgyUe/w
2QhUN4h9XrjTaEKZzyXQE+1JHzYX/OOViA5ee8MzzK9C7L7+kcQ88q2SodLlYgxp
JK1NbV6ijIoCz3w4jHJRZ83LUbWnm4kKt5UXWCPvGjx64MFEOSK8g96AMI1pl5b1
wpBP6aLuTNgteNCg3OemFPtpKicKfeS6gCUBG5qh6IeAsbp5w3gXSlsNHBGLuBYJ
5YuCuizy40/qZz/o5mLP+ektXQk2lLjzGsrcrwfLWISUk3Kbmnv0fFbds6IaTBNn
83VbGd9xIwCqK0ItP73dw5lkEW8D+sOwIlKIBBwxCY0v1KovadAdYlYSBfjHpOGv
Gx4Emi3AbW+nuAxHPtvgtMwCEc9JN+i9Vkks1mEZ0dU56FpmglWhq5ybJg3s2bf6
9+/kSqpk8CDhA6YUfXnVfvYZAXAGb5xvbEOF1yE5iH38OJZPMPhwTlD6FNjj+cSR
q/V97yN44x7bNrdaSB9GamzUYMkEVT96aglxdgsCXVo95VlmFZfO5dUf+oA6r8LA
4dRZLri2sgILF2BFmSA4Ce1LfkfPVJpzV34FPcUDMENaK0lvmoc=
=9eTQ
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

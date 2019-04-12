From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V1 2/2] arm64: tegra: enable command queue for tegra186
 sdmmc4
Date: Fri, 12 Apr 2019 17:37:21 +0200
Message-ID: <20190412153721.GB21159@ulmo>
References: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
 <1555011474-20107-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555011474-20107-2-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 12:37:54PM -0700, Sowjanya Komatineni wrote:
> This patch enables command queue support for Tegra186 SDMMC4.
>=20
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlywsLAACgkQ3SOs138+
s6Ez6w/9G4OglGZXk/Rwe6TE1G1g92cvW4k1u/TwGWo/UyM5xrs9deo04ZSns8dJ
svV/yRsNRMIh3yyDAxj/nBmsybtMDzhtUTK6YmZMrPkZtbgrzOINaYltP8Yjd9Lj
+Fj3sDyak3pD9CJo9r3fni24rIbdqMhCYx3ozspf72NOdRG3IF0OecbqI3o+oxKZ
HiNs3e10cvSSWurK3oyIxLVvk0RO+PqL4TKGn2GXlXJbP7Zp5JL0c5nSohTzqfrQ
mC/qPXR4z8UBIwdHysffk/CoJYOQmQ0G6PGqoDC2yCjy8r+6pyx1K8ZTSFY1KamD
xCZ339xQyRYERDPxLZWv7tRDYf00sY8YRetbZKUP0+87yxwwVJtjUN6sHzE/5iua
qGklQU+uUBI3FxDUZulv8MHsRFUc2gW9HMU5XnUP0BwW/7H9cr89JoIwla0t2d1P
jFqYZLjUXtXaMlbNAoX5vh+Jblj9TSYplJ17olPdLZ/kvju8wnIi4atLhNI9P7LC
6NK+8b0IQGmPfibNXzAumlC9EJB/gEoo2BA6Wuj++AxAPJXUqXBDMnjqb+CJ+IQj
McazrlPUA6HD8D3hN2rVDf+ThGROADQnOrgjaUm9ZbkwB0/VD9l85SejOrpQ922w
sdXzrZxS7KQlYkCR950cgb7HhJv13C1SqA9LAzBsgWP4mN0g4nA=
=0Tdg
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

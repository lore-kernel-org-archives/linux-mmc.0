From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Date: Mon, 21 Jan 2019 11:41:40 +0100
Message-ID: <20190121104140.GC16756@ulmo>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:03:50AM -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for Tegra SDMMC.
>=20
> Tegra186 and Tegra194 supports HW Command queue only
> on SDMMC4 controller. This property is used to identify
> command queue support controller in the tegra sdhci driver.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFoeMACgkQ3SOs138+
s6Elsw//XH8GBfof8WNRotmlAsBr8UGEy1Qj03d3EXODZ9sNEA31lfvQIi7tLIOZ
E1qg1C9OMoTF6JjQkUZVEzH+9MwRq8qQIYUASfV/K8VDVNQn4MMTJJiPVd261PC2
8UUV+urpys34zL63rKTlZKi7M6TJuZdxDLK+cfyrLcooj3OhkyJZQzPt/xRUgTIc
tt7pusDKcPQtZLis4fIPxklZu4wCO5xp82FlZ3RBKNhqagiZl5qLFrKvPfRN+8JL
t87kP/BhCjQgCkNbZF2ntct9rYS219BcxBNzqt9yq+bZGBZ2jLQeaJdc1kcwhwD4
WXK1dNeYVa70ijKC60TTS+76dQn8Pl7Rqn+1DbVuqVaMZ3IZMPof21lXqB2d8ELf
/ZpWjVLwxSGfyqSD24tWGNF6mxaxfCY84wJKkr8yT6hviQl1Yo8GbuoMqX64iTo1
nfPgywzf2Xhr/WtzBsVN4glVyfssOS96uQRMEim2H9yWviY5WsjsUp+nP9GwQirL
9cLvjwFsmpMXBUzX8yUSFhpn4tEvx++dVN722SBLcwSj9jZomtNwK6A9FB4lK2+1
zd/GuMckfSdUzkRzktzmNBdQuMgS+PO1PioZVkbMOJ+yDOgPUPVuNx0MXTMDWxxO
vSBZP7MiTd7mFG0Y5gVMDvOAlroN1EYSYlYxzYsgOm03hc8BcIc=
=HyMt
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

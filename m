From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Date: Mon, 21 Jan 2019 11:43:33 +0100
Message-ID: <20190121104333.GD16756@ulmo>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--NklN7DEeGtkPCoo3
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
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..fb14c2c8d7ee 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
>  - nvidia,default-trim : Specify the default outbound clock trimmer
>    value.
>  - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> +- supports-cqe : The presence of this property indicates that the
> +  corresponding controller supports HW command queue feature.
> +  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
> +  controller supports HW Command Queue with eMMC device.

Hi Rob,

are you okay with the property name for this. I'm wondering if it should
have a vendor prefix or not, but I suspect that something like this may
be needed for other vendors as well, so not having a vendor prefix could
be warranted in this case.

Thierry

> =20
>    Notes on the pad calibration pull up and pulldown offset values:
>      - The property values are drive codes which are programmed into the
> --=20
> 2.7.4
>=20

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFolUACgkQ3SOs138+
s6E7EQ//UNWSE3hytU7lm2GZMzGWL1JIUUfBHox5c+CLYu0FbjJb8hpsjBG8PM5K
61CBgHndu7TCuU/6J+HRKLCBETJEJUa6h+Xkj7zWaPeKItFTYF0b+BB4O/WL5bHb
1sXuktkVFezv2UM2m7Xy4AX4sIFzqj1eeWCi6xh2V6FkM3rofOawygqpN+DPhzuz
aLJxuZ9+qIeNtzYdJqBs2AmMHenbvjhlwcNunyuCDyqTMnYf/bt9ny/gIwQ9X7xc
UYsBKoirf7uBJDYyuDG2Bz3sk6+gr5X0Dc9NqtyUBEhZXmog4rr1oEnHQYjuqrXo
UO+DMhNzKj9PNYzLnAbQG02GkcmMFTtx05+7igbI3pRoVr9SnLlALQUUP3bwcj2/
JweBB1j75HH7g+TKJuiALOdQ46i9moTDUszSo8EByhmNUESbuZiXl7yGO6Iv/7HU
dXyRENbiBx4lHTqoeI2z6vqnmdIfg6PL5f22Ei36t6j2ZtGmFrOrbT/BfWK7DSPB
EvsTM20IGIUvUQwwAS9qPan7zeYMmVQkXcMxiMYLzTEfSMFzDMXNvrugRgndprff
8rah2BMB0PeY97bXmLFagsrG8fmlTknEdBooWnSkZrICQonXbGo8A8psd7cNMK2c
4Wmz3oNj8HEhxKOH+Rb/yp6iyAiHSPwVGIx67EDN8kAwiCowS28=
=cgdy
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

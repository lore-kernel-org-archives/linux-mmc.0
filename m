From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
Date: Thu, 9 Aug 2018 13:49:22 +0200
Message-ID: <20180809114922.GN21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
> Add the HS400 DQS trim value for Tegra186 SDMMC4.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra186.dtsi
> index 6e9ef26..9e07bc6 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -313,6 +313,7 @@
>  		nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D <0x0a>;
>  		nvidia,default-tap =3D <0x5>;
>  		nvidia,default-trim =3D <0x9>;
> +		nvidia,dqs-trim =3D <63>;
>  		status =3D "disabled";
>  	};
> =20

Isn't this technically dependent on the board layout and as such would
belong in the board DTS file? Or does this value work on all existing
Tegra186 platforms?

Thierry

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKkIACgkQ3SOs138+
s6FaxhAAkSMLQgzbXmF3OtTbNWRdMzt74oz8j77GI5emDQIIoqQ+pCLWVyXEUT1B
WQ4qw+1pjv9A/D0voG7KgAsdGdjAZ8yeSZlWNr/Fbyv7g+s/5PwSGF4kV0Mvr/ts
UaTNHQhp16yvY+RLoTA14PrbevAMrNibF9DAg9k6uOlndyfqmZWk8HI8PJHLPkSR
1F3EXr3+5T7S0IkjxXLIFutKzzWxZYoo9ETBdGuaCnZUGQK93cWldPAl3FywyHai
WQCJh08lTI+Rg2F18Z5/SSLGzBZ17/jNhv8IYm02JQz4WHmIq2u4bY87mGIX4D/K
ZDui4/NFiIduZ4zZk7CXzy1QjKP/sXUTqnaDYI1NWVWgMF9CqZaBOfhzpWlzo89F
UjTWUHy2fwvkkzPis4rQGX/IAyu8B1cya7VjmArhu6XyYjVMiOlUlm6t2X0V2xA1
rho2tpdmkC04i/ZKTEIFIWEwIQ97Keu1iCKdblmHjCEjmoLml1sP0tkVXDF3uup5
dC7ulRKVnU5NJN84lwZOVOIFVAxJqGL/uP+FDSgniRrH8w94uMsceKEsDGnb3aNh
bxAtQorWWqG84Ujsnw3HbXDllRCEPchcEArS2GiCjd7akO/8gosaXXC3o206HNjW
aCMNHzqTwu8iNJxWY7ME/0eDWAZBy5HeUPqePFYRJqajJoUDE9I=
=MO3S
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--

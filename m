From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Date: Thu, 9 Aug 2018 13:36:09 +0200
Message-ID: <20180809113609.GI21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote:
> Document HS400 DQS trim value device tree property.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 3c7960a..7d294f3 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
>    trimmer value for non-tunable modes.
>  - nvidia,default-trim : Specify the default outbound clock trimmer
>    value.
> +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> =20
>    Notes on the pad calibration pull up and pulldown offset values:
>      - The property values are drive codes which are programmed into the
> @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
>      - The values are programmed to the Vendor Clock Control Register.
>        Please refer to the reference manual of the SoC for correct
>        values.
> +    - The DQS trim values are only used on controllers which support
> +      HS400 timing.

One of these additions says "DQS trim values", the other says "DQS trim
value". It is unclear from the above how many values there are. I think
this should be more explicit. Also, I don't see why the note about which
controllers the DQS trim value(s) applies to is in a separate paragraph.
Couldn't it be moved to the property description?

Also, I think the bindings should specify which generations of Tegra do
support HS400. Where else are people supposed to find that information?

Thierry

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsJygACgkQ3SOs138+
s6F+PQ//Sy+W2dQjwsIevUD60h4o/MYKtvLKHwJAfy7RZJ8Bj9HLJMSE66Sx7+Kn
nZPNrn76YGF6tBXsjgkvMaF2yNOsny9ggCbx8ktdpXyZPAGx7Z5ZNJPai93h1+ea
QXrj7aUxyl1ZgPA7aAA5VbYgwH4xUSD8qhuQBbrZFmlD7KJw0k5+K06S0E3CY8Je
TDEuvIEWMX4WMUOvc/vNK756ieW8r0NrU++iuy6m/11DU+fn29gZ79ThYSFQyNPA
zSCYNf00ec7jN4uCTqVPvUO6/dguNAG80xwJGzkuBiaJXaF1PiWdmXI9iS/JvYgw
4Qs5D1BnM734ysrlwEisju+qgktPNMKl+yrVdkiG6KfWkcOtV4yYzfbnhUoP1UdV
Y8PygMgDQtdfH7aHok4NUoIdetbvYIecdvrvGhqcEIsxWYifUnjbil9lQOzf8PPF
P9Hkp0+MHI86wGJRR5+gIeUKmRN8/LODM6YOGBY0AnVVS3c0gMRGx324MU/gNwkA
qurn0ML81uTrv1U0ANNt6rxRt38hoMHbCThPmvaID580tNgleKbcLRb1t86odlIK
R5McG56coeNySKU6UL5O3nLZsbNeW4nioEYIRgwJ9+un5J+AVd8zpQJRatffgOkl
pFuu4AZuYiHYXsymmBrPK24iqi6MVbYGUpG3AjtnagA3vhyc9KU=
=CKUn
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--

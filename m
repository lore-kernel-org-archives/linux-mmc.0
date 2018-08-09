From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 03/40] dt-bindings: Add Tegra SDHCI pad pdpu offset
 bindings
Date: Thu, 9 Aug 2018 14:18:18 +0200
Message-ID: <20180809121818.GQ21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-4-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-4-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:53PM +0300, Aapo Vienamo wrote:
> Add bindings documentation for pad pull up and pull down offset values to=
 be
> programmed before executing automatic pad drive strength calibration.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 36 ++++++++++++++++=
++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 90c214d..2e973b5 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -24,6 +24,7 @@ Required properties:
>  Optional properties:
>  - power-gpios : Specify GPIOs for power control
> =20
> +Optional properties for Tegra210 and Tegra186:

This looks like a stray addition.

>  Example:
> =20
>  sdhci@c8000200 {
> @@ -45,6 +46,37 @@ Optional properties for Tegra210 and Tegra186:
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- nvidia,only-1-8-v : The presence of this property indicates that the
> +  controller operates at a 1.8 V fixed I/O voltage.
> +- nvidia,pad-autocal-pull-up-offset-3v3,
> +  nvidia,pad-autocal-pull-down-offset-3v3 : Specify drive strength
> +  calibration offsets for 3.3 V signaling modes.
> +- nvidia,pad-autocal-pull-up-offset-1v8,
> +  nvidia,pad-autocal-pull-down-offset-1v8 : Specify drive strength
> +  calibration offsets for 1.8 V signaling modes.
> +- nvidia,pad-autocal-pull-up-offset-3v3-timeout,
> +  nvidia,pad-autocal-pull-down-offset-3v3-timeout : Specify drive
> +  strength used as a fallback in case the automatic calibration times
> +  out on a 3.3 V signaling mode.
> +- nvidia,pad-autocal-pull-up-offset-1v8-timeout,
> +  nvidia,pad-autocal-pull-down-offset-1v8-timeout : Specify drive
> +  strength used as a fallback in case the automatic calibration times
> +  out on a 1.8 V signaling mode.
> +- nvidia,pad-autocal-pull-up-offset-sdr104,
> +  nvidia,pad-autocal-pull-down-offset-sdr104 : Specify drive strength
> +  calibration offsets for SDR104 mode.
> +- nvidia,pad-autocal-pull-up-offset-hs400,
> +  nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
> +  calibration offsets for HS400 mode.

There's no mention here about how many values each of these properties
needs. I guess given that the property names are singular it implies a
single value.

Thierry

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMQoACgkQ3SOs138+
s6Fevg/+MNfOC0Z9TgoTTFq8en1xRYQOPng4O9aKl/54+TC2EtpsPQAcpGQGpqgd
D0FgOxD+hdkdoQwWG0831rxAGW03ICVsVdqnsUOHBeBgDsKA55JVs1Ixl0Hl41cU
RQHD6QYm3iLDjSPi6qintqSidND9fVAU2JHVLdgzQDo+LkFOJ00kcfAheqrl8Keb
1yAm4rN69k1aNwMI6buxo1l8jFk3UJa12AVwseUoZNB9AtzkVf0Ei9EYvoIYiuQ2
Y3aEBJxOmAME5V1Dpy2B0uAIfbrQk0fMbx7KdbycUvARThzj+C8JnVz3O7KgDY24
XkyqDLwfi+VRZiDNPeWOWX45nkTDq+Fvw4WfIzqJB26dYPWm1mh4D+JhG3BgPtdW
F4oohcSmNCpeiu18CUiccKVrn25TcIVJpS2PdryqRGLHTuhpALAwyOThdxA2WAhP
Wfn1LQH8sV1Rmhs18hF7OB1j33LhjkfXiT3lEp0Ouy4Qejm9S6Qj39hzX58c/Et7
Wu9QY/e6VOIok1sMCAEnegfZQjxPKzL0XRztqKaOQ5PjHcrjUlOkpH9Vv+C4We8G
J2jJYeL1D0CANSKDpndk/PT6V50hBzqaXbavFZsPYU7syp7tCejSO21EHkzV8ok2
bFNxgbE05xtuY3U53z0LLW4A1zhoeclPvIbz+cmAwKnFtEstSTI=
=ZtE+
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--

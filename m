From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V1 1/2] arm64: tegra: fix default tap and trim values
Date: Fri, 12 Apr 2019 17:37:03 +0200
Message-ID: <20190412153703.GA21159@ulmo>
References: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4422182962863887650=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, adrian.hunter@intel.com, riteshh@codeaurora.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, jonathanh@nvidia.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--===============4422182962863887650==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 12:37:53PM -0700, Sowjanya Komatineni wrote:
> Default tap and trim values are incorrect for Tegra186 SDMMC4.
> This patch fixes it.
>=20
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlywsJsACgkQ3SOs138+
s6E6Mw//WDz1hmJP1EYdChf14F9QRTs2GQTtCBtMxETTnnXyy2UK8OBXD1evPufF
aGhnAsAUt/T54d+yclfb0u3eN6htIslO3OR/uxX/QQH0rptJEB3xEqbq4dQB66lf
6V2a03V/U41cM4UrXy0/pcYbMY04TlDejqV52inpt5I1wQEehCcFT8pqKGCd/MdH
4H2Vyoo4ffcosaa8WHsYZJnOb3lye3IH5UOeAMMihywH0LU7B5ZT9KZ0phC16dmm
V6SG67mV2MwWpELHCtYrzADJoR/CFjlvVSFipbFqUTthWPCxScQh5A6YIjEb7LZk
ZsGB0AoZH+XV5iignr3mnoj4K8xccp50vhGXuXKYUBMvzInJLyXc/L5vK5kfljeJ
ffwOq5AOnyvSqN+t5OdwnYlS0yKTQyOrfalEo+dXNjCX8W8UgnLaY0JeHFkBR4kE
HIRNBDh9uzt9wJkOJuXrR05UEsIbbeX21Ag0EXNdZ4E4G96gbypiBgtupSQmG6XN
Awj5P54XIv/XLC0mBDEU8X+k1rnoFTWUvL5P4X5toEATvGDxIH9So6cud7luAxQI
BQC7hpEk9uRY05DSVzU1mdTYQpg/kMJU6l6djdJ67dVTLespiYyo9VcEDc19miNP
+DQpVYLW9eZeCZPA1ca1EUjDLpqQZ7Ojfz39e0+JjNqnix8Oyw8=
=L8ba
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


--===============4422182962863887650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4422182962863887650==--

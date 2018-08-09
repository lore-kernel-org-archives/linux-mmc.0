From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 13/40] mmc: tegra: Poll for calibration completion
Date: Thu, 9 Aug 2018 15:44:55 +0200
Message-ID: <20180809134455.GC21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
 <20180809124616.GV21639@ulmo>
 <20180809155638.23f96e61@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="56p9wBiXEyg+KhLM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809155638.23f96e61@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--56p9wBiXEyg+KhLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:56:38PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 14:46:16 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Aug 01, 2018 at 07:32:03PM +0300, Aapo Vienamo wrote:
> > > Implement polling with 10 ms timeout for automatic pad drive strength
> > > calibration.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-=
tegra.c
> > > index 7d98455..c8ff267 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > > +#include <linux/iopoll.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/io.h>
> > > @@ -50,6 +51,9 @@
> > >  #define SDHCI_AUTO_CAL_START			BIT(31)
> > >  #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> > > =20
> > > +#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
> > > +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
> > > +
> > >  #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
> > >  #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
> > >  #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> > > @@ -228,13 +232,20 @@ static void tegra_sdhci_reset(struct sdhci_host=
 *host, u8 mask)
> > > =20
> > >  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
> > >  {
> > > -	u32 val;
> > > +	u32 reg;
> > > +	int ret;
> > > +
> > > +	reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> > > +	reg |=3D SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> > > +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> > >   =20
> >=20
> > I know this is preexisting, but I want to make sure we cover this so we
> > don't run into this down the road: do these bits automatically clear on
> > calibration completion? Can we run these multiple times and get
> > everything properly calibrated?
>=20
> The TRM states in the pad auto-calibration procedure description that
> this bit should not be cleared.

It says that SDHCI_AUTO_CAL_ENABLE shouldn't be cleared after
calibration completes, but I'm wondering how recalibration is going to
happen on a second run.

I guess if we never turn off calibration, then it will continue to run
forever, but does that also work if we go back to a mode that doesn't
require calibration?

So perhaps what we need is to clear SDHCI_AUTO_CAL_ENABLE when going to
such a mode. And perhaps we need to clear SDHCI_AUTO_CAL_START after the
calibration is complete.

Anyway, lots of unanswered questions and if the above works, I'm fine
with merging it as-is. If we find out that something else is needed at a
later point we can always fix it up later.

Thierry

--56p9wBiXEyg+KhLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRVUACgkQ3SOs138+
s6ESZxAAs2NFQ3cNsgDNlKQrmj0UQBmZWM/K7uGfW4pQUPu0E6o7+mKXsVDZh+7V
omu10iibbzbhlWGvOGEjN294m5kHXH5rEuxi54lOFLtXLQAEhdkyG/svRORxGUMp
y3vrcz0XxhQnMPbMKI5FjzQcTRekv1aDko8/ba8FqaTkFA1zb9yqKvRPj/9LBp8I
CWzcPEVuRuCAot4Va4uUHVrF926NU49q9FJ1CEWHceYYMopTX/Zeu14B6AfPYAKG
ur7Zv87kvl4o9bO2/KEsqfKrfaTu3su9sU/YZGoglhwNavAwW6j8jJY8Yveldw8/
FmuB++5KqBftzgrmM08dHhMD4qOXntxPcx9QhSdbGHcZtQ/pgnLQX3TiAVRn3NPh
M2sOG2KnkBmfs9QPA/WruyqbDNsjj/7CHl+4fcm4G+Bp9xxIawH2h9R2D7QIWsMK
DcSUa0X3Z49DExcB7cfbl4eOjoglzDKI+Za2tIu2zDnW3XIxiLh1aOzeO4DuZMVy
8RE8Gbl7FFeQb1xGkzwkWMXbY/IAA1Ycoyl19APFT4LhmSKtleGS96egezlFFX75
9RNF/0ihn+ccVSdIoRbU/AgVy/11Cz3QX84OvRsbdwR+oLO2wUOqBKEvVcvquOzs
vKv2nC/vGKsb28YV9MoNV0lAzd+I89IzrDbun3z5h55Oz0t24kU=
=pnxY
-----END PGP SIGNATURE-----

--56p9wBiXEyg+KhLM--

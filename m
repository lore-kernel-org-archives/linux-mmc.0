From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 12/40] mmc: tegra: Reconfigure pad voltages during
 voltage switching
Date: Thu, 9 Aug 2018 15:14:26 +0200
Message-ID: <20180809131426.GB21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-13-git-send-email-avienamo@nvidia.com>
 <20180809124346.GU21639@ulmo>
 <20180809155239.00265efd@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JoJCGVnM/36AiBh+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809155239.00265efd@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--JoJCGVnM/36AiBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:52:39PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 14:43:46 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Aug 01, 2018 at 07:32:02PM +0300, Aapo Vienamo wrote:
> > > Parse the pinctrl state and nvidia,only-1-8-v properties from the dev=
ice
> > > tree. Validate the pinctrl and regulator configuration before unmaski=
ng
> > > UHS modes. Implement pad voltage state reconfiguration in the mmc
> > > start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
> > > and add set it for Tegra210 and Tegra186.
> > >=20
> > > The pad configuration is done in the mmc callback because the order of
> > > pad reconfiguration and sdhci voltage switch depend on the voltage to
> > > which the transition occurs.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 138 +++++++++++++++++++++++++++++++=
+++++++---
> > >  1 file changed, 131 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-=
tegra.c
> > > index ddf00166..7d98455 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -21,6 +21,8 @@
> > >  #include <linux/io.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/pinctrl/consumer.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/mmc/card.h>
> > >  #include <linux/mmc/host.h>
> > > @@ -55,6 +57,7 @@
> > >  #define NVQUIRK_ENABLE_SDR104		BIT(4)
> > >  #define NVQUIRK_ENABLE_DDR50		BIT(5)
> > >  #define NVQUIRK_HAS_PADCALIB		BIT(6)
> > > +#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
> > > =20
> > >  struct sdhci_tegra_soc_data {
> > >  	const struct sdhci_pltfm_data *pdata;
> > > @@ -66,8 +69,12 @@ struct sdhci_tegra {
> > >  	struct gpio_desc *power_gpio;
> > >  	bool ddr_signaling;
> > >  	bool pad_calib_required;
> > > +	bool pad_control_available;
> > > =20
> > >  	struct reset_control *rst;
> > > +	struct pinctrl *pinctrl_sdmmc;
> > > +	struct pinctrl_state *pinctrl_state_3v3;
> > > +	struct pinctrl_state *pinctrl_state_1v8;
> > >  };
> > > =20
> > >  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> > > @@ -138,12 +145,46 @@ static unsigned int tegra_sdhci_get_ro(struct s=
dhci_host *host)
> > >  	return mmc_gpio_get_ro(host->mmc);
> > >  }
> > > =20
> > > +static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host=
 *host)
> > > +{
> > > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> > > +	int has_1v8, has_3v3; =20
> >=20
> > Can these be boolean?
>=20
> In some cases regulator_is_supported_voltage() can return a negative
> error code.

Okay, that's fine then.

Thierry

--JoJCGVnM/36AiBh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsPjIACgkQ3SOs138+
s6EEEw//Yls8UaQngkn+4wjkqO0q8BxTMos/Ff8tXJxw6JlckEbmVU+DES/iZ5eo
XNg1JtVE46aJ1D4A0MM7+JLBPOjammhuqax80pf1szfzXYdBhBRBbEy2tfALgdSp
7fdDevIcgtnbSCy3yInGTdUD1Qxo6WTgZ5of7gIC/HVCBHsLF0G63te4tzoxCAm8
4tfibOAAPkZMDQmwpunlcAo4C2Pt7UW32MD8yWnFzhnjpChm10WcldE4239KX4Oc
mOP0nZJoIGqETBmYuz8rkOZHFOylipKp0iiEqTvfGnnkf4dK+i2ZNRZ5QeX6QTgv
C+tCT319q3tvxaehHBSfRxzT019ooSjS9WHyjgy7j2WapXW0+86qqnXQzgX4eqs1
zD6c2M3av994kS6EgFS3fdrOG1dUmcc+x+ebdoVj8Mji38pf/hGlD8FqeqThU1ol
7R/8BmfAeXgRJarO7MP65emMbGXQVe3yo0bMIJNz3vOYA4xDm3XGBNSbsqm7cGuk
MNaLmCUDArgS8iNyt6GuWUT/475cAQyexVLWk66fobR9ksmjubHdwvYddN48WfYo
QvHMd/ZrJLNFC8yEmcF06PMU3ChyvA0PzeI4+LyDsWyD+/eGlZoJWdCjruAD00/W
YwK1VUKal6OgGMl5CIX2QyD9o6/2G6SfZDPk+7N0iS+z4Rlw41Q=
=mO+9
-----END PGP SIGNATURE-----

--JoJCGVnM/36AiBh+--

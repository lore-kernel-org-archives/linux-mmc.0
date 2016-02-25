From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Thu, 25 Feb 2016 20:32:51 +0100
Message-ID: <1456428771.7433.4.camel@lynxeye.de>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
	 <CAPDyKFowEH=4PU1ErNxMA0=SiDT1Q86H0SfMuiH5jA+H7mvquA@mail.gmail.com>
	 <56CECC9E.9010501@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56CECC9E.9010501-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, den 25.02.2016, 09:42 +0000 schrieb Jon Hunter:
> Hi Adrian, Lucas,
>=20
> On 18/02/16 16:07, Ulf Hansson wrote:
> > +Adrian
> >=20
> > On 18 February 2016 at 15:48, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > wrote:
> > > SD card support for Tegra114 started failing after commit
> > > a8e326a911d3
> > > ("mmc: tegra: implement module external clock change") was
> > > merged. This
> > > commit was part of a series to enable UHS-I modes for Tegra. To
> > > workaround this problem for now, only disable UHS-I modes for
> > > Tegra114
> > > and in order to do this it is necessary to revert changes from
> > > commits
> > > a8e326a911d3 ("mmc: tegra: implement module external clock
> > > change"),
> > > c3c2384c3ac0 ("mmc: tegra: implement UHS tuning"), 7ad2ed1dfcbe
> > > ("mmc: tegra: enable UHS-I modes") that impact Tegra114. To do
> > > this so
> > > that UHS-I mode can be disabled for Tegra114 but not for Tegra124
> > > separate the platform data, soc data and sdhci-ops so they are no
> > > longer
> > > common to both Tegra114 and Tegra124.
> > >=20
> > > Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock
> > > change")
> > >=20
> > > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > This looks okay to me, although I need and ack from Adrian to pick
> > up
> > this for fixes. Adrian did recently step in as the maintainer for
> > sdhci.
>=20
> Are you guys ok with this? It would be good to get your ACK's so that
> Ulf can pick it up.
>=20
I don't see why you need to duplicate the=C2=A0tegra114_sdhci_ops.
Together with the first hunk of this patch, having=C2=A0soc_data_tegra1=
14
not set any UHS-I capabilities (quirks) should be enough to disable
UHS-I modes on Tegra114. The core should never call any of the UHS-I
related functions from tegra114_sdhci_ops in that case.

Regards,
Lucas

> Jon
>=20
> > > ---
> > > =C2=A0drivers/mmc/host/sdhci-tegra.c | 42
> > > +++++++++++++++++++++++++++++++++++++-----
> > > =C2=A01 file changed, 37 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c
> > > b/drivers/mmc/host/sdhci-tegra.c
> > > index 83c4bf7bc16c..bc7a0847e316 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -147,10 +147,16 @@ static void tegra_sdhci_reset(struct
> > > sdhci_host *host, u8 mask)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Advertise UHS =
modes as supported by host */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (soc_data->nvq=
uirks & NVQUIRK_ENABLE_SDR50)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_SDR=
50;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0misc_ctrl &=3D ~SDHCI_MISC_CTRL_ENABLE_SDR50;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (soc_data->nvq=
uirks & NVQUIRK_ENABLE_DDR50)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_DDR=
50;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0misc_ctrl &=3D ~SDHCI_MISC_CTRL_ENABLE_DDR50;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (soc_data->nvq=
uirks & NVQUIRK_ENABLE_SDR104)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_SDR=
104;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0misc_ctrl &=3D ~SDHCI_MISC_CTRL_ENABLE_SDR104;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sdhci_writel(host=
, misc_ctrl,
> > > SDHCI_TEGRA_VENDOR_MISC_CTRL);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk_ctrl =3D sdhc=
i_readl(host,
> > > SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> > > @@ -315,6 +321,32 @@ static const struct sdhci_ops
> > > tegra114_sdhci_ops =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write_w=C2=A0=C2=
=A0=C2=A0=C2=A0=3D tegra_sdhci_writew,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write_l=C2=A0=C2=
=A0=C2=A0=C2=A0=3D tegra_sdhci_writel,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_clock=C2=A0=C2=
=A0=3D tegra_sdhci_set_clock,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_bus_width =3D sdh=
ci_set_bus_width,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.reset=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D tegra_sdhci_reset,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_uhs_signaling =3D=
 sdhci_set_uhs_signaling,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_max_clock =3D sdh=
ci_pltfm_clk_get_max_clock,
> > > +};
> > > +
> > > +static const struct sdhci_pltfm_data sdhci_tegra114_pdata =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.quirks =3D SDHCI_QUIR=
K_BROKEN_TIMEOUT_VAL |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK=
 |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_SINGLE_POWER_WRITE |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_NO_HISPD_BIT |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DES=
C |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ops=C2=A0=C2=A0=3D &t=
egra114_sdhci_ops,
> > > +};
> > > +
> > > +static const struct sdhci_tegra_soc_data soc_data_tegra114 =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pdata =3D &sdhci_tegr=
a114_pdata,
> > > +};
> > > +
> > > +static const struct sdhci_ops tegra124_sdhci_ops =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_ro=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D tegra_sdhci_get_ro,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read_w=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D tegra_sdhci_readw,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write_w=C2=A0=C2=A0=C2=
=A0=C2=A0=3D tegra_sdhci_writew,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write_l=C2=A0=C2=A0=C2=
=A0=C2=A0=3D tegra_sdhci_writel,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_clock=C2=A0=C2=A0=
=3D tegra_sdhci_set_clock,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_bus_width =3D=
 tegra_sdhci_set_bus_width,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.reset=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=3D tegra_sdhci_reset,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.platform_execute=
_tuning =3D tegra_sdhci_execute_tuning,
> > > @@ -322,7 +354,7 @@ static const struct sdhci_ops
> > > tegra114_sdhci_ops =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_max_clock =3D=
 tegra_sdhci_get_max_clock,
> > > =C2=A0};
> > >=20
> > > -static const struct sdhci_pltfm_data sdhci_tegra114_pdata =3D {
> > > +static const struct sdhci_pltfm_data sdhci_tegra124_pdata =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.quirks =3D SDHCI=
_QUIRK_BROKEN_TIMEOUT_VAL |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_DATA_TIMEOUT_USES=
_SDCLK |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_SINGLE_POWER_WRIT=
E |
> > > @@ -330,11 +362,11 @@ static const struct sdhci_pltfm_data
> > > sdhci_tegra114_pdata =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_BROKEN_ADMA_ZEROL=
EN_DESC |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SDHCI_QUIRK_CAP_CLOCK_BASE_BR=
OKEN,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.quirks2 =3D SDHC=
I_QUIRK2_PRESET_VALUE_BROKEN,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ops=C2=A0=C2=A0=3D &t=
egra114_sdhci_ops,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ops=C2=A0=C2=A0=3D &t=
egra124_sdhci_ops,
> > > =C2=A0};
> > >=20
> > > -static const struct sdhci_tegra_soc_data soc_data_tegra114 =3D {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pdata =3D &sdhci_tegr=
a114_pdata,
> > > +static const struct sdhci_tegra_soc_data soc_data_tegra124 =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.pdata =3D &sdhci_tegr=
a124_pdata,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.nvquirks =3D NVQ=
UIRK_ENABLE_SDR50 |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVQUIRK_ENABLE_DD=
R50 |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NVQUIRK_ENABLE_SD=
R104,
> > > @@ -357,7 +389,7 @@ static const struct sdhci_tegra_soc_data
> > > soc_data_tegra210 =3D {
> > >=20
> > > =C2=A0static const struct of_device_id sdhci_tegra_dt_match[] =3D=
 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D=
 "nvidia,tegra210-sdhci", .data =3D
> > > &soc_data_tegra210 },
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "nvi=
dia,tegra124-sdhci", .data =3D
> > > &soc_data_tegra114 },
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "nvi=
dia,tegra124-sdhci", .data =3D
> > > &soc_data_tegra124 },
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D=
 "nvidia,tegra114-sdhci", .data =3D
> > > &soc_data_tegra114 },
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D=
 "nvidia,tegra30-sdhci", .data =3D
> > > &soc_data_tegra30 },
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D=
 "nvidia,tegra20-sdhci", .data =3D
> > > &soc_data_tegra20 },
> > > --
> > > 2.1.4
> > >=20

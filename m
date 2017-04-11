From: "Y.B. Lu" <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [v3, 2/7] mmc: sdhci-of-esdhc: add support for signal voltage
 switch
Date: Tue, 11 Apr 2017 05:20:27 +0000
Message-ID: <DB6PR0401MB2536429268B58A13C69C5808F8000@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <1490600982-5410-3-git-send-email-yangbo.lu@nxp.com>
 <e7e08c87-ecd6-ab24-636c-7707a5172b08@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e7e08c87-ecd6-ab24-636c-7707a5172b08-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Xiaobo Xie <xiaobo.xie-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,


> -----Original Message-----
> From: linux-mmc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-mmc-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Adrian Hunter
> Sent: Monday, April 10, 2017 8:38 PM
> To: Y.B. Lu; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Rob Herring=
;
> Mark Rutland; Catalin Marinas; Will Deacon
> Cc: Xiaobo Xie
> Subject: Re: [v3, 2/7] mmc: sdhci-of-esdhc: add support for signal
> voltage switch
>=20
> On 27/03/17 10:49, Yangbo Lu wrote:
> > eSDHC supports signal voltage switch from 3.3v to 1.8v by
> > eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
> > signal SDHC_VS, and there must be a control circuit out of eSDHC to
> > change the signal voltage according to SDHC_VS output signal.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
>=20
> Apart from minor comment below:
>=20
> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> > ---
> > Changes for v2:
> > 	- Used Adrain's method to support voltage switching:
> >           host->mmc_host_ops.start_signal_voltage_switch =3D
> >                      esdhc_signal_voltage_switch; Changes for v3:
> > 	- Put .start_signal_voltage_switch assigning after IS_ERR(host)
> check.
> > ---
> >  drivers/mmc/host/sdhci-esdhc.h    |  1 +
> >  drivers/mmc/host/sdhci-of-esdhc.c | 74
> > +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h
> > b/drivers/mmc/host/sdhci-esdhc.h index 5343fc0..6869567 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -37,6 +37,7 @@
> >
> >  /* Protocol Control Register */
> >  #define ESDHC_PROCTL			0x28
> > +#define ESDHC_VOLT_SEL			0x00000400
> >  #define ESDHC_CTRL_4BITBUS		(0x1 << 1)
> >  #define ESDHC_CTRL_8BITBUS		(0x2 << 1)
> >  #define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 7ce1caf..a70499a 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/sys_soc.h>
> > @@ -559,6 +560,76 @@ static void esdhc_reset(struct sdhci_host *host,
> u8 mask)
> >  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);  }
> >
> > +/* The SCFG, Supplemental Configuration Unit, provides SoC specific
> > + * configuration and status registers for the device. There is a
> > + * SDHC IO VSEL control register on SCFG for some platforms. It's
> > + * used to support SDHC IO voltage switching.
> > + */
> > +static const struct of_device_id scfg_device_ids[] =3D {
> > +	{ .compatible =3D "fsl,t1040-scfg", },
> > +	{ .compatible =3D "fsl,ls1012a-scfg", },
> > +	{ .compatible =3D "fsl,ls1046a-scfg", },
> > +	{}
> > +};
> > +
> > +/* SDHC IO VSEL control register definition */
> > +#define SCFG_SDHCIOVSELCR	0x408
> > +#define SDHCIOVSELCR_TGLEN	0x80000000
> > +#define SDHCIOVSELCR_VSELVAL	0x60000000
> > +#define SDHCIOVSELCR_SDHC_VS	0x00000001
> > +
> > +static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
> > +				       struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host =3D mmc_priv(mmc);
> > +	struct device_node *scfg_node;
> > +	void __iomem *scfg_base =3D NULL;
> > +	u32 sdhciovselcr;
> > +	u32 val;
> > +
> > +	/*
> > +	 * Signal Voltage Switching is only applicable for Host Controllers
> > +	 * v3.00 and above.
> > +	 */
> > +	if (host->version < SDHCI_SPEC_300)
> > +		return 0;
> > +
> > +	val =3D sdhci_readl(host, ESDHC_PROCTL);
> > +
> > +	switch (ios->signal_voltage) {
> > +	case MMC_SIGNAL_VOLTAGE_330:
> > +		val &=3D ~ESDHC_VOLT_SEL;
> > +		sdhci_writel(host, val, ESDHC_PROCTL);
> > +		return 0;
> > +	case MMC_SIGNAL_VOLTAGE_180:
> > +		scfg_node =3D of_find_matching_node(NULL, scfg_device_ids);
> > +		if (scfg_node)
> > +			scfg_base =3D of_iomap(scfg_node, 0);
> > +		if (scfg_base) {
> > +			sdhciovselcr =3D SDHCIOVSELCR_TGLEN |
> > +				       SDHCIOVSELCR_VSELVAL;
> > +			iowrite32be(sdhciovselcr,
> > +				scfg_base + SCFG_SDHCIOVSELCR);
>=20
> In other places there is support for little endian also, so why not here?

[Lu Yangbo-B47093] The SCFG unit is always a big-endian module on both ARM =
and PPC QorIQ platforms.
There is little possibility to have little-endian in future.

>=20
> > +
> > +			val |=3D ESDHC_VOLT_SEL;
> > +			sdhci_writel(host, val, ESDHC_PROCTL);
> > +			mdelay(5);
> > +
> > +			sdhciovselcr =3D SDHCIOVSELCR_TGLEN |
> > +				       SDHCIOVSELCR_SDHC_VS;
> > +			iowrite32be(sdhciovselcr,
> > +				scfg_base + SCFG_SDHCIOVSELCR);
> > +			iounmap(scfg_base);
> > +		} else {
> > +			val |=3D ESDHC_VOLT_SEL;
> > +			sdhci_writel(host, val, ESDHC_PROCTL);
> > +		}
> > +		return 0;
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> >  #ifdef CONFIG_PM_SLEEP
> >  static u32 esdhc_proctl;
> >  static int esdhc_of_suspend(struct device *dev) @@ -714,6 +785,9 @@
> > static int sdhci_esdhc_probe(struct platform_device *pdev)
> >  	if (IS_ERR(host))
> >  		return PTR_ERR(host);
> >
> > +	host->mmc_host_ops.start_signal_voltage_switch =3D
> > +		esdhc_signal_voltage_switch;
> > +
> >  	esdhc_init(pdev, host);
> >
> >  	sdhci_get_of_property(pdev);
> >
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

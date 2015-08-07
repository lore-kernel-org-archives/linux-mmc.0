From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v4 1/6] mmc: sdhci-esdhc-imx: add imx7d support and
 support HS400
Date: Fri, 7 Aug 2015 19:19:38 +0800
Message-ID: <20150807111937.GD6935@shlinux1.ap.freescale.net>
References: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
 <1438771122-8601-2-git-send-email-haibo.chen@freescale.com>
 <20150807073854.GA6935@shlinux1.ap.freescale.net>
 <BY1PR03MB138813618D918A609ED1D7ED9A730@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0137.outbound.protection.outlook.com ([65.55.169.137]:9023
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752017AbbHGL3Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Aug 2015 07:29:16 -0400
Content-Disposition: inline
In-Reply-To: <BY1PR03MB138813618D918A609ED1D7ED9A730@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen Haibo-B51421 <Haibo.Chen@freescale.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "johan.derycke@barco.com" <johan.derycke@barco.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, Estevam Fabio-R49496 <Fabio.Estevam@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Aug 07, 2015 at 05:53:01PM +0800, Chen Haibo-B51421 wrote:
> 
> 
> > -----Original Message-----
> > From: Dong Aisheng [mailto:aisheng.dong@freescale.com]
> > Sent: Friday, August 07, 2015 3:39 PM
> > To: Chen Haibo-B51421
> > Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> > ijc+devicetree@hellion.org.uk; galak@codeaurora.org; shawnguo@kernel.org;
> > kernel@pengutronix.de; linux@arm.linux.org.uk; ulf.hansson@linaro.org;
> > johan.derycke@barco.com; mkl@pengutronix.de; Estevam Fabio-R49496; Dong
> > Aisheng-B29396; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org
> > Subject: Re: [PATCH v4 1/6] mmc: sdhci-esdhc-imx: add imx7d support and
> > support HS400
> > 
> > On Wed, Aug 05, 2015 at 06:38:37PM +0800, Haibo Chen wrote:
> > > The imx7d usdhc is derived from imx6sx, the difference is that imx7d
> > > support HS400.
> > >
> > > So introduce a new compatible string for imx7d and add HS400 support
> > > for imx7d usdhc.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 81
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 81 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index c6b9f64..48f009c 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -44,6 +44,7 @@
> > >  #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
> > >  #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
> > >  #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
> > > +#define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
> > >  /* Bits 3 and 6 are not SDHCI standard definitions */
> > >  #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
> > >  /* Tuning bits */
> > > @@ -60,6 +61,16 @@
> > >  #define  ESDHC_TUNE_CTRL_MIN		0
> > >  #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
> > >
> > > +/* strobe dll register */
> > > +#define ESDHC_STROBE_DLL_CTRL		0x70
> > > +#define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
> > > +#define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
> > > +#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
> > > +
> > > +#define ESDHC_STROBE_DLL_STATUS		0x74
> > > +#define ESDHC_STROBE_DLL_STS_REF_LOCK	(1 << 1)
> > > +#define ESDHC_STROBE_DLL_STS_SLV_LOCK	0x1
> > > +
> > >  #define ESDHC_TUNING_CTRL		0xcc
> > >  #define ESDHC_STD_TUNING_EN		(1 << 24)
> > >  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */ @@
> > > -120,6 +131,11 @@
> > >  #define ESDHC_FLAG_ERR004536		BIT(7)
> > >  /* The IP supports HS200 mode */
> > >  #define ESDHC_FLAG_HS200		BIT(8)
> > > +/* The IP supports HS400 mode */
> > > +#define ESDHC_FLAG_HS400		BIT(9)
> > > +
> > > +/* A higher clock ferquency than this rate requires strobell dll
> > control */
> > > +#define ESDHC_STROBE_DLL_CLK_FREQ	100000000
> > >
> > >  struct esdhc_soc_data {
> > >  	u32 flags;
> > > @@ -156,6 +172,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data = {
> > >  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,  };
> > >
> > > +static struct esdhc_soc_data usdhc_imx7d_data = {
> > > +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> > > +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> > > +			| ESDHC_FLAG_HS400,
> > > +};
> > > +
> > >  struct pltfm_imx_data {
> > >  	u32 scratchpad;
> > >  	struct pinctrl *pinctrl;
> > > @@ -199,6 +221,7 @@ static const struct of_device_id imx_esdhc_dt_ids[]
> > = {
> > >  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
> > >  	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
> > >  	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
> > > +	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
> > >  	{ /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids); @@ -274,6 +297,9 @@ static
> > > u32 esdhc_readl_le(struct sdhci_host *host, int reg)
> > >  				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
> > >  					| SDHCI_SUPPORT_SDR50
> > >  					| SDHCI_USE_SDR50_TUNING;
> > > +
> > > +			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> > > +				val |= SDHCI_SUPPORT_HS400;
> > >  		}
> > >  	}
> > >
> > > @@ -774,6 +800,7 @@ static int esdhc_change_pinstate(struct sdhci_host
> > *host,
> > >  		break;
> > >  	case MMC_TIMING_UHS_SDR104:
> > >  	case MMC_TIMING_MMC_HS200:
> > > +	case MMC_TIMING_MMC_HS400:
> > >  		pinctrl = imx_data->pins_200mhz;
> > >  		break;
> > >  	default:
> > > @@ -784,6 +811,44 @@ static int esdhc_change_pinstate(struct sdhci_host
> > *host,
> > >  	return pinctrl_select_state(imx_data->pinctrl, pinctrl);  }
> > >
> > > +/*
> > > + * For HS400 eMMC, there is a data_strobe line, this signal is
> > > +generated
> > > + * by the device and used for data output and CRC status response
> > > +output
> > > + * in HS400 mode. The frequency of this signal follows the frequency
> > > +of
> > > + * CLK generated by host. Host receive the data which is aligned to
> > > +the
> > > + * edge of data_strobe line. Due to the time delay between CLK line
> > > +and
> > > + * data_strobe line, if the delay time is larger than one clock
> > > +cycle,
> > > + * then CLK and data_strobe line will misaligned, read error shows up.
> > > + * So when the CLK is higher than 100MHz, each clock cycle is short
> > > +enough,
> > > + * host should config the delay target.
> > > + */
> > > +static void esdhc_set_strobe_dll(struct sdhci_host *host) {
> > > +	u32 v;
> > > +
> > > +	if (host->mmc->actual_clock > ESDHC_STROBE_DLL_CLK_FREQ) {
> > > +		/* force a reset on strobe dll */
> > > +		writel(ESDHC_STROBE_DLL_CTRL_RESET,
> > > +			host->ioaddr + ESDHC_STROBE_DLL_CTRL);
> > > +		/*
> > > +		 * enable strobe dll ctrl and adjust the delay target
> > > +		 * for the uSDHC loopback read clock
> > > +		 */
> > > +		v = ESDHC_STROBE_DLL_CTRL_ENABLE |
> > > +			(7 << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
> > > +		writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
> > > +		/* wait 1us to make sure strobe dll status register stable */
> > > +		udelay(1);
> > > +		v = readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
> > > +		if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
> > > +			dev_warn(mmc_dev(host->mmc),
> > > +				"warning! HS400 strobe DLL status REF not
> > lock!\n");
> > > +		if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
> > > +			dev_warn(mmc_dev(host->mmc),
> > > +				"warning! HS400 strobe DLL status SLV not
> > lock!\n");
> > > +	}
> > > +}
> > > +
> > >  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned
> > > timing)  {
> > >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@ -795,7
> > > +860,13 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host,
> > unsigned timing)
> > >  	case MMC_TIMING_UHS_SDR25:
> > >  	case MMC_TIMING_UHS_SDR50:
> > >  	case MMC_TIMING_UHS_SDR104:
> > > +		break;
> > >  	case MMC_TIMING_MMC_HS200:
> > > +		/* disable ddr mode and disable HS400 mode */
> > > +		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) &
> > > +			~(ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN),
> > > +			host->ioaddr + ESDHC_MIX_CTRL);
> > > +		imx_data->is_ddr = 0;
> > 
> > Can you please explain why need above code?
> > Any issues if not do it?
> > 
> > Regards
> > Dong Aisheng
> 
> [haibo] currently, mmc core code use mmc_retune before every request,
> and in mmc_retune, for eMMC, if the chip is in HS400 mode, firstly,
> the code use mmc_hs400_to_hs200() to change the emmc chip work in
> HS200 mode, and execute the tuning, and then use mmc_hs200_to_hs400()
> to make the emmc chip work back in HS400 mode.
> 
> Without the above code, when change to hs200 mode from hs400 mode, our
> host still enable ddr mode and enable hs400 mode, which is wrong.
> So add the code here. 
> 

Okay, understand.
Clearing only for HS200 case is a bit confusing.
A common rule to do it might be:
Step 1) Clear exist timing setting at first
Step 2) Set the required timing for each case

I'd suggest you do like as follows:

m = readl(host->ioaddr + ESDHC_MIX_CTRL);
m &=~(ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN);
imx_data->is_ddr = 0;

Then
case HS200:
...
case HS400:
...

Regards
Dong Aisheng

> > 
> > >  		break;
> > >  	case MMC_TIMING_UHS_DDR50:
> > >  	case MMC_TIMING_MMC_DDR52:
> > > @@ -813,6 +884,13 @@ static void esdhc_set_uhs_signaling(struct
> > sdhci_host *host, unsigned timing)
> > >  			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
> > >  		}
> > >  		break;
> > > +	case MMC_TIMING_MMC_HS400:
> > > +		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) |
> > > +				ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN,
> > > +				host->ioaddr + ESDHC_MIX_CTRL);
> > > +		imx_data->is_ddr = 1;
> > > +		esdhc_set_strobe_dll(host);
> > > +		break;
> > >  	}
> > >
> > >  	esdhc_change_pinstate(host, timing); @@ -1100,6 +1178,9 @@ static
> > > int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> > >  	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
> > >  		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > >
> > > +	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> > > +		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
> > > +
> > >  	if (of_id)
> > >  		err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> > >  	else
> > > --
> > > 1.9.1
> > >

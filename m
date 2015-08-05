From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH v3 1/6] mmc: sdhci-esdhc-imx: add imx7d support and
 support HS400
Date: Wed, 5 Aug 2015 07:39:29 +0000
Message-ID: <BY1PR03MB13888A2D2946E6B41EBFFFE19A750@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-2-git-send-email-haibo.chen@freescale.com>
 <20150731141507.GB27806@shlinux1.ap.freescale.net>
 <BY1PR03MB13889195F33D0010E6759D309A880@BY1PR03MB1388.namprd03.prod.outlook.com>
 <20150803120932.GB24870@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150803120932.GB24870@shlinux1.ap.freescale.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Dong A.S." <Aisheng.Dong@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Fabio Estevam <Fabio.Estevam@freescale.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "johan.derycke@barco.com" <johan.derycke@barco.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong@freescale.com]
> Sent: Monday, August 03, 2015 8:10 PM
> To: Chen Haibo-B51421
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; shawnguo@kernel.org;
> kernel@pengutronix.de; linux@arm.linux.org.uk; ulf.hansson@linaro.org;
> johan.derycke@barco.com; Estevam Fabio-R49496; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-mmc@vger.kernel.org
> Subject: Re: [PATCH v3 1/6] mmc: sdhci-esdhc-imx: add imx7d support and
> support HS400
> 
> On Sun, Aug 02, 2015 at 04:59:04PM +0800, Chen Haibo-B51421 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Dong Aisheng [mailto:aisheng.dong@freescale.com]
> > > Sent: Friday, July 31, 2015 10:15 PM
> > > To: Chen Haibo-B51421
> > > Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> > > ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
> > > ijc+shawnguo@kernel.org;
> > > kernel@pengutronix.de; linux@arm.linux.org.uk;
> > > ulf.hansson@linaro.org; johan.derycke@barco.com; Estevam
> > > Fabio-R49496; Dong Aisheng-B29396; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > > linux-mmc@vger.kernel.org
> > > Subject: Re: [PATCH v3 1/6] mmc: sdhci-esdhc-imx: add imx7d support
> > > and support HS400
> > >
> > > On Wed, Jul 29, 2015 at 05:03:52PM +0800, Haibo Chen wrote:
> > > > The imx7d usdhc is derived from imx6sx, the difference is that
> > > > imx7d support HS400.
> > > >
> > > > So introduce a new compatible string for imx7d and add HS400
> > > > support for imx7d usdhc.
> > > >
> > > > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > > > ---
> > > >  drivers/mmc/host/sdhci-esdhc-imx.c | 66
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 66 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > index c6b9f64..b441eed 100644
> > > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > @@ -44,6 +44,7 @@
> > > >  #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
> > > >  #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
> > > >  #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
> > > > +#define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
> > > >  /* Bits 3 and 6 are not SDHCI standard definitions */
> > > >  #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
> > > >  /* Tuning bits */
> > > > @@ -60,6 +61,16 @@
> > > >  #define  ESDHC_TUNE_CTRL_MIN		0
> > > >  #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
> > > >
> > > > +/* strobe dll register */
> > > > +#define ESDHC_STROBE_DLL_CTRL		0x70
> > > > +#define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
> > > > +#define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
> > > > +#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
> > > > +
> > > > +#define ESDHC_STROBE_DLL_STATUS		0x74
> > > > +#define ESDHC_STROBE_DLL_STS_REF_LOCK	(1 << 1)
> > > > +#define ESDHC_STROBE_DLL_STS_SLV_LOCK	0x1
> > > > +
> > > >  #define ESDHC_TUNING_CTRL		0xcc
> > > >  #define ESDHC_STD_TUNING_EN		(1 << 24)
> > > >  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */ @@
> > > > -120,6 +131,8 @@
> > > >  #define ESDHC_FLAG_ERR004536		BIT(7)
> > > >  /* The IP supports HS200 mode */
> > > >  #define ESDHC_FLAG_HS200		BIT(8)
> > > > +/* The IP supports HS400 mode */
> > > > +#define ESDHC_FLAG_SUP_HS400		BIT(9)
> > > >
> > > >  struct esdhc_soc_data {
> > > >  	u32 flags;
> > > > @@ -156,6 +169,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data
> = {
> > > >  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,  };
> > > >
> > > > +static struct esdhc_soc_data usdhc_imx7d_data = {
> > > > +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> > > > +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> > > > +			| ESDHC_FLAG_SUP_HS400,
> > > > +};
> > > > +
> > > >  struct pltfm_imx_data {
> > > >  	u32 scratchpad;
> > > >  	struct pinctrl *pinctrl;
> > > > @@ -199,6 +218,7 @@ static const struct of_device_id
> > > > imx_esdhc_dt_ids[]
> > > = {
> > > >  	{ .compatible = "fsl,imx6sx-usdhc", .data =
> &usdhc_imx6sx_data, },
> > > >  	{ .compatible = "fsl,imx6sl-usdhc", .data =
> &usdhc_imx6sl_data, },
> > > >  	{ .compatible = "fsl,imx6q-usdhc", .data =
> &usdhc_imx6q_data, },
> > > > +	{ .compatible = "fsl,imx7d-usdhc", .data =
> &usdhc_imx7d_data, },
> > > >  	{ /* sentinel */ }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids); @@ -274,6 +294,10 @@
> > > > static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
> > > >  				val = SDHCI_SUPPORT_DDR50 |
> SDHCI_SUPPORT_SDR104
> > > >  					| SDHCI_SUPPORT_SDR50
> > > >  					| SDHCI_USE_SDR50_TUNING;
> > > > +
> > > > +			/* imx7d does not have a support_hs400 register,
> fake
> > > one */
> > >
> > > You could remove this line.
> > > It's bit, not register and i think no need such comment.
> > >
> > > > +			if (imx_data->socdata->flags &
> ESDHC_FLAG_SUP_HS400)
> > > > +				val |= SDHCI_SUPPORT_HS400;
> > > >  		}
> > > >  	}
> > > >
> > > > @@ -774,6 +798,7 @@ static int esdhc_change_pinstate(struct
> > > > sdhci_host
> > > *host,
> > > >  		break;
> > > >  	case MMC_TIMING_UHS_SDR104:
> > > >  	case MMC_TIMING_MMC_HS200:
> > > > +	case MMC_TIMING_MMC_HS400:
> > > >  		pinctrl = imx_data->pins_200mhz;
> > > >  		break;
> > > >  	default:
> > > > @@ -784,6 +809,30 @@ static int esdhc_change_pinstate(struct
> > > > sdhci_host
> > > *host,
> > > >  	return pinctrl_select_state(imx_data->pinctrl, pinctrl);  }
> > > >
> > > > +static void esdhc_set_strobe_dll(struct sdhci_host *host)
> > >
> > > It would be good if we can add some comments for this function for
> > > better understand.
> > >
> >
> > [haibo] okay, I will add comments here.
> >
> > > > +{
> > > > +	u32 v;
> > > > +
> > > > +	/* force a reset on strobe dll */
> > > > +	writel(ESDHC_STROBE_DLL_CTRL_RESET, host->ioaddr +
> > > ESDHC_STROBE_DLL_CTRL);
> > > > +	/*
> > > > +	 * enable strobe dll ctrl and adjust the delay target
> > > > +	 * for the uSDHC loopback read clock
> > > > +	 */
> > > > +	v = ESDHC_STROBE_DLL_CTRL_ENABLE |
> > > > +		(7 << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
> > > > +	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
> > > > +	/* wait 1us to make sure strobe dll status register stable */
> > > > +	udelay(1);
> > > > +	v = readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
> > > > +	if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
> > > > +		dev_warn(mmc_dev(host->mmc),
> > > > +			"warning! HS400 strobe DLL status REF not
> lock!\n");
> > > > +	if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
> > > > +		dev_warn(mmc_dev(host->mmc),
> > > > +			"warning! HS400 strobe DLL status SLV not
> lock!\n"); }
> > > > +
> > > >  static void esdhc_set_uhs_signaling(struct sdhci_host *host,
> > > > unsigned
> > > > timing)  {
> > > >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@
> > > > -795,7
> > > > +844,13 @@ static void esdhc_set_uhs_signaling(struct sdhci_host
> > > > +*host,
> > > unsigned timing)
> > > >  	case MMC_TIMING_UHS_SDR25:
> > > >  	case MMC_TIMING_UHS_SDR50:
> > > >  	case MMC_TIMING_UHS_SDR104:
> > > > +		break;
> > > >  	case MMC_TIMING_MMC_HS200:
> > > > +		/* disable ddr mode and disable HS400 mode */
> > > > +		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) &
> > > > +			~(ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN),
> > > > +			host->ioaddr + ESDHC_MIX_CTRL);
> > > > +		imx_data->is_ddr = 0;
> > > >  		break;
> > > >  	case MMC_TIMING_UHS_DDR50:
> > > >  	case MMC_TIMING_MMC_DDR52:
> > > > @@ -813,6 +868,14 @@ static void esdhc_set_uhs_signaling(struct
> > > sdhci_host *host, unsigned timing)
> > > >  			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
> > > >  		}
> > > >  		break;
> > > > +	case MMC_TIMING_MMC_HS400:
> > > > +		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) |
> > > > +				ESDHC_MIX_CTRL_DDREN |
> ESDHC_MIX_CTRL_HS400_EN,
> > > > +				host->ioaddr + ESDHC_MIX_CTRL);
> > > > +		imx_data->is_ddr = 1;
> > > > +		if (host->clock == 200000000)
> > >
> > > I can't remember, but could this be a range required by SoC?
> >
> > [haibo]we should set strobe_dll only when the host clock is 200MHz. For
> other condition, no need to do this.
> >
> 
> It is not quite make sense for only 200Mhz clock here.
> 
> First, shall we check host->mmc->actual_clock instead of host->clock?
> That is the real clock frequency the controller is working on.
> 
> 
> Second, even MMC core requests to set 200Mhz clock for HS400, the real
> clock controller working on may be less than 200Mhz which depends on the
> uSDHC root clock capability.
> e.g. it may be 192Mhz if the parent is 384Mhz or less.
> If that, do we need call strobe_dll too?
> 

[haibo] according to IC team feedback, when we use HS400 mode in high frequency, like:
close to 200Mhz, including 192Mhz, we should call strobe_dll. When the eMMC clock is around
100Mhz, like 98Mhz, no need to call strobe_dll, I have test this, eMMC can read normally.

When the card clock become higher, each clock cycle becomes shorter. When each clock cycle is short
enough, the time delay between CLK and strobe_data_clock maybe larger than one clock cycle, so the CLk
and strobe_data_clock misaligned,  then read error shows up. (here CLK means the clock host supply to card,
and strobe_data_clock means the clock generated by device which feedback to host for data read in HS400 mode).

So can we call strobe_dll when the card clock is over 100Mhz? 


> Can you check above two concerns?
> 
> Regards
> Dong Aisheng
> 
> > >
> > > > +			esdhc_set_strobe_dll(host);
> > > > +		break;
> > > >  	}
> > > >
> > > >  	esdhc_change_pinstate(host, timing); @@ -1100,6 +1163,9 @@
> > > > static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> > > >  	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
> > > >  		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > > >
> > > > +	if (imx_data->socdata->flags & ESDHC_FLAG_SUP_HS400)
> > > > +		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
> > > > +
> > > >  	if (of_id)
> > > >  		err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> > > >  	else
> > > > --
> > > > 1.9.1
> > > >
> > >
> > > Regards
> > > Dong Aisheng

From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH v4 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
 support
Date: Fri, 7 Aug 2015 10:04:56 +0000
Message-ID: <BY1PR03MB138864BA52567E75F56808329A730@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
 <1438771122-8601-3-git-send-email-haibo.chen@freescale.com>
 <20150807074019.GB6935@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150807074019.GB6935@shlinux1.ap.freescale.net>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Fabio Estevam <Fabio.Estevam@freescale.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong A.S." <Aisheng.Dong@freescale.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "johan.derycke@barco.com" <johan.derycke@barco.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong@freescale.com]
> Sent: Friday, August 07, 2015 3:40 PM
> To: Chen Haibo-B51421
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; shawnguo@kernel.org;
> kernel@pengutronix.de; linux@arm.linux.org.uk; ulf.hansson@linaro.org;
> johan.derycke@barco.com; mkl@pengutronix.de; Estevam Fabio-R49496; Dong
> Aisheng-B29396; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH v4 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
> support
> 
> On Wed, Aug 05, 2015 at 06:38:38PM +0800, Haibo Chen wrote:
> > tuning-step is the delay cell steps in tuning procedure. The default
> > value of tuning-step is 1. Some boards or cards need another value to
> > pass the tuning procedure. For example, imx7d-sdb board need the
> > tuning-step value as 2, otherwise it can't pass the tuning procedure.
> >
> > So this patch add the tuning-step setting in driver, so that user can
> > set the tuning-step value in dts.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c          | 9 +++++++++
> >  include/linux/platform_data/mmc-esdhc-imx.h | 1 +
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 48f009c..803d24f 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -75,6 +75,7 @@
> >  #define ESDHC_STD_TUNING_EN		(1 << 24)
> >  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
> >  #define ESDHC_TUNING_START_TAP		0x1
> > +#define ESDHC_TUNING_STEP_SHIFT		16
> >
> >  /* pinctrl state */
> >  #define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
> > @@ -474,6 +475,7 @@ static void esdhc_writew_le(struct sdhci_host *host,
> u16 val, int reg)
> >  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
> {
> >  			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
> >  			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> > +			u32 tuning_ctrl;
> >  			if (val & SDHCI_CTRL_TUNED_CLK) {
> >  				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> >  			} else {
> > @@ -484,6 +486,11 @@ static void esdhc_writew_le(struct sdhci_host
> *host, u16 val, int reg)
> >  			if (val & SDHCI_CTRL_EXEC_TUNING) {
> >  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
> >  				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> > +				tuning_ctrl = readl(host->ioaddr +
> ESDHC_TUNING_CTRL);
> > +				tuning_ctrl |= ESDHC_STD_TUNING_EN |
> ESDHC_TUNING_START_TAP;
> > +				if (imx_data->boarddata.tuning_step)
> > +					tuning_ctrl |= imx_data-
> >boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
> > +					writel(tuning_ctrl, host->ioaddr +
> ESDHC_TUNING_CTRL);
> 
> Is there a code indent issue here?
> Otherwise, the patch looks good to me.
> 
> Regards
> Dong Aisheng

[haibo] I check this, the code indent is okay.

> 
> >  			} else {
> >  				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> >  			}
> > @@ -964,6 +971,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device
> *pdev,
> >  	if (gpio_is_valid(boarddata->wp_gpio))
> >  		boarddata->wp_type = ESDHC_WP_GPIO;
> >
> > +	of_property_read_u32(np, "fsl,tuning-step",
> > +&boarddata->tuning_step);
> > +
> >  	if (of_find_property(np, "no-1-8-v", NULL))
> >  		boarddata->support_vsel = false;
> >  	else
> > diff --git a/include/linux/platform_data/mmc-esdhc-imx.h
> > b/include/linux/platform_data/mmc-esdhc-imx.h
> > index e1571ef..95ccab3 100644
> > --- a/include/linux/platform_data/mmc-esdhc-imx.h
> > +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> > @@ -45,5 +45,6 @@ struct esdhc_platform_data {
> >  	int max_bus_width;
> >  	bool support_vsel;
> >  	unsigned int delay_line;
> > +	unsigned int tuning_step;       /* The delay cell steps in tuning
> procedure */
> >  };
> >  #endif /* __ASM_ARCH_IMX_ESDHC_H */
> > --
> > 1.9.1
> >

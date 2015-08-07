From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH v4 6/6] mmc: sdhci-esdhc-imx: set back the
 burst_length_enable bit to 1
Date: Fri, 7 Aug 2015 10:11:37 +0000
Message-ID: <BY1PR03MB13883261FD2D9D28B30697209A730@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
 <1438771122-8601-7-git-send-email-haibo.chen@freescale.com>
 <20150807075050.GC6935@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150807075050.GC6935@shlinux1.ap.freescale.net>
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
> Sent: Friday, August 07, 2015 3:51 PM
> To: Chen Haibo-B51421
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; shawnguo@kernel.org;
> kernel@pengutronix.de; linux@arm.linux.org.uk; ulf.hansson@linaro.org;
> johan.derycke@barco.com; mkl@pengutronix.de; Estevam Fabio-R49496; Dong
> Aisheng-B29396; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH v4 6/6] mmc: sdhci-esdhc-imx: set back the
> burst_length_enable bit to 1
> 
> On Wed, Aug 05, 2015 at 06:38:42PM +0800, Haibo Chen wrote:
> > Currently we find that if a usdhc is choosed to boot system, then ROM
> > code will set the burst length enable bit of this usdhc as 0.
> >
> > This will make performance drop a lot if this usdhc's burst length is
> > configed. So this patch set back the burst_length_enable bit as 1,
> > which is the default value, and means burst length is enabled for INCR.
> >
> 
> This patch should be put before patch 5 to avoid function break, right?
> [PATCH v4 5/6] mmc: sdhci-esdhc-imx: change default watermark level and
> burst length
> 
> Other than that, this patch looks good to me.
> 
> Regards
> Dong Aisheng
> 

[haibo] Yes, you are right. Patch 6 should be put before patch 5.
 
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 97aa944..3334762 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -32,6 +32,7 @@
> >  #include "sdhci-esdhc.h"
> >
> >  #define	ESDHC_CTRL_D3CD			0x08
> > +#define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
> >  /* VENDOR SPEC register */
> >  #define ESDHC_VENDOR_SPEC		0xc0
> >  #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
> > @@ -1165,6 +1166,21 @@ static int sdhci_esdhc_imx_probe(struct
> platform_device *pdev)
> >  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> >  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> >
> > +		/*
> > +		 * ROM code will change the bit burst_length_enable setting
> > +		 * to zero if this usdhc is choosed to boot system. Change
> > +		 * it back here, otherwise it will impact the performance a
> > +		 * lot. This bit is used to enable/disable the burst length
> > +		 * for the external AHB2AXI bridge, it's usefully especially
> > +		 * for INCR transfer because without burst length indicator,
> > +		 * the AHB2AXI bridge does not know the burst length in
> > +		 * advance. And without burst length indicator, AHB INCR
> > +		 * transfer can only be converted to singles on the AXI side.
> > +		 */
> > +		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
> > +			| ESDHC_BURST_LEN_EN_INCR,
> > +			host->ioaddr + SDHCI_HOST_CONTROL);
> > +
> >  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
> >  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> >
> > --
> > 1.9.1
> >

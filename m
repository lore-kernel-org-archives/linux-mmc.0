From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH v3 6/6] mmc: sdhci-esdhc-imx: set back the
 burst_length_enable bit to 1
Date: Mon, 3 Aug 2015 01:08:28 +0000
Message-ID: <BY1PR03MB138838EFB0DE8834DE5889669A770@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-7-git-send-email-haibo.chen@freescale.com>
 <20150731145751.GG27806@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150731145751.GG27806@shlinux1.ap.freescale.net>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Fabio Estevam <Fabio.Estevam@freescale.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong
 A.S." <Aisheng.Dong@freescale.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "johan.derycke@barco.com" <johan.derycke@barco.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong@freescale.com]
> Sent: Friday, July 31, 2015 10:58 PM
> To: Chen Haibo-B51421
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; shawnguo@kernel.org;
> kernel@pengutronix.de; linux@arm.linux.org.uk; ulf.hansson@linaro.org;
> johan.derycke@barco.com; Estevam Fabio-R49496; Dong Aisheng-B29396;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH v3 6/6] mmc: sdhci-esdhc-imx: set back the
> burst_length_enable bit to 1
> 
> On Wed, Jul 29, 2015 at 05:03:57PM +0800, Haibo Chen wrote:
> > Currently we find that if a usdhc is choosed to boot system, then ROM
> > code will set the burst length enable bit of this usdhc as 0.
> >
> > This will make performance drop a lot if this usdhc's burst length is
> > 16. So this patch set back the burst_length_enable bit as 1, which is
> > the default value, and means burst length is enabled for INCR.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 37d0095..dd945e5 100644
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
> > @@ -1158,6 +1159,16 @@ static int sdhci_esdhc_imx_probe(struct
> platform_device *pdev)
> >  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> >  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> >
> > +		/*
> > +		 * ROM code will change the burst_length_enable setting to
> > +		 * zero if this usdhc is choosed to boot system. Change it
> > +		 * back here, otherwise it will impact the performance a
> > +		 * lot if the burst length is 16.
> 
> Can you clarify a bit more on why performance drops a lot if burst length
> is 16?
> Caused by the burst length setting did not work due to ROM disabled it?


[haibo] this bit is used to enable/disable the burst length for the external AHB2AXI bridge, 
It's useful especially for INCR transfer because without burst length indicator, the AHB2AXI 
bridge doesn't know the burst length in advance. And without burst length indicator, AHB INCR 
transfers can only be converted to singles on the AXI side.

Seting this bit means burst length enabled for INCR.
If this bit is not set, performance will drop a lot when burst length is 8 or 16. I will add 
this in the commit log.
 
> 
> Regards
> Dong Aisheng
> 
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

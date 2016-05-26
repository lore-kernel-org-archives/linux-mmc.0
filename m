From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 20/23] mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong
 clock issue
Date: Thu, 26 May 2016 19:47:48 +0800
Message-ID: <20160526114748.GC23988@shlinux2>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-21-git-send-email-aisheng.dong@nxp.com>
 <5731CE24.2090002@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35657 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbcEZLw5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 07:52:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id f144so2095624pfa.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2016 04:52:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5731CE24.2090002@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com

On Tue, May 10, 2016 at 03:03:48PM +0300, Adrian Hunter wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
> > When enable DDR, the clock factor definition is changed.
> > e.g. original 200Mhz will become 100Mhz one MIX_CTRL_DDREN bit is set
> > So we need to update the clock setting then the strobe dll can lock
> > the correct clock rate.
> > 
> > Additionally we also need disable the clock before locking strobe dll.
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Apart from redundant parentheses (refer below):
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 

Could remove in V2.
Thanks for the suggestion.

Regards
Dong Aisheng

> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 07b1144..3ff213f 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -852,6 +852,11 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
> >  	u32 v;
> >  
> >  	if (host->mmc->actual_clock > ESDHC_STROBE_DLL_CLK_FREQ) {
> > +		/* disable clock before enabling strobe dll */
> > +		writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
> > +		       (~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON),
> 
> Parentheses look redundant
> 
> > +		       host->ioaddr + ESDHC_VENDOR_SPEC);
> > +
> >  		/* force a reset on strobe dll */
> >  		writel(ESDHC_STROBE_DLL_CTRL_RESET,
> >  			host->ioaddr + ESDHC_STROBE_DLL_CTRL);
> > @@ -913,6 +918,8 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
> >  		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
> >  		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
> >  		imx_data->is_ddr = 1;
> > +		/* update clock after enable DDR for strobe DLL lock */
> > +		host->ops->set_clock(host, host->clock);
> >  		esdhc_set_strobe_dll(host);
> >  		break;
> >  	}
> > 
> 

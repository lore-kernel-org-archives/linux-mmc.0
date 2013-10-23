From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 5/7] mmc: sdhci-esdhc-imx: fix cpas over write issue
Date: Wed, 23 Oct 2013 13:56:47 +0800
Message-ID: <20131023055646.GB14667@shlinux2.ap.freescale.net>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
 <1382365627-26816-6-git-send-email-b29396@freescale.com>
 <20131023025146.GC2839@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:11437
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974Ab3JWGOK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 02:14:10 -0400
Content-Disposition: inline
In-Reply-To: <20131023025146.GC2839@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, wsa@the-dreams.de, ulf.hansson@linaro.org

On Wed, Oct 23, 2013 at 10:51:48AM +0800, Shawn Guo wrote:
> On Mon, Oct 21, 2013 at 10:27:05PM +0800, Dong Aisheng wrote:
> > We should use '|=' instead '=', or it may over write
> > the original caps assigned before this line.
> > 
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 5fe484f..baa27c7 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1070,7 +1070,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> >  		break;
> >  
> >  	case ESDHC_CD_PERMANENT:
> > -		host->mmc->caps = MMC_CAP_NONREMOVABLE;
> > +		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> 
> I think it will be more logical if you switch the order of this patch
> and the previous one.
> 

Sounds good to me.
Will switch it.

Regards
Dong Aisheng

> Shawn
> 
> >  		break;
> >  
> >  	case ESDHC_CD_NONE:
> > -- 
> > 1.7.2.rc3
> > 
> > 


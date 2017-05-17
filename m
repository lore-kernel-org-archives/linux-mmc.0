From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
Date: Wed, 17 May 2017 17:17:26 +0800
Message-ID: <20170517171726.2ede556d@xhacker>
References: <20170516061720.1755-1-jszhang@marvell.com>
        <20170516122211.GA27959@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54149 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753408AbdEQJWd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 May 2017 05:22:33 -0400
In-Reply-To: <20170516122211.GA27959@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: adrian.hunter@intel.com, huziji@marvell.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On Tue, 16 May 2017 14:22:11 +0200 Andrew Lunn wrote:

> On Tue, May 16, 2017 at 02:17:20PM +0800, Jisheng Zhang wrote:
> > Currently, the xenon_clean_phy() is only used for freeing phy_params.
> > The phy_params is allocated by devm_kzalloc(), there's no need to free
> > is explicitly.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/mmc/host/sdhci-xenon-phy.c | 14 +-------------
> >  drivers/mmc/host/sdhci-xenon.c     |  6 +-----
> >  drivers/mmc/host/sdhci-xenon.h     |  1 -
> >  3 files changed, 2 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> > index 6356781f1cca..f7e26b031e76 100644
> > --- a/drivers/mmc/host/sdhci-xenon-phy.c
> > +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> > @@ -787,14 +787,6 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
> >  	return ret;
> >  }
> >  
> > -void xenon_clean_phy(struct sdhci_host *host)
> > -{
> > -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > -
> > -	kfree(priv->phy_params);  
> 
> Hi Jisheng

Hi Andrew,

> 
> If the memory has been allocated using the devm_ API, calling kfree
> here is wrong, and can lead to a double free.

Yes. In fact, I found this issue by unbinding then binding the xenon host.


> 
> So this patch should probably have a fixes: tag. Should it also goto
> stable?

As pointed out by RMK, the sdhci-xenon driver is merged in current 4.12-rc1,
so we just need to apply this fix in later rcN.

Thanks,
Jisheng


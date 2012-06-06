From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Move of_match_table out of CONFIG_PM
Date: Wed, 6 Jun 2012 17:37:54 +0200
Message-ID: <201206061737.55260.marex@denx.de>
References: <1337574807-8637-1-git-send-email-marex@denx.de> <87wr3k34pq.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:47513 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab2FFPiD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jun 2012 11:38:03 -0400
In-Reply-To: <87wr3k34pq.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org

Dear Chris Ball,

> Hi,
> 
> On Mon, May 21 2012, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: Chris Ball <cjb@laptop.org>
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> >  drivers/mmc/host/mxs-mmc.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > index 34a9026..277161d 100644
> > --- a/drivers/mmc/host/mxs-mmc.c
> > +++ b/drivers/mmc/host/mxs-mmc.c
> > @@ -894,8 +894,8 @@ static struct platform_driver mxs_mmc_driver = {
> > 
> >  		.owner	= THIS_MODULE,
> >  
> >  #ifdef CONFIG_PM
> >  
> >  		.pm	= &mxs_mmc_pm_ops,
> > 
> > -		.of_match_table = mxs_mmc_dt_ids,
> > 
> >  #endif
> > 
> > +		.of_match_table = mxs_mmc_dt_ids,
> > 
> >  	},
> >  
> >  };
> 
> Thanks, pushed to mmc-next for 3.5.

Thanks!

> - Chris.

Best regards,
Marek Vasut

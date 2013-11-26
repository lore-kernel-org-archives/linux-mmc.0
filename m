From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 08/12] mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
Date: Tue, 26 Nov 2013 03:02:48 +0100
Message-ID: <2163819.oJv92Ekf2I@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <Pine.LNX.4.64.1310290907520.8404@axis700.grange> <3901213.QOEV1AdNoe@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42181 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab3KZCCq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Nov 2013 21:02:46 -0500
In-Reply-To: <3901213.QOEV1AdNoe@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Chris,

On Saturday 09 November 2013 13:56:40 Laurent Pinchart wrote:
> Hi Chris,
> 
> Could you please pick this patch up ?

Ping ?

As this patch is a dependency for other series that will go through different 
trees, could you please provide a stable branch in your tree with this patch 
included that you will push to v3.14 ?

> On Tuesday 29 October 2013 09:09:37 Guennadi Liakhovetski wrote:
> > On Mon, 28 Oct 2013, Laurent Pinchart wrote:
> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > > clk_disable_unprepare() to get ready for the migration to the common
> > > clock framework.
> > > 
> > > Cc: Chris Ball <cjb@laptop.org>
> > > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > Cc: linux-mmc@vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > Thanks
> > Guennadi
> > 
> > > ---
> > > 
> > >  drivers/mmc/host/sh_mobile_sdhi.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c
> > > b/drivers/mmc/host/sh_mobile_sdhi.c index f344659..ed1718a 100644
> > > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > > @@ -54,7 +54,7 @@ static int sh_mobile_sdhi_clk_enable(struct
> > > platform_device *pdev, unsigned int>
> > >  	struct mmc_host *mmc = platform_get_drvdata(pdev);
> > >  	struct tmio_mmc_host *host = mmc_priv(mmc);
> > >  	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct
> > >  	sh_mobile_sdhi, mmc_data);
> > > -	int ret = clk_enable(priv->clk);
> > > +	int ret = clk_prepare_enable(priv->clk);
> > >  	if (ret < 0)
> > >  		return ret;
> > > 
> > > @@ -67,7 +67,7 @@ static void sh_mobile_sdhi_clk_disable(struct
> > > platform_device *pdev)>
> > >  	struct mmc_host *mmc = platform_get_drvdata(pdev);
> > >  	struct tmio_mmc_host *host = mmc_priv(mmc);
> > >  	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct
> > >  	sh_mobile_sdhi, mmc_data);
> > > -	clk_disable(priv->clk);
> > > +	clk_disable_unprepare(priv->clk);
> > >  }
> > >  
> > >  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
-- 
Regards,

Laurent Pinchart


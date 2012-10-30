From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: sh_mmcif: fix use after free
Date: Tue, 30 Oct 2012 23:08:57 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1210302306190.29432@axis700.grange>
References: <Pine.LNX.4.64.1210231406080.13115@axis700.grange>
 <878vapq8fj.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932978Ab2J3WJB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 18:09:01 -0400
In-Reply-To: <878vapq8fj.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Chris

On Mon, 29 Oct 2012, Chris Ball wrote:

> Hi Guennadi,
> 
> On Tue, Oct 23 2012, Guennadi Liakhovetski wrote:
> > A recent commit "mmc: sh_mmcif: fix clock management" has introduced a use
> > after free bug in sh_mmcif.c: in sh_mmcif_remove() the call to
> > mmc_free_host() frees private driver data, therefore using it afterwards
> > is a bug. Revert that hunk.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >
> > Chris, the offending patch appeared in 3.6, so, this has to go to 
> > 3.6.stable, as well as to 3.7-rc.
> >
> >  drivers/mmc/host/sh_mmcif.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index 11d2bc3..d25bc97 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -1466,9 +1466,9 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, NULL);
> >  
> > +	clk_disable(host->hclk);
> >  	mmc_free_host(host->mmc);
> >  	pm_runtime_put_sync(&pdev->dev);
> > -	clk_disable(host->hclk);
> >  	pm_runtime_disable(&pdev->dev);
> >  
> >  	return 0;
> 
> Thanks, pushed to mmc-next for 3.7.

Thanks!

> In future, feel free to note the
> stable@ situation by adding:
> 
>    Cc: stable@vger.kernel.org [3.6]

Hm, a bit confused. I seem to remember, that one of subsystem maintainers, 
to whom I also submitted a patch, that should also have been forwarded to 
stable, told me, that adding this "Cc: stable@..." tag was a task of 
subsystem maintainers, in that case his task, and not of individual 
submitters, which might only indicate their opinion in this respect. Am I 
wrong?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

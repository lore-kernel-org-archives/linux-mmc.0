From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: fix a deadlock between system suspend and MMC block
 IO
Date: Wed, 4 Jan 2012 15:45:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201041544140.30506@axis700.grange>
References: <Pine.LNX.4.64.1201041527480.30506@axis700.grange>
 <m2lipnfs9x.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53178 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab2ADOpI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 09:45:08 -0500
In-Reply-To: <m2lipnfs9x.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris

On Wed, 4 Jan 2012, Chris Ball wrote:

> Hi,
> 
> On Wed, Jan 04 2012, Guennadi Liakhovetski wrote:
> > Performing MMC block IO with simultaneous STR can lead to a deadlock: the
> > mmc_pm_notify() function claims the host and then calls bus .remove()
> > method, which lands in mmc_blk_remove(), which calls mmc_blk_remove_req()
> > then it goes to -> mmc_cleanup_queue() -> kthread_stop(), which waits for
> > the mmc-block thread to stop. If the mmc-block thread at that time is
> > processing block requests, it will also try to claim the host in
> > mmc_blk_issue_rq() and block there. This patch fixes the problem by
> > calling .remove() before claiming the host.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  drivers/mmc/core/core.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index a2aa860..a68f085 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2476,11 +2476,11 @@ int mmc_pm_notify(struct notifier_block *notify_block,
> >  		if (!host->bus_ops || host->bus_ops->suspend)
> >  			break;
> >  
> > -		mmc_claim_host(host);
> > -
> > +		/* On 2 occasions above bus_ops->remove() is called unlocked */
> >  		if (host->bus_ops->remove)
> >  			host->bus_ops->remove(host);
> >  
> > +		mmc_claim_host(host);
> >  		mmc_detach_bus(host);
> >  		mmc_power_off(host);
> >  		mmc_release_host(host);
> 
> Thanks.  The commit message explanation is very good, but the comment is
> a bit cryptic.  Shall we make it longer?  I think even just:
> 
> /* Calling bus_ops->remove() with a claimed host can deadlock */
> 
> would be better.

Right, agree. Would you replace it yourself or should I send a v2?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

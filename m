From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] MMC: fix all hangs related to mmc/sd card
 insert/removal during suspend/resume.
Date: Tue, 22 Jun 2010 03:03:49 +0300
Message-ID: <1277165029.7793.10.camel@maxim-laptop>
References: <1276809695.28201.13.camel@maxim-laptop>
	 <4C1FC5BC.20008@nokia.com> <1277151261.5409.30.camel@maxim-laptop>
	 <201006212226.15859.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:54699 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339Ab0FVADz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2010 20:03:55 -0400
In-Reply-To: <201006212226.15859.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Philip Langdale <philipl@overt.org>

On Mon, 2010-06-21 at 22:26 +0200, Rafael J. Wysocki wrote: 
> On Monday, June 21, 2010, Maxim Levitsky wrote:
> > On Mon, 2010-06-21 at 23:04 +0300, Adrian Hunter wrote: 
> > > ext Maxim Levitsky wrote:
> > > > If you don't use CONFIG_MMC_UNSAFE_RESUME, as soon as you attempt to
> > > > suspend, the card will be removed, therefore this patch doesn't change
> > > > the behavior of this option.
> > > > 
> > > > However the removal will be done by pm notifier, which runs while
> > > > userspace is still not frozen and thus can freely use del_gendisk,
> > > > without the risk of deadlock which would happen otherwise.
> > > > 
> > > > 
> > > > Card detect workqueue is now freezeable,
> > > > therefore if you do use CONFIG_MMC_UNSAFE_RESUME,
> > > > and remove the card during suspend, the removal will be
> > > > detected as soon as userspace is unfrozen, again at the moment
> > > > it is safe to call del_gendisk.
> > > > 
> > > > Tested with and without CONFIG_MMC_UNSAFE_RESUME with suspend and hibernate.
> > > > 
> > > > Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> > > > ---
> > > >  drivers/mmc/core/core.c  |   54 +++++++++++++++++++++++++++------------------
> > > >  drivers/mmc/core/host.c  |    6 +++++
> > > >  include/linux/mmc/host.h |    3 ++
> > > >  3 files changed, 41 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index 569e94d..0cba53a 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -1259,26 +1259,11 @@ int mmc_suspend_host(struct mmc_host *host)
> > > >  
> > > >  	if (host->caps & MMC_CAP_DISABLE)
> > > >  		cancel_delayed_work(&host->disable);
> > > > -	cancel_delayed_work(&host->detect);
> > > > -	mmc_flush_scheduled_work();
> > > >  
> > > >  	mmc_bus_get(host);
> > > >  	if (host->bus_ops && !host->bus_dead) {
> > > >  		if (host->bus_ops->suspend)
> > > >  			err = host->bus_ops->suspend(host);
> > > > -		if (err == -ENOSYS || !host->bus_ops->resume) {
> > > > -			/*
> > > > -			 * We simply "remove" the card in this case.
> > > > -			 * It will be redetected on resume.
> > > > -			 */
> > > > -			if (host->bus_ops->remove)
> > > > -				host->bus_ops->remove(host);
> > > > -			mmc_claim_host(host);
> > > > -			mmc_detach_bus(host);
> > > > -			mmc_release_host(host);
> > > > -			host->pm_flags = 0;
> > > > -			err = 0;
> > > > -		}
> > > >  	}
> > > >  	mmc_bus_put(host);
> > > >  
> > > > @@ -1310,12 +1295,6 @@ int mmc_resume_host(struct mmc_host *host)
> > > >  			printk(KERN_WARNING "%s: error %d during resume "
> > > >  					    "(card was removed?)\n",
> > > >  					    mmc_hostname(host), err);
> > > > -			if (host->bus_ops->remove)
> > > > -				host->bus_ops->remove(host);
> > > > -			mmc_claim_host(host);
> > > > -			mmc_detach_bus(host);
> > > > -			mmc_release_host(host);
> > > > -			/* no need to bother upper layers */
> > > >  			err = 0;
> > > >  		}
> > > >  	}
> > > > @@ -1330,6 +1309,37 @@ int mmc_resume_host(struct mmc_host *host)
> > > >  	return err;
> > > >  }
> > > >  
> > > > +/* Do the card removal on suspend if card is assumed removeable
> > > > + * Do that in pm notifier while userspace isn't yet frozen, so we will be able
> > > > +   to sync the card.
> > > > +*/
> > > > +int mmc_pm_notify(struct notifier_block *notify_block,
> > > > +					unsigned long mode, void *unused)
> > > > +{
> > > > +	struct mmc_host *host = container_of(
> > > > +		notify_block, struct mmc_host, pm_notify);
> > > > +
> > > > +
> > > > +	switch (mode) {
> > > > +	case PM_HIBERNATION_PREPARE:
> > > > +	case PM_SUSPEND_PREPARE:
> > > > +
> > > > +		if (!host->bus_ops || host->bus_ops->suspend)
> > > > +			break;
> > > > +
> > > > +		if (host->bus_ops->remove)
> > > > +			host->bus_ops->remove(host);
> > > > +		mmc_claim_host(host);
> > > > +		mmc_detach_bus(host);
> > > > +		mmc_release_host(host);
> > > > +		host->pm_flags = 0;
> > > > +		break;
> > > 
> > > Is it possible that you receive PM_SUSPEND_PREPARE
> > > but there is no suspend and therefore no resume
> > > and therefore the card is removed but not detected
> > > again?
> > This is very good point.
> > The solution is to kick mmc detection thread from this notifier.
> > on resume.
> > I update the patch.
> > 
> > > 
> > > Is it possible that you are racing with kmmcd and the
> > > card is added after you receive PM_SUSPEND_PREPARE but
> > > before kmmcd is frozen?
> > This is unlikely but valid race.
> > I afraid I don't know nice way to solve it right now.
> > I can add some ad-hoc variable to tell interrupt handler not to kick the
> > detection workqueue after suspend notifier was called.
> > 
> > I wish there was a generic freeze_workqueue function.
> 
> There are freezable workqueues that are automatically frozen during suspend
> by the process freezer.  However, at the moment they need to be singlethread
> and I'm not sure if using one in this particular case is appropriate.

I *do* use freezable  work-queue.
However since this is pm notifier, it is called before userspace and the
workqueue is frozen.
Therefore I would like manually to freeze the workqueue from the pm
notifier.


Best regards,
Maxim Levitsky


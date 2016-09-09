From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Fri, 9 Sep 2016 12:15:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609091212160.2050-100000@iolanthe.rowland.org>
References: <1473429884.9415.8.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473429884.9415.8.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 9 Sep 2016, Ritesh Raj Sarraf wrote:

> On Fri, 2016-09-09 at 18:44 +0530, Ritesh Raj Sarraf wrote:
> > On Fri, 2016-09-09 at 12:54 +0200, Ulf Hansson wrote:
> > > This affects the way the core calls the host driver's ->set_ios()
> > > callback. Earlier it was invoked first to do power off then power up.
> > > With this change it starts with power up instead.
> > > I wanted to try this because I suspected the initial state could be wrong.
> > > 
> > > So here are some other ideas on how to move forward.
> > > 1. Run with CONFIG_PM unset to see if we can reproduce the problem.
> > > 2. Revert back the state in the mmc core we had in 3.16 around how it
> > > deals with runtime PM for host devices. That's actually very easy as
> > > we only need to remove the pm_runtime_put|get() calls in
> > > mmc_claim|release_host().
> > > 
> > > Ritesh, can you try these options?
> > > 
> > 
> > Yes. I can try the above ones now. I'm building the kernel for it.
> 
> For #1, menuconfig doesn't allow me to disable CONFIG_PM in 4.8. I checked it
> back up till 4.0, and it still doesn't allow disabling CONFIG_PM.

You can do it, but it would require some pretty far-reaching changes.  
Besides, there's really no point.  If CONFIG_PM isn't enabled then the 
kernel doesn't do any runtime PM at all.

Alan Stern


> For #2, I'm building the 4.8-rc5 kernel with the following change. This build
> does not include the previous change you had suggested (related to POWER_CYCLE)
> 
> Date:   Fri Sep 9 19:28:03 2016 +0530
> 
>     Disable pm runtime in mmc core
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..32388d5 100644
> - --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -970,9 +970,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>         spin_unlock_irqrestore(&host->lock, flags);
>         remove_wait_queue(&host->wq, &wait);
>  
> - -       if (pm)
> - -               pm_runtime_get_sync(mmc_dev(host));
> - -
>         return stop;
>  }
>  EXPORT_SYMBOL(__mmc_claim_host);
> @@ -1000,7 +997,6 @@ void mmc_release_host(struct mmc_host *host)
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 wake_up(&host->wq);
>                 pm_runtime_mark_last_busy(mmc_dev(host));
> - -               pm_runtime_put_autosuspend(mmc_dev(host));
>         }
>  }
>  EXPORT_SYMBOL(mmc_release_host);

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

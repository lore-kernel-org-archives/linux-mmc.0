From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
 sdhci_tasklet_finish
Date: Fri, 22 Jul 2011 08:58:40 +0800
Message-ID: <20110722005837.GA32049@lovegaga>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
 <6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
 <20110721052358.GA31584@lovegaga>
 <CAMj5BkhT2-mybTHTVxXm1TG0w=Ap34etwKgxg3QVVzohaZWupA@mail.gmail.com>
 <20110721100351.GA31886@lovegaga>
 <086235A9-1100-4ABB-9D4D-B2757382BF0B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:40473
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751328Ab1GVBEe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2011 21:04:34 -0400
Content-Disposition: inline
In-Reply-To: <086235A9-1100-4ABB-9D4D-B2757382BF0B@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "Nath, Arindam" <Arindam.Nath@amd.com>, Subhash Jadavani <subhashj@codeaurora.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Philip,

On Thu, Jul 21, 2011 at 01:27:11PM -0700, Philip Rakity wrote:
> 
> Aaron,
> 
> Code is fine.
Thanks.

> Do you want to also fix the problem with suspend or should I do the patch ?
> When we are suspending we should kill the tuning timer.
Yes, that is a problem.

I've another patch to add support for re-tuning mode 2 queued for
submit which should have fixed this problem, but I didn't touch anything
if mmc_suspend_host failed, so when I submit the other patch, please
take you time to review it and let's see how we can fix the problem
altogether :-)

> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4da6a4d..88c25e8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2289,18 +2289,14 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
>  
>  	sdhci_disable_card_detection(host);
>  
> -	/* Disable tuning since we are suspending */
> -	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
> -	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
> -		host->flags &= ~SDHCI_NEEDS_RETUNING;
> -		mod_timer(&host->tuning_timer, jiffies +
> -			host->tuning_count * HZ);
> -	}
> -
>  	ret = mmc_suspend_host(host->mmc);
>  	if (ret)
>  		return ret;
>  
> +	/* Disable tuning since we are suspending */
> +	if (host->version >= SDHCI_SPEC_300)
> +		del_timer_sync(&host->tuning_timer);
> +
>  	free_irq(host->irq, host);
>  
>  	if (host->vmmc)
> 
> 
> 
> Philip
> 
> On Jul 21, 2011, at 3:03 AM, Aaron Lu wrote:
> 
> > On Thu, Jul 21, 2011 at 05:35:02PM +0800, zhangfei gao wrote:
> >> 
> >> Does the execute_tuning is called again?
> >> del_timer is not delete timer really, but deactivate the timer, which
> >> could be re-activated by mod_timer.
> >> So if execute_tuning is called, the mod_timer will tigger the tuning
> >> timer again.
> >> 
> > 
> > Hi zhangfei,
> > 
> > Thanks for the comment.
> > 
> > The execute_tuning will be called at two places:
> > 1 In mmc_sd_init_uhs_card, when host is initializing an UHS card,
> > and the re-tuning timer will be activated for the first time;
> > 2 When re-tuning timer expired
> > 
> > So if the re-tuning timer is deactivated in sdhci_tasklet_finish,
> > execute_tuning will have no chance of getting called again, and the
> > host will not be able to do the re-tuning anymore.
> > 
> >>>>> 
> >>>>> Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
> >>>>> ---
> >>>>>  drivers/mmc/host/sdhci.c |    3 ---
> >>>>>  1 files changed, 0 insertions(+), 3 deletions(-)
> >>>>> 
> >>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>>>> index 91d9892..6250bac 100644
> >>>>> --- a/drivers/mmc/host/sdhci.c
> >>>>> +++ b/drivers/mmc/host/sdhci.c
> >>>>> @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned long
> >>>>> param)
> >>>>> 
> >>>>>     del_timer(&host->timer);
> >>>>> 
> >>>>> -   if (host->version >= SDHCI_SPEC_300)
> >>>>> -           del_timer(&host->tuning_timer);
> >>>>> -
> >>>>>     mrq = host->mrq;
> >>>>> 
> >>>>>     /*
> >>>>> --
> >>>>> 1.7.1
> >>>> 
> >>>> 
> >>> 
> >>> 
> >> 
> > 
> 
> 


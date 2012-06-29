From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: A new flag SDHCI_NEEDS_RETUNING_TIMER
Date: Fri, 29 Jun 2012 02:11:29 -0400
Message-ID: <87ipea8x66.fsf@octavius.laptop.org>
References: <1340949594-27929-1-git-send-email-aaron.lu@amd.com>
	<1340949594-27929-3-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60732 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab2F2GLe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jun 2012 02:11:34 -0400
In-Reply-To: <1340949594-27929-3-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Fri, 29 Jun 2012 13:59:54 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Fri, Jun 29 2012, Aaron Lu wrote:
> Add a new flag of SDHCI_NEEDS_RETUNING_TIMER to represent if the host
> needs retuning timer currently when driving the card inserted.
>
> This flag is set when the host does tuning the first time for the card
> and is used afterwards whenever needs to decide if the host is currently
> using a retuning timer.
>
> This flag is cleared when the card is removed in sdhci_reinit.
>
> The set/clear of the flag and the start/stop of the retuning timer is
> associated with the card's init/remove time, so there is no need to
> touch it when the host is to be removed as at that time the card should
> have already been removed.

[...]
> @@ -3097,10 +3092,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  
>  	free_irq(host->irq, host);
>  
> -	del_timer_sync(&host->timer);
> -	if (host->version >= SDHCI_SPEC_300)
> -		del_timer_sync(&host->tuning_timer);
> -
>  	tasklet_kill(&host->card_tasklet);
>  	tasklet_kill(&host->finish_tasklet);

The last paragraph of the commit message explains why you remove the
del_timer_sync() call on the tuning_timer; but why do you remove it
from the main (timeouts) host->timer too?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] mmc: sdhci: deactivate tuning timer when host is
 suspending
Date: Wed, 4 Jan 2012 09:14:39 +0800
Message-ID: <20120104011439.GA12195@ladygaga>
References: <1324959750-18203-1-git-send-email-aaron.lu@amd.com>
 <m2hb0dpsa4.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:37808 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab2ADBOr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2012 20:14:47 -0500
Content-Disposition: inline
In-Reply-To: <m2hb0dpsa4.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

On Mon, Jan 02, 2012 at 07:02:27PM -0500, Chris Ball wrote:
> Hi,
> 
> On Mon, Dec 26 2011, Aaron Lu wrote:
> > From: Philip Rakity <prakity@marvell.com>
> >
> > Since we are suspending, the tuning timer should be deactivated.
> >
> > Signed-off-by: Philip Rakity <prakity@marvell.com>
> > Acked-by: Aaron Lu <aaron.lu@amd.com>
> > ---
> >  drivers/mmc/host/sdhci.c |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index ab6018f..1abbd26 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2347,8 +2347,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
> >  	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
> >  	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
> >  		host->flags &= ~SDHCI_NEEDS_RETUNING;
> > -		mod_timer(&host->tuning_timer, jiffies +
> > -			host->tuning_count * HZ);
> > +		del_timer_sync(&host->tuning_timer);
> >  	}
> >  
> >  	ret = mmc_suspend_host(host->mmc);
> 
> Pushed to mmc-next for 3.3 with a stable@ tag, thanks.

I'm sorry Chris, this patch is deprecated and please apply the following
patch with Adrian's ack instead:
[PATCH 1/2] mmc: sdhci: Fix tuning timer incorrect setting when suspending host

Thanks.

> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 


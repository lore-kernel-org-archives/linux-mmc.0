From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
 sdhci_tasklet_finish
Date: Thu, 21 Jul 2011 13:23:59 +0800
Message-ID: <20110721052358.GA31584@lovegaga>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
 <6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:52406
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750804Ab1GUFYY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2011 01:24:24 -0400
Content-Disposition: inline
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>, Philip Rakity <prakity@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, subhashj@codeaurora.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Jul 15, 2011 at 02:51:34PM +0800, Nath, Arindam wrote:
> Hi Philip, Zhangfei
> 
> Do you have any comments on this patch?
>

Hi all,

This patch is sent for a while now and didn't seem to receive any
notice yet...So, can you please take a look and give your comments?

This is a bug fix for exsting code, if the re-tuning timer is deleted,
the re-tuning will not happen again, that will cause problems for SDHC
3.0 hosts which utilize re-tuning mode 1.

Thanks.
 
> 
> > -----Original Message-----
> > From: Aaron Lu [mailto:Aaron.Lu@amd.com]
> > Sent: Monday, July 11, 2011 10:57 AM
> > To: Chris Ball
> > Cc: Nath, Arindam; linux-mmc@vger.kernel.org; Lu, Aaron
> > Subject: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
> > sdhci_tasklet_finish
> > 
> > Currently, the retuning timer for retuning mode 1 will be deleted in
> > function sdhci_tasklet_finish after a mmc request done, which will
> make
> > retuning timing never trigger again. This patch fixed this problem.
> > 
> > Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
> > ---
> >  drivers/mmc/host/sdhci.c |    3 ---
> >  1 files changed, 0 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 91d9892..6250bac 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned long
> > param)
> > 
> >  	del_timer(&host->timer);
> > 
> > -	if (host->version >= SDHCI_SPEC_300)
> > -		del_timer(&host->tuning_timer);
> > -
> >  	mrq = host->mrq;
> > 
> >  	/*
> > --
> > 1.7.1
> 
> 


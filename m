From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Fri, 13 Jan 2012 14:27:32 +0800
Message-ID: <20120113062730.GB2701@ladygaga>
References: <1324972835-12264-1-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F116692C7@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113032641.GB7564@ladygaga>
 <8A2FC72B45BB5A4C9F801431E06AE48F1166949C@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:41734
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151Ab2AMG2V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 01:28:21 -0500
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1166949C@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi,

On Fri, Jan 13, 2012 at 04:52:42AM +0000, Huang Changming-R66093 wrote:
> 
> > For sd hosts, this should only happen for hosts which have
> > SDHCI_QUIRK_BROKEN_CARD_DETECTION set.
> Yes, but which will impact the performance.

You only set this bit when your host broke, and if your host has other
means to detect this, then go with your newly added callback.

> 
> 
> > > >
> > > > Therefore, add callback function get_cd() to check whether the card
> > > > has been removed when the driver has this callback function.
> > 
> > I don't quite get the meaning of cd, what does get_cd suppose to mean?
> This get_cd callback is implement in the special platform, because some SOC don't support this feature
> 
> > > >
> > > > If the card is present, 1 will return, if the card is absent, 0 will
> > > > return.
> > > > If the controller will not support this feature, -ENOSYS will return.
> > 
> > What about get_present, return 0 for present, and return error code
> > otherwise like the alive function does.
> The hook to detect card is get_cd in the kernel, don't need the new.
> 

I didn't mean to add a new function, I just can't get the meaning of cd.
I just did a grep of the code and find some same fuction names in
various host files, I think it's OK to continue with this name.

> > > >
> > > > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > > > CC: Chris Ball <cjb@laptop.org>
> > > > ---
> > > > changes for v2:
> > > >         - when controller don't support get_cd, return -ENOSYS
> > > >         - add the CC
> > > > changes for v3:
> > > >         - enalbe the controller clock in platform, instead of core
> > > > changes for v4:
> > > > 	- move the detect code to core.c according to the new structure
> > > >
> > > >  drivers/mmc/core/core.c |   10 ++++++++--
> > > >  1 files changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > > > 6db6621..d570c72 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -2060,7 +2060,7 @@ static int mmc_rescan_try_freq(struct mmc_host
> > > > *host, unsigned freq)
> > > >
> > 
> > snip
> > > >  int _mmc_detect_card_removed(struct mmc_host *host)  {
> > > > -	int ret;
> > > > +	int ret = -ENOSYS;
> > > >
> > > >  	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
> > > >  		return 0;
> > > > @@ -2068,7 +2068,13 @@ int _mmc_detect_card_removed(struct mmc_host
> > *host)
> > > >  	if (!host->card || mmc_card_removed(host->card))
> > > >  		return 1;
> > > >
> > > > -	ret = host->bus_ops->alive(host);
> > > > +	if (host->ops->get_cd) {
> > > > +		ret = host->ops->get_cd(host);
> > > > +		if (ret >= 0)
> > > > +			ret = !ret;
> > > > +	}
> > > > +	if (ret < 0)
> > > > +		ret = host->bus_ops->alive(host);
> > > >  	if (ret) {
> > > >  		mmc_card_set_removed(host->card);
> > > >  		pr_debug("%s: card remove detected\n", mmc_hostname(host));
> > > > --
> > > > 1.7.5.4
> > 
> > And the code can be changed to something like:
> > 	if (host->ops->get_present)
> > 		ret = host->ops->get_present(host);
> > 	else
> > 		ret = host->bus_ops->alive(host);
> > 	if (ret) {
> > 		mmc_card_set_removed(host->card);
> >   		pr_debug("%s: card remove detected\n", mmc_hostname(host));
> > 	}
> > 
> > 
> > Does this make sense?
> No.
> Because the get_cd is the hook to detect card in mmc_host_ops structure in include/linux/mmc/host.h.
> We don't need to add new.
>

I just suggested to change the name and use a different return value for
this get_cd function, not to add a new function call.



From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Fri, 13 Jan 2012 07:05:19 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11669591@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1324972835-12264-1-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F116692C7@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113032641.GB7564@ladygaga>
 <8A2FC72B45BB5A4C9F801431E06AE48F1166949C@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113062730.GB2701@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:14144
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081Ab2AMHF1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Jan 2012 02:05:27 -0500
In-Reply-To: <20120113062730.GB2701@ladygaga>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

If you read the previous email about this serial patches discussed with other guys, you can understand.

> -----Original Message-----
> From: Aaron Lu [mailto:aaron.lu@amd.com]
> Sent: Friday, January 13, 2012 2:28 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Chris Ball
> Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
> 
> Hi,
> 
> On Fri, Jan 13, 2012 at 04:52:42AM +0000, Huang Changming-R66093 wrote:
> >
> > > For sd hosts, this should only happen for hosts which have
> > > SDHCI_QUIRK_BROKEN_CARD_DETECTION set.
> > Yes, but which will impact the performance.
> 
> You only set this bit when your host broke, and if your host has other
> means to detect this, then go with your newly added callback.
To detect the card state, if SDHCI_QUIRK_BROKEN_CARD_DETECTION is set, then driver will send command to card, which will cause the bad performance.
So my patch will do:
1. use get_cd to detect the card state, if platform don't support this feature(get_cd is not defined in special platform), -ENOSYS will be returned
2. if -ENOSYS, then send the command to card.

> >
> > > > >
> > > > > If the card is present, 1 will return, if the card is absent, 0
> > > > > will return.
> > > > > If the controller will not support this feature, -ENOSYS will
> return.
> > >
> > > What about get_present, return 0 for present, and return error code
> > > otherwise like the alive function does.
> > The hook to detect card is get_cd in the kernel, don't need the new.
> >
> 
> I didn't mean to add a new function, I just can't get the meaning of cd.
> I just did a grep of the code and find some same fuction names in various
> host files, I think it's OK to continue with this name.


> > > > >
> > > > > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > > > > CC: Chris Ball <cjb@laptop.org>
> > > > > ---
> > > > > changes for v2:
> 
> > > > >
> > > > >  	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops-
> >alive)
> > > > >  		return 0;
> > > > > @@ -2068,7 +2068,13 @@ int _mmc_detect_card_removed(struct
> > > > > mmc_host
> > > *host)
> > > > >  	if (!host->card || mmc_card_removed(host->card))
> > > > >  		return 1;
> > > > >
> > > > > -	ret = host->bus_ops->alive(host);
> > > > > +	if (host->ops->get_cd) {
> > > > > +		ret = host->ops->get_cd(host);
> > > > > +		if (ret >= 0)
> > > > > +			ret = !ret;
> > > > > +	}
> > > > > +	if (ret < 0)
> > > > > +		ret = host->bus_ops->alive(host);
> > > > >  	if (ret) {
> > > > >  		mmc_card_set_removed(host->card);
> > > > >  		pr_debug("%s: card remove detected\n",
> mmc_hostname(host));
> > > > > --
> > > > > 1.7.5.4
> > >
> > > And the code can be changed to something like:
> > > 	if (host->ops->get_present)
> > > 		ret = host->ops->get_present(host);
> > > 	else
> > > 		ret = host->bus_ops->alive(host);
> > > 	if (ret) {
> > > 		mmc_card_set_removed(host->card);
> > >   		pr_debug("%s: card remove detected\n",
> mmc_hostname(host));
> > > 	}
> > >
> > >
> > > Does this make sense?
> > No.
> > Because the get_cd is the hook to detect card in mmc_host_ops structure
> in include/linux/mmc/host.h.
> > We don't need to add new.
> >
> 
> I just suggested to change the name and use a different return value for
> this get_cd function, not to add a new function call.
> 
The description for get_cd in file "include/linux/mmc/host.h":
         * Return values for the get_cd callback should be:
         *   0 for a absent card
         *   1 for a present card
         *   -ENOSYS when not supported (equal to NULL callback)
         *   or a negative errno value when something bad happened
I don't think your suggest is reasonable.



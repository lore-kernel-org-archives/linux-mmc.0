From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Fri, 13 Jan 2012 15:36:25 +0800
Message-ID: <20120113073625.GA29784@ladygaga>
References: <1324972835-12264-1-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F116692C7@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113032641.GB7564@ladygaga>
 <8A2FC72B45BB5A4C9F801431E06AE48F1166949C@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113062730.GB2701@ladygaga>
 <8A2FC72B45BB5A4C9F801431E06AE48F11669591@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:59048 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2AMHgj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 02:36:39 -0500
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11669591@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Fri, Jan 13, 2012 at 07:05:19AM +0000, Huang Changming-R66093 wrote:
> If you read the previous email about this serial patches discussed with other guys, you can understand.
> 
> > -----Original Message-----
> > From: Aaron Lu [mailto:aaron.lu@amd.com]
> > Sent: Friday, January 13, 2012 2:28 PM
> > To: Huang Changming-R66093
> > Cc: linux-mmc@vger.kernel.org; Chris Ball
> > Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
> > 
> > Hi,
> > 
> > On Fri, Jan 13, 2012 at 04:52:42AM +0000, Huang Changming-R66093 wrote:
> > >
> > > > For sd hosts, this should only happen for hosts which have
> > > > SDHCI_QUIRK_BROKEN_CARD_DETECTION set.
> > > Yes, but which will impact the performance.
> > 
> > You only set this bit when your host broke, and if your host has other
> > means to detect this, then go with your newly added callback.
> To detect the card state, if SDHCI_QUIRK_BROKEN_CARD_DETECTION is set, then driver will send command to card, which will cause the bad performance.
> So my patch will do:
> 1. use get_cd to detect the card state, if platform don't support this feature(get_cd is not defined in special platform), -ENOSYS will be returned
> 2. if -ENOSYS, then send the command to card.

OK, this is clear. I didn't know there is a get_cd callback already
defined in sdhci_ops with a clear return value description, sorry for
the mess.

> > I just suggested to change the name and use a different return value for
> > this get_cd function, not to add a new function call.
> > 
> The description for get_cd in file "include/linux/mmc/host.h":
>          * Return values for the get_cd callback should be:
>          *   0 for a absent card
>          *   1 for a present card
>          *   -ENOSYS when not supported (equal to NULL callback)
>          *   or a negative errno value when something bad happened
> I don't think your suggest is reasonable.
Agree.



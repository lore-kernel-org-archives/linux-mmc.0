From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 3/3] MMC/SD: add callback function to detect card
Date: Tue, 31 Aug 2010 20:38:07 +0100
Message-ID: <20100831193807.GC7847@console-pimps.org>
References: <1259913309-27146-1-git-send-email-r66093@freescale.com>
 <20100827190513.GC20407@void.printf.net>
 <20100831191040.GB7847@console-pimps.org>
 <4C7D56AB.1060307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:52014 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754924Ab0HaTiJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 15:38:09 -0400
Content-Disposition: inline
In-Reply-To: <4C7D56AB.1060307@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Chris Ball <cjb@laptop.org>, "r66093@freescale.com" <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Tue, Aug 31, 2010 at 10:23:23PM +0300, Adrian Hunter wrote:
> Matt Fleming wrote:
> >On Fri, Aug 27, 2010 at 08:05:13PM +0100, Chris Ball wrote:
> >>Hi,
> >>
> >>On Fri, Dec 04, 2009 at 03:55:09PM +0800, r66093@freescale.com wrote:
> >>>From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >>>
> >>>Add callback function to check if the card has been removed.
> >>>
> >>>in order to check if the card has been removed, the function mmc_send_status will send commad CMD13 to card and ask the card to send its status register to driver, which will generate interrupt repeatly and make the system bad.
> >>>Therefore, get_cd callback is used to detect the card if the driver has.
> >>>
> >>>Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >>>---
> >>> drivers/mmc/core/mmc.c |    5 ++++-
> >>> drivers/mmc/core/sd.c  |    5 ++++-
> >>> 2 files changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>>diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>>index 06084db..c5c676d 100644
> >>>--- a/drivers/mmc/core/mmc.c
> >>>+++ b/drivers/mmc/core/mmc.c
> >>>@@ -494,7 +494,10 @@ static void mmc_detect(struct mmc_host *host)
> >>> 	/*
> >>> 	 * Just check if our card has been removed.
> >>> 	 */
> >>>-	err = mmc_send_status(host->card, NULL);
> >>>+	if (host->ops->get_cd)
> >>>+		err = !host->ops->get_cd(host);
> >>>+	else
> >>>+		err = mmc_send_status(host->card, NULL);
> >>> 	mmc_release_host(host);
> >>>diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >>>index cd81c39..3cf1f38 100644
> >>>--- a/drivers/mmc/core/sd.c
> >>>+++ b/drivers/mmc/core/sd.c
> >>>@@ -548,7 +548,10 @@ static void mmc_sd_detect(struct mmc_host *host)
> >>> 	/*
> >>> 	 * Just check if our card has been removed.
> >>> 	 */
> >>>-	err = mmc_send_status(host->card, NULL);
> >>>+	if (host->ops->get_cd)
> >>>+		err = !host->ops->get_cd(host);
> >>>+	else
> >>>+		err = mmc_send_status(host->card, NULL);
> >>> 	mmc_release_host(host);
> >>>-- 
> >>>1.6.4
> >>This patchset wasn't replied to -- any comments on it from the list?
> >
> >I think this change makes sense, although it needs to be a bit smarter
> >with error handling because the get_cd() functions can return -ENOSYS if
> >they are not implemented (but the function pointer is still valid).
> >
> >	int err = 0;
> >
> >	if (host->ops->get_cd) {
> >		err = host->ops->get_cd(host);
> >		if (err >= 0)
> >			err = !err;
> >	}
> >
> >	if (!host->ops->get_cd || err < 0)
> >		err = mmc_send_status(host->card, NULL);
> >
> >Thoughts?
> 
> I am not sure it won't cause problems.
> 
> If you change the card then card detect will return true because
> there is a card but send status will fail because the card is not
> initialised.  So the two do not seem equivalent.

Are you sure that the SEND_STATUS will fail if the card hasn't been
initialised? We don't actually look at the response from the SEND_STATUS
command, just whether the command itself failed or succeeded. Even if
the card isn't initialised, the command should succeed. And when we
return from mmc_rescan() we'll initialise the card anyway.

I'm not sure it won't cause problems either and I'd feel a lot more
confident if someone could test it on their hardware though ;-) None of
my boards implement the get_cd function.

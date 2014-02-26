From: Tony Lindgren <tony@atomide.com>
Subject: Re: SD card timeout problems on Nokia N900 (omap_hsmmc on OMAP3)
Date: Wed, 26 Feb 2014 09:03:23 -0800
Message-ID: <20140226170323.GB11654@atomide.com>
References: <20140225234746.GA13866@earth.universe>
 <CAOf5uwn0sziBhE9edyiVqj8MUTidbX19YhgDsgikn5VLbx0B7A@mail.gmail.com>
 <530D8FF2.3070100@gmail.com>
 <530DA97E.7090406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19551 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752500AbaBZRDh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2014 12:03:37 -0500
Content-Disposition: inline
In-Reply-To: <530DA97E.7090406@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@ring0.de>, Michael Trimarchi <michael@amarulasolutions.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, 'Chris Ball' <chris@printf.net>

* Balaji T K <balajitk@ti.com> [140226 00:48]:
> On Wednesday 26 February 2014 12:25 PM, Stefan Roese wrote:
> >Hi Sebastian,
> >
> >On 26.02.2014 07:02, Michael Trimarchi wrote:
> >>Hi Sebastian
> >>
> >>On Wed, Feb 26, 2014 at 12:47 AM, Sebastian Reichel <sre@ring0.de> wrote:
> >>>Hi,
> >>>
> >>>I have problems with the SD-card initialization on my Nokia N900
> >>>using a 3.14-rc1 based kernel in DT boot mode. The bug is can be
> >>>circumvented by changing the kernel slightly (e.g. remove some DT
> >>>nodes or mark them as disabled). So the SD card's timeout problems
> >>>seem to derive from kernel timing problems. I'm pretty sure, that
> >>>the problems are not originating from a broken SD card, since
> 
> Can you provide removed/Disabled dt nodes, it might give some clue ?
> 
> >>>
> >>>  1. The SD card worked quite good before and still does depending
> >>>     on unrelated DTS changes (=> loading less drivers).
> >>>  2. The SD card works flawlessly on my notebook using a USB adapter
> >>>  3. Another SD card showed the same problem
> >>>
> >>>I tried to git bisect the problem, but I just get shown some
> >>>unrelated driver additions.
> >>>
> >>>Anyways, this is the error I get during boot:
> >>>
> >>>[    3.896820] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> >>>...
> >>>[    5.956237] mmc0: error -110 whilst initialising SD card
> >>>
> >>
> >>Are you sure that some subsystem that you deactivate don't change
> >>pin muxing setting? Can you check in the broken system if the pins of the sdcard
> >>are correctly muxed? Does it happen even if you change the sdcard?
> >
> >Did you try to add this patch series:
> >
> >http://www.spinics.net/lists/linux-omap/msg103264.html
> >
> >Without it I'm also having problems with MMC detection on some OMAP3 based boards.
> >
> >Balaji, what is the status of this patch series? Are there any chances that it will be included in v3.14?
> >
> 
> Due to dependencies between regulator, mmc, omap def config, devicetree changes,
> I am hoping either Chris or Tony pick the whole series for 3.15

Best that Chris takes it all, I just acked the only patch that did not have
my ack yet.
 
> Couple of tested-by will surely help.

Yeah please ack in the thread above if you did not already.

Regards,

Tony

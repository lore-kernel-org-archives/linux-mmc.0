From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] mmc: change initial clock setting
Date: Fri, 18 Jun 2010 13:42:12 +0100
Message-ID: <87iq5gfr6j.fsf@linux-g6p1.site>
References: <4C1AF098.1080400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:57830 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932106Ab0FRMmS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2010 08:42:18 -0400
In-Reply-To: <4C1AF098.1080400@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org

On Fri, 18 Jun 2010 13:05:44 +0900, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch is bug fixed..
> I think that host->ios.clock(initial clock) will be set lower than 400KHz.
> But in this code, if host->f_min is higher than 400KHz, print warning message and set higher than 400KHz.
> And We use SDHCI_QUIRK_NONSTANDARD_CLOCK..so using get_min_clock function. 
> but didn't effect nothing through used get_min_clock function.

I'm a little confused. What problem are you fixing with this patch? What
issue are you seeing? SDHCI_QUIRK_NONSTANDARD_CLOCK is only for sdhci.
If this is the old "my card won't initialise at 400kHz" chestnut I don't
think a solution has ever been agreed upon. The problem was that while
some cards won't initialise at 400kHz, some controllers will try to
initialise at too low a frequency which causes other problems.

Sascha Hauer explains the reason for setting ios.clock to 400kHz here,

       http://lkml.org/lkml/2010/1/5/120

So I think your patch will cause problems.

Which driver are you using? The driver should have set the f_min value
to be <= 400kHz. Maybe it is a good idea to set the value of ios.clock
to 400kHz if the driver has set a bogus f_min value, we will at least
have a fighting chance of initialising the card (though I would say that
the driver was broken, but at least core.c will print a warning).

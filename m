From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 1/2] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Fri, 07 Sep 2012 14:59:03 -0700
Message-ID: <877gs5jxzs.fsf@deeprootsystems.com>
References: <1346159947-3194-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37745 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2IGV7F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Sep 2012 17:59:05 -0400
Received: by pbbrr13 with SMTP id rr13so220824pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 07 Sep 2012 14:59:05 -0700 (PDT)
In-Reply-To: <1346159947-3194-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Tue, 28 Aug 2012 18:49:06 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balbi@ti.com

Venkatraman S <svenkatr@ti.com> writes:

> omap hsmmc controller IP has a built in timer that can be programmed to
> guard against unresponsive operations. But its range is very narrow,
> and the maximum countable time is a few seconds.
>
> Card maintenance operations like BKOPS and MMC_ERASE and long
> stream writes like packed command require timers of order of
> several minutes, much beyond the capability of the IP timer.
> So get rid of using the IP timer entirely and use kernel's hrtimer
> functionality for guarding the device operations.
> As part of this change, a workaround that disabled timeouts for
> MMC_ERASE command is removed, and the arbitary timing of 100ms
> is used only when the timeout is not explicitly specified by core.
>
> A trivial change to get rid of unnecessary dealiasing of host->data
> in omap_hsmmc_do_irq is also included.
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Dumb question: if the timers needed are on the order of minutes, why do
you need to use high-resolution timers?  I'm guessing the normal
kernel-internal timers should suffice here (see <linux/timer.h,
init_timer().)

Also, if they're on the order of minutes, I assume the actual firing
doesn't have to be precise, so deferrable timers can probably be used
(and thus help PM by coalescing wakeup events.) 

If my assumptions are true, it might be worth considering using the
normal timers, and use init_timer_deferrable().

Kevin

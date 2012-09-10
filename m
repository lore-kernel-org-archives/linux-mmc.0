From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCHv2 1/2] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Mon, 10 Sep 2012 10:03:01 +0530
Message-ID: <CANfBPZ_dg4BBN4-kP1_JGPBb=U16h1mj=PFgP36o=J75BXhk-Q@mail.gmail.com>
References: <1346159947-3194-1-git-send-email-svenkatr@ti.com> <877gs5jxzs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52521 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab2IJEdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Sep 2012 00:33:23 -0400
Received: by pbbrr13 with SMTP id rr13so1872651pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 09 Sep 2012 21:33:22 -0700 (PDT)
In-Reply-To: <877gs5jxzs.fsf@deeprootsystems.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balbi@ti.com

On Sat, Sep 8, 2012 at 3:29 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Venkatraman S <svenkatr@ti.com> writes:
>
>> omap hsmmc controller IP has a built in timer that can be programmed to
>> guard against unresponsive operations. But its range is very narrow,
>> and the maximum countable time is a few seconds.
>>
>> Card maintenance operations like BKOPS and MMC_ERASE and long
>> stream writes like packed command require timers of order of
>> several minutes, much beyond the capability of the IP timer.
>> So get rid of using the IP timer entirely and use kernel's hrtimer
>> functionality for guarding the device operations.
>> As part of this change, a workaround that disabled timeouts for
>> MMC_ERASE command is removed, and the arbitary timing of 100ms
>> is used only when the timeout is not explicitly specified by core.
>>
>> A trivial change to get rid of unnecessary dealiasing of host->data
>> in omap_hsmmc_do_irq is also included.
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>
> Dumb question: if the timers needed are on the order of minutes, why do
> you need to use high-resolution timers?  I'm guessing the normal
> kernel-internal timers should suffice here (see <linux/timer.h,
> init_timer().)
>
Both sub ms and long duration timers are needed, based on the type of operation.
The eMMC standard has evolved to define new commands which require
such long duration
operations. The short ("control") commands do need high precision.

> Also, if they're on the order of minutes, I assume the actual firing
> doesn't have to be precise, so deferrable timers can probably be used
> (and thus help PM by coalescing wakeup events.)
>
> If my assumptions are true, it might be worth considering using the
> normal timers, and use init_timer_deferrable().
>
I'll certainly look into this. One way is to use the IP timer for
short commands and
deferrable timers for long ones - but I reckon it would be messy.

I've actually put this patch on hold - as someone pointed out to me that
this violates some sections of eMMC spec.


> Kevin

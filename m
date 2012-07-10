From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix runtime suspend crash: add host checks in callbacks
Date: Tue, 10 Jul 2012 15:57:06 -0700
Message-ID: <87629vkywt.fsf@ti.com>
References: <1341620786-13598-1-git-send-email-khilman@ti.com>
	<CANfBPZ-ucJkgJLt4eXRvfGTCJnWTxHUuL9Cnp9GoaQq7keHGqg@mail.gmail.com>
	<871ukjvgyg.fsf@ti.com>
	<CANfBPZ8i-N-0=GMk5OZ+oLipCv3fihHd3N1gYp_F94PE5LM5rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55012 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754764Ab2GJW5I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 18:57:08 -0400
Received: by pbbrq13 with SMTP id rq13so1094998pbb.8
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jul 2012 15:57:07 -0700 (PDT)
In-Reply-To: <CANfBPZ8i-N-0=GMk5OZ+oLipCv3fihHd3N1gYp_F94PE5LM5rg@mail.gmail.com>
	(Venkatraman S.'s message of "Tue, 10 Jul 2012 20:17:45 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, "open list:MULTIMEDIA CARD (...), linux-kernel@vger.kernel.org
	(open list)" <linux-mmc@vger.kernel.org>

"S, Venkatraman" <svenkatr@ti.com> writes:

> On Tue, Jul 10, 2012 at 7:47 PM, Kevin Hilman <khilman@ti.com> wrote:
>> "S, Venkatraman" <svenkatr@ti.com> writes:
>>
>>> On Sat, Jul 7, 2012 at 5:56 AM, Kevin Hilman <khilman@ti.com> wrote:
>>>> Due to the way the driver core takes runtime PM references during
>>>> probe, a driver's runtime PM callbacks may not be called until probe
>>>> returns.  During probe, drvdata is set to the 'host' pointer but if
>>>> probe fails, drvdata is set to NULL.
>>>>
>>>> The runtime PM callbacks currently blindly dereference this host
>>>> pointer, but if probe fails, and the runtime PM callbacks are called
>>>> after probe returns, a NULL pointer dereference will result.
>>>>
>>> Pardon my ignorance, but why would runtime suspend be called for a
>>> device whose probe has failed ? AFAIK, MMC stack wouldn't make the
>>> _enable()/disable() calls, which call runtime PM APIs, unless the
>>> probe is successful.  Is there a stacktrace for the offending caller ?
>>
>> First thing to note: there are several error conditions *after*
>> pm_runtime_enable() and the first _get_sync() are called.
>>
>> So here's what can happen:
>>
>> The driver core does a _get_noresume() before calling the driver's
>> probe, so the runtime PM usecount is already 1 when the driver is
>> called.  The _get_sync() in _probe enables the device and increases the
>> usecount to 2.  The _put_sync() at the end of ->probe() will decrease
>> the usecount to 1, but since the usecount is still non-zero, the
>> driver's callbacks are still not called.  It's not until the driver core
>> does its _put_sync (to balance the _get_noresume() that the usecount
>> goes to zero and the driver's callbacks are called.
>>
> Thanks for the detailed explanation.
> But pm_runtime_disable() is called in the error path, so shouldn't
> it prevent the driver callbacks from being called ? 

Yes, you're right.  

I'm getting a few different problems mixed together here.  To work on a
different problem, I had commented out the pm_runtime_disable() call in
the error path and so I was seeing the callbacks being called even on
probe failure.  Withe the pm_runtime_disable() added back, that doesn't
happen.

However, there is another case where the runtime PM callbacks may be
called: the PM domain code in omap_device can still attempts to call the
runtime PM callbacks during late suspend for devices that are not
already runtime suspended.  This is done even when there is no driver
bound to a device, but this is a bug in the omap_device code, not in the
MMC driver.  So I'll be sending a patch shortly to fix that.

So, all that to say, this patch can be dropped.

Thanks for the detailed review.

Kevin

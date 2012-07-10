From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix runtime suspend crash: add host
 checks in callbacks
Date: Tue, 10 Jul 2012 20:17:45 +0530
Message-ID: <CANfBPZ8i-N-0=GMk5OZ+oLipCv3fihHd3N1gYp_F94PE5LM5rg@mail.gmail.com>
References: <1341620786-13598-1-git-send-email-khilman@ti.com>
 <CANfBPZ-ucJkgJLt4eXRvfGTCJnWTxHUuL9Cnp9GoaQq7keHGqg@mail.gmail.com> <871ukjvgyg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:40910 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753384Ab2GJOs3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 10:48:29 -0400
Received: by bkty7 with SMTP id y7so54269bkt.31
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jul 2012 07:48:23 -0700 (PDT)
In-Reply-To: <871ukjvgyg.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, "open list:MULTIMEDIA CARD (...), linux-kernel@vger.kernel.org (open
	list)" <linux-mmc@vger.kernel.org>

On Tue, Jul 10, 2012 at 7:47 PM, Kevin Hilman <khilman@ti.com> wrote:
> "S, Venkatraman" <svenkatr@ti.com> writes:
>
>> On Sat, Jul 7, 2012 at 5:56 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> Due to the way the driver core takes runtime PM references during
>>> probe, a driver's runtime PM callbacks may not be called until probe
>>> returns.  During probe, drvdata is set to the 'host' pointer but if
>>> probe fails, drvdata is set to NULL.
>>>
>>> The runtime PM callbacks currently blindly dereference this host
>>> pointer, but if probe fails, and the runtime PM callbacks are called
>>> after probe returns, a NULL pointer dereference will result.
>>>
>> Pardon my ignorance, but why would runtime suspend be called for a
>> device whose probe has failed ? AFAIK, MMC stack wouldn't make the
>> _enable()/disable() calls, which call runtime PM APIs, unless the
>> probe is successful.  Is there a stacktrace for the offending caller ?
>
> First thing to note: there are several error conditions *after*
> pm_runtime_enable() and the first _get_sync() are called.
>
> So here's what can happen:
>
> The driver core does a _get_noresume() before calling the driver's
> probe, so the runtime PM usecount is already 1 when the driver is
> called.  The _get_sync() in _probe enables the device and increases the
> usecount to 2.  The _put_sync() at the end of ->probe() will decrease
> the usecount to 1, but since the usecount is still non-zero, the
> driver's callbacks are still not called.  It's not until the driver core
> does its _put_sync (to balance the _get_noresume() that the usecount
> goes to zero and the driver's callbacks are called.
>
Thanks for the detailed explanation.
But pm_runtime_disable() is called in the error path, so shouldn't
it prevent the driver callbacks from being called ? (The docuementation
talks about disable_depth field, but it doesn't sound right that runtime
pm would be enabled before _probe() is called. So disable_depth should
be 1 when pm_runtime_disable is called in _probe error path, right ?)

> When probe succeeds, this all works fine.  However, if probe fails the
> host pointer is set to NULL, but the runtime PM callbacks are still
> called and attempt to dereference a NULL pointer.
>
>>> Fix this by simply checking to be sure the host pointer is non-NULL.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> ---
>>> Applies to v3.5-rc5.  Fix is needed for v3.5-rc.
>>>
>> Can you please let me know which commit introduced this problem
>> in the first place ? There were not many changes in MMC PM code
>> in this merge window.
>
> I guess this problem is probably not a regression and has been around
> for some time.  It has not been seen because probe has not failed.
>
> In using recent l-o master though, with Russell's dmaengine changes
> merged, probe is failing for me becasue it can't allocate a DMA channel,
> and then I'm seeing this problem.
>
> Kevin

Ok. I'll let Chris decide on this - DMA engine is not yet in Linus's tree
though.

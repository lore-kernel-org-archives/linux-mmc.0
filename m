From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC/PATCH] mmc: core: Signal wakeup event at card insert/removal
Date: Tue, 24 Sep 2013 09:58:53 -0700
Message-ID: <5241C4CD.4080200@linaro.org>
References: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>	<CAME+o4kCPRu0EXvKPijC9bdfEZGefO9XyE=xUARpvRstunLTCA@mail.gmail.com> <CAPDyKFpR3rnLHs-teD5VhPEnsJbsV01zeooggQcD8884YWWGKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43976 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab3IXQ65 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 12:58:57 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so4810374pbc.17
        for <linux-mmc@vger.kernel.org>; Tue, 24 Sep 2013 09:58:56 -0700 (PDT)
In-Reply-To: <CAPDyKFpR3rnLHs-teD5VhPEnsJbsV01zeooggQcD8884YWWGKA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Zoran Markovic <zoran.markovic@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>

On 09/24/2013 12:55 AM, Ulf Hansson wrote:
> Hi Zoran,
>
> On 23 September 2013 23:14, Zoran Markovic <zoran.markovic@linaro.org> wrote:
>> Hi Ulf,
>> I like the fact that wakeups are now quite simplified. A couple of
>> comments below:
>>
>>> By signaling the wakeup event for a time of 5 s for devices configured
>>> as wakeup capable, we likely will be prevent a sleep long enough to let
>>> user space consume the event.
>> Given that there is no pm_relax(), 5 seconds is probably too long.
>> User space should grab a wakeup_source of its own if it needs to
>> extend the awake state. I recommend putting just enough to start the
>> mount process - probably 0.5-1 second - but Android guys would know
>> better.
> The total time before users pace gets notified can be summarized like this:
>
> 1.
> Total system resume time, which has quite a big span of expected
> consumed time. Do note, if other (e)MMC and/or SD-cards are already
> inserted, these will be re-initialized as a part the resume and this
> affect the resume time significantly. Typically an eMMC takes 200-400
> ms and an SD-card 250-1100ms.
>
> 2. The scheduled rescan work shall be given priority to execute and
> then complete the initialization of the recently inserted card. If we
> assume it will be and SD-card, 250-1100 ms.
>
> 3. Once the card device is created from the rescan work, notification
> is propagated upwards to user space. For this task I have no relevant
> estimation on consumed time.

So how does the notification done to userspace? I wonder if you could
use the select/lock/read style method for releasing the kernel space
wakeup_source, as is done in the input layer?


> Not sure how to set the time-out value to meet all expectations. I
> believe we could also consider that inserting/removing a card is a
> quite seldom operation, so using a bit higher value than necessary
> might be okay. What do you think?

As long as its sure to be *very* rare, then slightly longer delays
aren't a major problem.  The trouble with the timeout style wakelocks is
that they are easy to misuse and that hurts power efficiency. (I've
heard stories of badly written wifi drivers that took 5 minute timed
wakelocks on packets, which effectively kept devices from ever sleeping).

So if possible, its much better to have a normal path where the pm_relax
is called in most cases, using the timeout for only the few places where
you really can't get an end point.

thanks
-john

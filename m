From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH] mmc: core: Signal wakeup event at card insert/removal
Date: Tue, 24 Sep 2013 09:55:43 +0200
Message-ID: <CAPDyKFpR3rnLHs-teD5VhPEnsJbsV01zeooggQcD8884YWWGKA@mail.gmail.com>
References: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>
	<CAME+o4kCPRu0EXvKPijC9bdfEZGefO9XyE=xUARpvRstunLTCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44201 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab3IXHzo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 03:55:44 -0400
Received: by mail-vb0-f46.google.com with SMTP id p13so3096836vbe.33
        for <linux-mmc@vger.kernel.org>; Tue, 24 Sep 2013 00:55:43 -0700 (PDT)
In-Reply-To: <CAME+o4kCPRu0EXvKPijC9bdfEZGefO9XyE=xUARpvRstunLTCA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zoran Markovic <zoran.markovic@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>

Hi Zoran,

On 23 September 2013 23:14, Zoran Markovic <zoran.markovic@linaro.org> wrote:
> Hi Ulf,
> I like the fact that wakeups are now quite simplified. A couple of
> comments below:
>
>> By signaling the wakeup event for a time of 5 s for devices configured
>> as wakeup capable, we likely will be prevent a sleep long enough to let
>> user space consume the event.
> Given that there is no pm_relax(), 5 seconds is probably too long.
> User space should grab a wakeup_source of its own if it needs to
> extend the awake state. I recommend putting just enough to start the
> mount process - probably 0.5-1 second - but Android guys would know
> better.

The total time before users pace gets notified can be summarized like this:

1.
Total system resume time, which has quite a big span of expected
consumed time. Do note, if other (e)MMC and/or SD-cards are already
inserted, these will be re-initialized as a part the resume and this
affect the resume time significantly. Typically an eMMC takes 200-400
ms and an SD-card 250-1100ms.

2. The scheduled rescan work shall be given priority to execute and
then complete the initialization of the recently inserted card. If we
assume it will be and SD-card, 250-1100 ms.

3. Once the card device is created from the rescan work, notification
is propagated upwards to user space. For this task I have no relevant
estimation on consumed time.

Not sure how to set the time-out value to meet all expectations. I
believe we could also consider that inserting/removing a card is a
quite seldom operation, so using a bit higher value than necessary
might be okay. What do you think?

>
>> +       /*
>> +        * If the device is configured as wakeup, we prevent a new sleep for
>> +        * 5 s to give provision for user space to consume the event.
>> +        */
>> +       if (cd_irq && !(host->caps & MMC_CAP_NEEDS_POLL) &&
>> +               device_can_wakeup(mmc_dev(host)))
>> +               pm_wakeup_event(mmc_dev(host), 5000);
> It seems like device_can_wakeup() is redundant here and I'm not sure
> what happens if a device is not wakeup capable. Was the intention to
> go into autosleep until something else wakes up the system long enough
> to complete the mount? Also is it ok if MMCs that require polling
> exhibit wakeup behaviour of their own?

I did not want to change present behaviour for all host drivers and
platforms, but instead host drivers need take an action of enabling
wakeup. If they consider to use card detect as wakeup irq, they need
adapt anyway, the irq is not default a wakeup irq.

In polling mode, new inserted cards will never be detected in suspend
state, since the entire system needs to be resumed to be able to
"poll". This is just not feasible. :-)

Kind regards
Ulf Hansson

>
> Zoran

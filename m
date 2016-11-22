From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Tue, 22 Nov 2016 09:54:18 +0100
Message-ID: <CACRpkdagS-7kaYCd2Sq0vLR8+19Mmckx=CuCqPv+HheRk8Cm7w@mail.gmail.com>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
 <CAJZ5v0gCDQXebsQoCYJY5FyE6oJUw4s6sQrNbKLuxpLvOe2RoA@mail.gmail.com>
 <CACRpkdY+jdU4ETuMJsY-efSkjwE0fWWRZoyCyrYAs_GxUo-DhQ@mail.gmail.com> <17679227.zg8zl3jhbr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:32915 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbcKVIyT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 03:54:19 -0500
Received: by mail-qt0-f182.google.com with SMTP id p16so6556629qta.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 00:54:19 -0800 (PST)
In-Reply-To: <17679227.zg8zl3jhbr@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Binoy Jayan <binoy.jayan@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Jiri Kosina <jikos@kernel.org>

On Wed, Nov 16, 2016 at 5:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, November 16, 2016 4:20:47 PM CET Linus Walleij wrote:
>> On Wed, Nov 16, 2016 at 1:46 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> > Well, we had a session at the KS regarding usage of the freezer on
>> > kernel threads and the conclusion was to get rid of that (as opposed
>> > to freezing user space, which is necessary IMO).  So this change would
>> > go in the opposite direction.
>>
>> Aha so I should not make this thread look like everyone else, instead
>> everyone else should look like this thread, haha
>>
>> Ah well, I'll just drop it.
>
> It would still be good to remove the semaphore and do something else,
> as we also want to remove all semaphores. ;-)
>
> We could check "mq->flags & MMC_QUEUE_SUSPENDED" in the kthread to see
> if the queue is currently suspended, and otherwise go to sleep there,
> and then call wake_up() in the resume function.

Hm... so simply:

if (mq->flags & MMC_QUEUE_SUSPENDED)
  schedule();

?

This whole kthread business is pretty messy. I would prefer if I could
just convert it to a workqueue. Just that it's not very simple the way
it speculates around in the request queue from the block layer.

> While looking at that code, I just noticed that access to
> mq->flags is racy and should be fixed as well.

I guess we should take the queue lock &q->lock around accessing
the flags.

Yours,
Linus Walleij

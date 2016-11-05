From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: mxs: Use the spinlock irq variants
Date: Sat, 5 Nov 2016 16:56:09 -0200
Message-ID: <CAOMZO5D3YqgB7iUuayOw8tX236Usy1S9kOH_XQZ+JdzVyCpmSQ@mail.gmail.com>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
 <1477594672-31611-2-git-send-email-festevam@gmail.com> <20161028102310.5190d3c7@xhacker>
 <CAOMZO5DZUrjRgWiaW9mtmVBy0Tq+omEdiuP55TGvPiAxLvBHBg@mail.gmail.com> <20161028194947.463870ab@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35678 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755511AbcKES4K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Nov 2016 14:56:10 -0400
Received: by mail-vk0-f67.google.com with SMTP id x186so4478583vkd.2
        for <linux-mmc@vger.kernel.org>; Sat, 05 Nov 2016 11:56:10 -0700 (PDT)
In-Reply-To: <20161028194947.463870ab@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Jisheng,

On Fri, Oct 28, 2016 at 9:49 AM, Jisheng Zhang <jszhang@marvell.com> wrote:

> This is not the key. The key here is:
>
> compared with the non-irq version, the irq-version spin lock does one extra
> work: disable the local interrupts. But since we are in interrupt handler,
> the local irq is already disabled, so there's no need for the irq-versions.
>
> I'm not sure I understand the situation, comments are welcome.

Quoting  http://www.xml.com/ldd/chapter/book/ch09.html:

"Many users of spinlocks stick to spin_lock and spin_unlock. If you
are using spinlocks in interrupt handlers, however, you must use the
IRQ-disabling versions (usually spin_lock_irqsave and
spin_unlock_irqsave) in the noninterrupt code. To do otherwise is to
invite a deadlock situation.

It is worth considering an example here. Assume that your driver is
running in its read method, and it obtains a lock with spin_lock.
While the read method is holding the lock, your device interrupts, and
your interrupt handler is executed on the same processor. If it
attempts to use the same lock, it will go into a busy-wait loop, since
your read method already holds the lock. But, since the interrupt
routine has preempted that method, the lock will never be released and
the processor deadlocks, which is probably not what you wanted.

This problem can be avoided by using spin_lock_irqsave to disable
interrupts on the local processor while the lock is held. When in
doubt, use the _irqsave versions of the primitives and you will not
need to worry about deadlocks. Remember, though, that the flags value
from spin_lock_irqsave must not be passed to other functions."

And as I mentioned before Documentation/locking/spinlocks.txt is very
clear about the need of using spin_lock_irqsave inside interrupt
handlers.

Feel free to submit a patch to Documentation/locking/spinlocks.txt if
you think this is incorrect.

Thanks

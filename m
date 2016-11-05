From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: mxs: Use the spinlock irq variants
Date: Sat, 5 Nov 2016 17:19:18 -0200
Message-ID: <CAOMZO5AsNQMOjGmbJNG-xR0D6-EaB+x7LGmOrT7WKAHEzYfcUQ@mail.gmail.com>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
 <1477594672-31611-2-git-send-email-festevam@gmail.com> <20161028102310.5190d3c7@xhacker>
 <CAOMZO5DZUrjRgWiaW9mtmVBy0Tq+omEdiuP55TGvPiAxLvBHBg@mail.gmail.com>
 <20161028194947.463870ab@xhacker> <CAOMZO5D3YqgB7iUuayOw8tX236Usy1S9kOH_XQZ+JdzVyCpmSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36537 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755084AbcKETTT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Nov 2016 15:19:19 -0400
Received: by mail-ua0-f181.google.com with SMTP id b35so91601766uaa.3
        for <linux-mmc@vger.kernel.org>; Sat, 05 Nov 2016 12:19:19 -0700 (PDT)
In-Reply-To: <CAOMZO5D3YqgB7iUuayOw8tX236Usy1S9kOH_XQZ+JdzVyCpmSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Jisheng,

On Sat, Nov 5, 2016 at 4:56 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Jisheng,
>
> On Fri, Oct 28, 2016 at 9:49 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
>
>> This is not the key. The key here is:
>>
>> compared with the non-irq version, the irq-version spin lock does one extra
>> work: disable the local interrupts. But since we are in interrupt handler,
>> the local irq is already disabled, so there's no need for the irq-versions.
>>
>> I'm not sure I understand the situation, comments are welcome.
>
> Quoting  http://www.xml.com/ldd/chapter/book/ch09.html:
>
> "Many users of spinlocks stick to spin_lock and spin_unlock. If you
> are using spinlocks in interrupt handlers, however, you must use the
> IRQ-disabling versions (usually spin_lock_irqsave and
> spin_unlock_irqsave) in the noninterrupt code. To do otherwise is to
> invite a deadlock situation.

Ah, after re-reading it several times I agree with you now. It is the
noninterrupt code that needs the irq spinlock versions.

I will resend the series without this patch.

Thanks

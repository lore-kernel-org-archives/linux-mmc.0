From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/38] mmc: sdio_irq: rework sdio irq handling
Date: Thu, 24 Apr 2014 10:58:59 +0200
Message-ID: <CAPDyKFrPSvtvGgKX+ZgF0kPvr=m1rsUYUcHjyC_=UL5PUhYX2Q@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<E1Wd2Up-0003uJ-7k@rmk-PC.arm.linux.org.uk>
	<CAPDyKFpqJQ4pA6JEWjBwxbuoZ9HkiUAz89O_5YVVBaVh13XeMQ@mail.gmail.com>
	<20140424084616.GE26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:61375 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbaDXI7A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 04:59:00 -0400
Received: by mail-qc0-f171.google.com with SMTP id c9so2164528qcz.2
        for <linux-mmc@vger.kernel.org>; Thu, 24 Apr 2014 01:59:00 -0700 (PDT)
In-Reply-To: <20140424084616.GE26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24 April 2014 10:46, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Apr 24, 2014 at 09:58:55AM +0200, Ulf Hansson wrote:
>> On 23 April 2014 21:06, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> > +               if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
>> > +                       atomic_set(&host->sdio_irq_thread_abort, 0);
>> > +                       host->sdio_irq_thread =
>> > +                               kthread_run(sdio_irq_thread, host,
>> > +                                           "ksdioirqd/%s", mmc_hostname(host));
>> > +                       if (IS_ERR(host->sdio_irq_thread)) {
>> > +                               int err = PTR_ERR(host->sdio_irq_thread);
>> > +                               host->sdio_irqs--;
>> > +                               return err;
>> > +                       }
>> > +               } else {
>>
>> I suppose you need to check for MMC_CAP_SDIO_IRQ here?
>
> Why would you set MMC_CAP2_SDIO_NOTHREAD if you didn't have MMC_CAP_SDIO_IRQ ?

You are right!

Maybe change the name to "MMC_CAP2_SDIO_IRQ_NOTHREAD", unless we think
it becomes too long :-). Additionally, there are actually still some
bits available in the MMC_CAP_* bits, instead of the MMC_CAP2_*.

No strong opinion though, feel free to keep as is.

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.

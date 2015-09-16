From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: pxamci: fix card detect threaded interrupt
Date: Wed, 16 Sep 2015 11:22:58 +0200
Message-ID: <87io7asop9.fsf@belgarion.home>
References: <1442048611-23314-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFr6-hjiUUrcbZzmkykasMFDSXUPvpPvyM=UfaOX48cdwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:46080 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbbIPJ17 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2015 05:27:59 -0400
In-Reply-To: <CAPDyKFr6-hjiUUrcbZzmkykasMFDSXUPvpPvyM=UfaOX48cdwA@mail.gmail.com>
	(Ulf Hansson's message of "Wed, 16 Sep 2015 09:24:19 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Cvek <petr.cvek@tul.cz>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 12 September 2015 at 11:03, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Change the interrupt flavor of the card detection, from a hard interrupt
>> to a threaded interrupt. There is no strong requirement for a hard
>> interrupt.
>>
>> It fixes the case where the card detection is on a gpio expander, on I2C
>> for example on zylonite board. In this case, the card detect netsted
>> interrupt is called from a threaded interrupt. The request_irq() fails,
>> because a hard irq cannot be a nested interrupt from a threaded
>> interrupt (set __setup_irq()).
>>
>> This was tested on zylonite and mioa701 boards.
>
> This may indeed fix that separate issue, but looking into pxamci
> driver I realize that the card detect configuration suffers from other
> issues as well.
>
> 1. The irq shouldn't be requested until after the host has been added.
> Else an IRQ will call mmc_detect_change() with a non-added mmc host,
> which is really a bad idea. :-)
> 2. The host_ops->get_cd() callback isn't assigned. Thus not allowing
> the mmc core to find out whether the card is inserted or not.
>
> So instead of this quick-fix, I suggest that pxamci convert to use the
> mmc slot-gpio API, which means calling mmc_gpio[d]_request_cd() from
> ->probe() and assign the ->get_cd() callback, which use
> mmc_gpio_get_cd().
>
> What do you think?

I think you're right on both points, and that you convinced me.  I'll revamp the
patch to use the slot-gpio API, which I wasn't aware of until now, which as a
side effect will pull a bit of maintainance out of pxamci into slot-gpio, which
is good for my health.

Cheers.

--
Robert

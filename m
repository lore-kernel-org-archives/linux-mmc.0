From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v14 1/6] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Sun, 24 Aug 2014 19:46:05 +0200
Message-ID: <CALtMJEC0z2AGnO=uYxQ4_0GjU7LQNxkH7DP5+rhfr0=DNo6Wkw@mail.gmail.com>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com>
	<1401352085-22781-2-git-send-email-afenkart@gmail.com>
	<53F9A1B5.2080409@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34236 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaHXRqH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Aug 2014 13:46:07 -0400
In-Reply-To: <53F9A1B5.2080409@epfl.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

Hi Florian

2014-08-24 10:26 GMT+02:00 Florian Vaussard <florian.vaussard@epfl.ch>:
> Hi Andreas,
>
> On 05/29/2014 10:28 AM, Andreas Fenkart wrote:
>> There have been various patches floating around for enabling
>> the SDIO IRQ for hsmmc, but none of them ever got merged.
>>
>
> [...]
>
>> For now, only support SDIO interrupt if we are booted with
>> a separate wake-irq configued via device tree. This is
>> because omaps need the wake-irq for idle states, and some
>> omaps need special quirks. And we don't want to add new
>> legacy mux platform init code callbacks any longer as we
>> are moving to DT based booting anyways.
>>
>> To use it, you need to specify the wake-irq using the
>> interrupts-extended property.
>>
>
> First, thanks a lot for your tenacity on this patchset, this was a long
> needed feature. I enabled the SDIO interrupt, and got the throughput of
> my 88W8686-based chip multiplied by 15. Nice! I just have an issue with
> the wake-up path, and maybe you could help me.
>
> According to the DM3730 TRM, the MMC2 has the SWAKEUP path. So first I
> tried to give the same wake-irq as the MMC's one, but
> omap_hsmmc_configure_wake_irq() fails to request it, as they are not
> IRQF_SHARED.

Why can't it be shared?

> So I used the DAT1 for the wake-irq (see patch below), and things are
> working. But I get ~2000 wake-irq per seconds, even without any activity
> on the WiFi. As a result, the driver is ping-ponging between
> omap_hsmmc_runtime_suspend() and omap_hsmmc_runtime_resume(), causing
> kworker to eat most of my CPU.
>
> Am I missing something obvious?
>
> Thanks!
> Florian
>
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: Use mmc_can_gpio_cd() when validating for
 native hotplug
Date: Tue, 10 Jan 2017 16:09:57 +0100
Message-ID: <CAPDyKFoWN_hh0gYiqbhyrf17cAb_O+mAMSikWAN8h67Qg9+9gg@mail.gmail.com>
References: <1483097985-22446-1-git-send-email-ulf.hansson@linaro.org> <20170105115033.jperzle6iww6ecqe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38001 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762521AbdAJPKA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:10:00 -0500
Received: by mail-wm0-f54.google.com with SMTP id k184so164900707wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:09:59 -0800 (PST)
In-Reply-To: <20170105115033.jperzle6iww6ecqe@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

On 5 January 2017 at 12:50, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Dec 30, 2016 at 12:39:45PM +0100, Ulf Hansson wrote:
>> To validate whether native hotplug is intended to be used, the tmio driver
>> checks whether the GPIO isr has been successfully assigned. This isn't
>> entirely correct, as GPIO could still be used for card detect, but in a
>> polling mode.
>
> Isn't that checked with MMC_CAP_NEEDS_POLL? Could we maybe get rid of
> that then?

I am not sure it's a good idea... I had second and closer look at the
related code. Then I realized it isn't doing what we expect. Let me
elaborate more below.

>
>>
>> Therefore, let's convert to use the correct mmc interface,
>> mmc_can_gpio_cd() as it tells exactly what we need for the native hotplug
>> validation.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/host/tmio_mmc_pio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
>> index 3ca97f3..580ca9c 100644
>> --- a/drivers/mmc/host/tmio_mmc_pio.c
>> +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -1178,7 +1178,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>>       _host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>>                                 mmc->caps & MMC_CAP_NEEDS_POLL ||
>>                                 !mmc_card_is_removable(mmc) ||
>> -                               mmc->slot.cd_irq >= 0);

At this point mmc->slot.cd_irq is always == -EINVAL, which is because
mmc_gpiod_request_cd_irq() has not yet been called. The call to
mmc_gpiod_request_cd_irq() is done later in tmio_mmc_host_probe(),
either explicitly for the TMIO_MMC_USE_GPIO_CD case, or via calling
mmc_add_host().

Due to this, the check for "mmc->slot.cd_irq >= 0" is redundant and
can be removed. Allow me to re-post an updated patch, because I want
to get rid of the layering violation (the host is accessing
"slot.cd_irq").

A proper solution, requires ->native_hotplug to be properly set, which
likely need to consider that the mmc core may enable
MMC_CAP_NEEDS_POLL when mmc_gpiod_request_cd_irq() is called. Perhaps
that in combination of using mmc_can_gpio_cd() will do the trick!?

>> +                               mmc_can_gpio_cd(mmc));
>>
>>       /*
>>        * On Gen2+, eMMC with NONREMOVABLE currently fails because native
>> --
>> 1.9.1
>>

Kind regards
Uffe

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 09/22] mmc: tmio: use mmc_can_gpio_cd() instead of
 checking TMIO_MMC_USE_GPIO_CD
Date: Fri, 12 Jan 2018 13:06:55 +0900
Message-ID: <CAK7LNAQhTGc-iO4H-gZh44S6yoRHFqgWe7ppgGN9tmCUdJK9vQ@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com> <20180102125612.jebftmcs3ti7jdfj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:37940 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932860AbeALEHk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jan 2018 23:07:40 -0500
In-Reply-To: <20180102125612.jebftmcs3ti7jdfj@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

Hi Ulf,


2018-01-02 21:56 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Sat, Nov 25, 2017 at 01:24:44AM +0900, Masahiro Yamada wrote:
>> To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is set
>> by a legacy board (arch/sh/boards/mach-ecovec24).
>>
>> For DT platforms, the "cd-gpios" property is a legitimate way for that
>> in case the IP-builtin card detection can not be used for some reason.
>> mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
>> the "cd-gpios" property is specified.
>>
>> To cater to both cases, mmc_can_gpio_cd() is a correct way to check
>> which card detection logic is used.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> This patch is correct, yet needed some time for testing because it
> inverts the results for R-Car SoCs. Again, it is correct that it inverts
> it because those SoCs have GPIOs defined in their devicetrees, so they
> shouldn't be using native hotplug. Still, this meant checking that no
> regression gets introduced. Also, for R-Car Gen 2 & 3 native hotplug
> seems to work fine, so I was trying to find out why we use GPIOs here. I
> wasn't successful up to now, but since GPIOs work well, too, and seem to
> react a bit faster even, I am fine with the patch being merged.
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
>> index efffb04..610f26f 100644
>> --- a/drivers/mmc/host/tmio_mmc_core.c
>> +++ b/drivers/mmc/host/tmio_mmc_core.c
>> @@ -1232,7 +1232,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>>       }
>>       mmc->max_seg_size = mmc->max_req_size;
>>
>> -     _host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>> +     _host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
>>                                 mmc->caps & MMC_CAP_NEEDS_POLL ||
>>                                 !mmc_card_is_removable(mmc));
>>
>> --
>> 2.7.4
>>

Wolfram issued Reviewed-by.

Could you pick up this patch for -next?

-- 
Best Regards
Masahiro Yamada

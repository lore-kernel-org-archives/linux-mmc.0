From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/3] mmc: tmio: use mmc_can_gpio_cd() instead of checking TMIO_MMC_USE_GPIO_CD
Date: Tue, 21 Nov 2017 00:39:50 +0900
Message-ID: <CAK7LNARB17X701AXujOfT0kO-BouqiXxQxb2+fsJW=fw8CpejA@mail.gmail.com>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
 <1510136220-31853-3-git-send-email-yamada.masahiro@socionext.com> <20171119194719.v72z24ugpb2j2q32@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171119194719.v72z24ugpb2j2q32@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2017-11-20 4:47 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Nov 08, 2017 at 07:16:59PM +0900, Masahiro Yamada wrote:
>> To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is used
>> by a legacy board (arch/sh/boards/mach-ecovec24).
>>
>> For DT platforms, the "cd-gpios" property is a legitimate way for that
>> in case the IP-builtin card detection can not be used for some reason.
>> mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
>> the "cd-gpios" property is specified.
>
> So, it fixed the DT not recognized via TMIO_MMC_USE_GPIO_CD? Did I get
> this right?
>
>>
>> To cater to both cases, mmc_can_gpio_cd() is a correct way to check
>> which card detection logic is used.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
>> index 7c0e952..9fd0874 100644
>> --- a/drivers/mmc/host/tmio_mmc_core.c
>> +++ b/drivers/mmc/host/tmio_mmc_core.c
>> @@ -1228,7 +1228,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>>       }
>>       mmc->max_seg_size = mmc->max_req_size;
>>
>> -     _host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>> +     _host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
>>                                 mmc->caps & MMC_CAP_NEEDS_POLL ||
>>                                 !mmc_card_is_removable(mmc));
>>

I do not think I fully understand
how TMIO / Renesas platforms detect the card removal/insertion.

I see TMIO_MMC_USE_GPIO_CD only in
arch/sh/boards/mach-ecovec24/setup.c


As far as I understood, ->native_hotplug flag
decides the interrupt (TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT).

If you use GPIO, enabling such IRQs is pointless.


However, currently only GPIO is supported for CD
as I addressed:
https://patchwork.kernel.org/patch/10048239/


I am puzzled by this driver.


-- 
Best Regards
Masahiro Yamada

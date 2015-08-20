From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Thu, 20 Aug 2015 08:16:42 +0800
Message-ID: <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com> <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:34067 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbHTARD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Aug 2015 20:17:03 -0400
Received: by laba3 with SMTP id a3so12958791lab.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2015 17:17:01 -0700 (PDT)
In-Reply-To: <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

2015-08-18 1:11 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 11 August 2015 at 10:41, Barry Song <21cnbao@gmail.com> wrote:
>> From: Weijun Yang <york.yang@csr.com>
>>
>> As SD Specifications Part1 Physical Layer Specification Version
>> 3.01 says, CMD19 tuning is available for unlocked cards in transfer
>> state of 1.8V signaling mode. The small difference between v3.00
>> and 3.01 spec means that CMD19 tuning is also available for DDR50
>> mode.
>
> So what happens with cards following the 3.0 spec version, those
> doesn't need to support the tuning CMD right? Perhaps that needs to be
> addressed in this patch well!?

from HW registers of the card, we cann't know whether the HW needs
tuning. it is said 3.0.x need tuning, but 3.0 doesn't need.  @weijun,
pls fix me if i am wrong.
if so, it seems we need a static flag somewhere to indicate whether
the tuning is needed. we can't detect to find the tuning requirement.

>
> Kind regards
> Uffe
>
>>
>> Signed-off-by: Weijun Yang <york.yang@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/mmc/core/sd.c    | 1 +
>>  drivers/mmc/host/sdhci.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 4e7366a..a1ed24d 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -629,6 +629,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>>          */
>>         if (!mmc_host_is_spi(card->host) &&
>>             (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
>> +            card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
>>              card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
>>                 err = mmc_execute_tuning(card);
>>  out:
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 1dbe932..812c19b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1891,6 +1891,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                 break;
>>
>>         case MMC_TIMING_UHS_SDR104:
>> +       case MMC_TIMING_UHS_DDR50:
>>                 break;
>>
>>         case MMC_TIMING_UHS_SDR50:
>> --
>> 1.9.1
>>

-barry

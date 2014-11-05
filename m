From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH v2 2/4] mmc: core: group default initial state
Date: Wed, 5 Nov 2014 13:22:00 +0100
Message-ID: <CA+20K0AhPL7p3EUJFkJTwKqKG-qLD_6Gvm6kO228n1THY71SbQ@mail.gmail.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
	<1415113626-30187-3-git-send-email-johanru@axis.com>
	<CAPDyKFq+gvFpernvsskKEocSEx6Fb1va-CqMAPGyaLdOJ2oKFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49320 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbaKEMWI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Nov 2014 07:22:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id C18322E35A
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 13:22:06 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ghzg7bIW9vIU for <linux-mmc@vger.kernel.org>;
	Wed,  5 Nov 2014 13:22:02 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 1B6072E373
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 13:22:02 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 0126D11D9
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 13:22:02 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id E772011CD
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 13:22:01 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id E576234296
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 13:22:01 +0100 (CET)
Received: by mail-qc0-f182.google.com with SMTP id m20so399995qcx.27
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 04:22:00 -0800 (PST)
In-Reply-To: <CAPDyKFq+gvFpernvsskKEocSEx6Fb1va-CqMAPGyaLdOJ2oKFg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johanru@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

Hi Ulf,

2014-11-05 11:13 GMT+01:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 4 November 2014 16:07, Johan Rudholm <johan.rudholm@axis.com> wrote:
>> mmc_do_hw_reset, mmc_power_up and mmc_power_off all set the same
>> group of initial values, simplify by sticking them together.
>
> That's not entirely true. This patch will actually change the
> behaviour for the "ios.bus_mode", which isn't exactly what the commit
> message are telling us. See more below.
>
> I still think this patch is interesting, since apparently the value of
> "ios.bus_mode" hasn't been handled consistently. In principle I like
> the approach of this patch, but we need to make sure it's working and
> following the specs.

Thank you for pointing this out. I've double-checked the JEDEC 5.01
spec regarding the bus mode in the context of this initial state, see
below for comments.

>
> Kind regards
> Uffe
>
>>
>> Signed-off-by: Johan Rudholm <johanru@axis.com>
>> ---
>>  drivers/mmc/core/core.c |   49 +++++++++++++++++++++++------------------------
>>  drivers/mmc/core/core.h |    1 +
>>  2 files changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 5d215ee..2c39d26 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1088,6 +1088,24 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>>         mmc_host_clk_release(host);
>>  }
>>
>> +/*
>> + * Set initial state after a power cycle or a hw_reset.
>> + */
>> +void mmc_set_initial_state(struct mmc_host *host)
>> +{
>> +       if (mmc_host_is_spi(host)) {
>> +               host->ios.chip_select = MMC_CS_HIGH;
>> +               host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
>> +       } else {
>> +               host->ios.chip_select = MMC_CS_DONTCARE;
>> +               host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
>> +       }
>> +       host->ios.bus_width = MMC_BUS_WIDTH_1;
>> +       host->ios.timing = MMC_TIMING_LEGACY;
>> +
>> +       mmc_set_ios(host);
>> +}
>> +
>>  /**
>>   * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
>>   * @vdd:       voltage (mV)
>> @@ -1534,15 +1552,9 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>>         mmc_host_clk_hold(host);
>>
>>         host->ios.vdd = fls(ocr) - 1;
>> -       if (mmc_host_is_spi(host))
>> -               host->ios.chip_select = MMC_CS_HIGH;
>> -       else
>> -               host->ios.chip_select = MMC_CS_DONTCARE;
>> -       host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
>
> Earlier we used always used MMC_BUSMODE_PUSHPULL, now it will depend on "spi".

The JEDEC spec says that in device identification mode the bus should
be open-drain and not push-pull. So this way should be compliant to
the spec, right? Unfortunately, I will require help in testing this on
a proper eMMC.

I can't find anything in the JEDEC or the SD spec about bus mode in
SPI mode though. However, this behavior is not changed by this patch,
so we should be safe.

>>         host->ios.power_mode = MMC_POWER_UP;
>> -       host->ios.bus_width = MMC_BUS_WIDTH_1;
>> -       host->ios.timing = MMC_TIMING_LEGACY;
>> -       mmc_set_ios(host);
>> +       /* Set initial state and call mmc_set_ios */
>> +       mmc_set_initial_state(host);
>>
>>         /* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
>>         if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
>> @@ -1582,14 +1594,9 @@ void mmc_power_off(struct mmc_host *host)
>>         host->ios.clock = 0;
>>         host->ios.vdd = 0;
>>
>> -       if (!mmc_host_is_spi(host)) {
>> -               host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
>> -               host->ios.chip_select = MMC_CS_DONTCARE;
>
> So in here another change in behaviour, right!?

Ok, so the behavior for SPI is changed in this case, now we explicitly
set the bus+cs modes and before we left them as they were.

Does this matter though, since we're powering off the device and the
bus+cs modes will be set on the subsequent mmc_power_up?

>
>> -       }
>>         host->ios.power_mode = MMC_POWER_OFF;
>> -       host->ios.bus_width = MMC_BUS_WIDTH_1;
>> -       host->ios.timing = MMC_TIMING_LEGACY;
>> -       mmc_set_ios(host);
>> +       /* Set initial state and call mmc_set_ios */
>> +       mmc_set_initial_state(host);
>>
>>         /*
>>          * Some configurations, such as the 802.11 SDIO card in the OLPC
>> @@ -2273,16 +2280,8 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
>>                 }
>>         }
>>
>> -       if (mmc_host_is_spi(host)) {
>> -               host->ios.chip_select = MMC_CS_HIGH;
>> -               host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
>> -       } else {
>> -               host->ios.chip_select = MMC_CS_DONTCARE;
>> -               host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
>> -       }
>> -       host->ios.bus_width = MMC_BUS_WIDTH_1;
>> -       host->ios.timing = MMC_TIMING_LEGACY;
>> -       mmc_set_ios(host);
>> +       /* Set initial state and call mmc_set_ios */
>> +       mmc_set_initial_state(host);
>>
>>         mmc_host_clk_release(host);
>>
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 443a584..d76597c 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -49,6 +49,7 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
>>  void mmc_power_up(struct mmc_host *host, u32 ocr);
>>  void mmc_power_off(struct mmc_host *host);
>>  void mmc_power_cycle(struct mmc_host *host, u32 ocr);
>> +void mmc_set_initial_state(struct mmc_host *host);
>>
>>  static inline void mmc_delay(unsigned int ms)
>>  {
>> --
>> 1.7.2.5
>>
>
> Kind regards
> Uffe

//Johan

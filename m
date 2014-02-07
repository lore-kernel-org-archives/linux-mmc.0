From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: Re: [Regression: mmc: sdhci-esdhc-imx: add runtime pm support]
Date: Fri, 07 Feb 2014 10:25:19 +0100
Message-ID: <52F4A67F.1090702@parkeon.com>
References: <52F3A267.8030302@parkeon.com> <CAA+hA=Qvnm4S1tEQbfopegTeE4uHDdu9nY=fnYAYqdzPrUP8CQ@mail.gmail.com> <CAA+hA=Rk3bk3yE73+_8Hp5DEedspMPYmG3LVCDEt_wgMmqXKLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:44782 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaBGJZW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2014 04:25:22 -0500
Received: by mail-we0-f181.google.com with SMTP id w61so2075498wes.40
        for <linux-mmc@vger.kernel.org>; Fri, 07 Feb 2014 01:25:21 -0800 (PST)
In-Reply-To: <CAA+hA=Rk3bk3yE73+_8Hp5DEedspMPYmG3LVCDEt_wgMmqXKLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Dong,

thank you for your rapid response.

On 07/02/14 09:03, Dong Aisheng wrote:
> Some SDIO cards may not be able to work well without clock.
>
> Originally it is handled by the mmc clock gate framework.
> See:
> static bool mmc_host_may_gate_card(struct mmc_card *card)
> {
>          /* If there is no card we may gate it */
>          if (!card)
>                  return true;
>          /*
>           * Don't gate SDIO cards! These need to be clocked at all times
>           * since they may be independent systems generating interrupts
>           * and other events. The clock requests counter from the core will
>           * go down to zero since the core does not need it, but we will not
>           * gate the clock, because there is somebody out there that may still
>           * be using it.
>           */
>          return !(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING);
> }
> But Ulf proposed to remove clock gate framework since no one used it anymore
> and the patch was already sent in the mail list a few weeks ago.
> Then this may need to be handled by the host driver after adding rpm.
Yes indeed the above code does nothing for the rpm case and it looks 
like it's on the way out anyway.
>> Can you try the following patch to see if it works?
>>
>> commit d9d062627407f714ba326fa8dd6e8aa20199fdbe
>> Author: Dong Aisheng <b29396@freescale.com>
>> Date:   Fri Nov 15 17:54:36 2013 +0800
>>
>>      mmc: sdhci: get runtime pm when sdio irq is enabled
>>
>>      SDIO cards may need clock to send the card interrupt to host.
>>      Thus, we get runtime pm when sdio irq is enabled to prevent the clock
>>      resource is released and put it when sdio irq is disabled.
>>
>>      Signed-off-by: Dong Aisheng <b29396@freescale.com>
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 9ddef47..f892757 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1734,9 +1734,15 @@ static void sdhci_enable_sdio_irq(struct
>> mmc_host *mmc, int enable)
>>          struct sdhci_host *host = mmc_priv(mmc);
>>          unsigned long flags;
>>
>> +       if (enable)
>> +               sdhci_runtime_pm_get(host);
>> +
>>          spin_lock_irqsave(&host->lock, flags);
>>          sdhci_enable_sdio_irq_nolock(host, enable);
>>          spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +       if (!enable)
>> +               sdhci_runtime_pm_put(host);
>>   }
>>
>>   static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>>

Yes that works fine for me thank you.

What is the status of this patch?

I see you wrote it in November but I can't find it in git or on the 
mailing list anywhere

Regards,

Martin


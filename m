From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: add quirk to support shared bus controller
Date: Mon, 25 Apr 2011 11:18:06 -0700
Message-ID: <214C533D-E999-4FF2-AA99-F81526DBA529@marvell.com>
References: <BANLkTi=7h_gBQ1CGqYgUUhZabcwVuoRhCw@mail.gmail.com>
 <BANLkTincOuKrTEzP3gv-d2Vk-Cih+BS4hw@mail.gmail.com>
 <BANLkTikcxk6yt72pa6QC-unawseaOQ7Dfg@mail.gmail.com>
 <BANLkTim6V5RNtrUzz+KQiG0USW72B2xjQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47697 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757722Ab1DYSUG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Apr 2011 14:20:06 -0400
In-Reply-To: <BANLkTim6V5RNtrUzz+KQiG0USW72B2xjQQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "bin.shi@csr.com" <bin.shi@csr.com>, "Binghua.Duan@csr.com" <Binghua.Duan@csr.com>


Hi Barry,

On Apr 25, 2011, at 8:49 AM, Barry Song wrote:

> 2011/4/25 Barry Song <21cnbao@gmail.com>:
>> 2011/4/21 Andrei Warkentin <andreiw@motorola.com>:
>>> Hi,
>>> 
>>> On Thu, Apr 21, 2011 at 3:51 AM, Barry Song <21cnbao@gmail.com> wrote:
>>>> From: Bin Shi <bin.shi@csr.com>
>>>> 
>>>> some controllers share data bus or other pins between
>>>> multi-controllers and need to switch the functions of shared pins
>>>> runtime
>>>> this patch requested those shared pins before actual hardware access
>>>> and release them after access
>>>> 
>>>> Signed-off-by: Bin Shi <bin.shi@csr.com>
>>>> Cc: Binghua Duan <binghua.duan@csr.com>
>>>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c  |   13 +++++++++++++
>>>>  drivers/mmc/host/sdhci.h  |    2 ++
>>>>  include/linux/mmc/sdhci.h |    2 ++
>>>>  3 files changed, 17 insertions(+), 0 deletions(-)
>>>> 
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index f31077d..7b07152 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1379,6 +1379,13 @@ static void sdhci_tasklet_finish(unsigned long param)
>>>>                sdhci_reset(host, SDHCI_RESET_DATA);
>>>>        }
>>>> 
>>>> +       /*
>>>> +        * some controllers share data bus or other pins between multi-controller
>>>> +        * and need to switch the function of pins runtime
>>>> +        */
>>>> +       if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
>>>> +               host->ops->get_shared_pins(host);
>>>> +
>>> 
>>> Why in tasklet_finish? Why not in sdhci_request?
>> 
>> that is ok in sdhci_request
>> 
>>> No need to waste a quirk flag. Just invoke if method is not NULL.
>> 
>> i think most hardwares have no shared pins issue, it should be a quirk
>> but not a generic option for all devices.
>> 
>>> 
>>> Also, I would assume host->ops->get_shared_pins would need to
>>> synchronize with other SDHCI instances
>>> it shares the pins with. Since you do it after the host->lock (as you
>>> should), what happens if get_shared_pins needs to wait?
>> 
>> sorry, just due to my cross-eye while porting the patch from old
>> kernel to linux-mmc tree. In fact i mean:
>> 
>>        /*
>>         * some controllers share data bus or other pins between
>> multi-controller
>>         * and need to switch the function of pins runtime
>>         */
>>        if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
>>                host->ops->get_shared_pins(host);

A quirk does not seem to the right way to go since there is now 2 points of failure

a) The quirk can be defined and host->ops->get_shared_pins may not be.

how about

	if (host->ops->get_shared_pins)
		host->ops->get_shared_pins(host)

Philip


>> 
>> 
>>        mmc_request_done(host->mmc, mrq);
>> 
>>        /*
>>         * release shared pins so that other controllers can use them
>>         */
>>        if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
>>                host->ops->get_shared_pins(host);
>> 
> 
> In fact we request shared pins in sdhci_request() and release them in
> tasklet_finish. Then i'll send patch v2.
> 
>>> Can you show the rest (sdhci driver implementing these hooks)?
>> 
>> Yes. sdhci driver implement these hooks, special behavior of getting
>> shared pins depends on special hardware, for us, we just request data
>> bus mutex and set related hardware registers to switch the role of
>> shared pins.
>> 
>>> 
>>>>        host->mrq = NULL;
>>>>        host->cmd = NULL;
>>>>        host->data = NULL;
>>>> @@ -1391,6 +1398,12 @@ static void sdhci_tasklet_finish(unsigned long param)
>>>>        spin_unlock_irqrestore(&host->lock, flags);
>>>> 
>>>>        mmc_request_done(host->mmc, mrq);
>>>> +
>>>> +       /*
>>>> +        * release shared pins so that other controllers can use them
>>>> +        */
>>>> +       if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
>>>> +               host->ops->get_shared_pins(host);
>>>>  }
>>>> 
>>>>  static void sdhci_timeout_timer(unsigned long data)
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index 85750a9..9d918a5 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -229,6 +229,8 @@ struct sdhci_ops {
>>>>        void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>>>                                             u8 power_mode);
>>>>        unsigned int    (*get_ro)(struct sdhci_host *host);
>>>> +       unsigned int    (*get_shared_pins)(struct sdhci_host *host);
>>>> +       unsigned int    (*put_shared_pins)(struct sdhci_host *host);
>>>>  };
>>>> 
>>>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>>> index 83bd9f7..32ab422 100644
>>>> --- a/include/linux/mmc/sdhci.h
>>>> +++ b/include/linux/mmc/sdhci.h
>>>> @@ -85,6 +85,8 @@ struct sdhci_host {
>>>>  #define SDHCI_QUIRK_NO_HISPD_BIT                       (1<<29)
>>>>  /* Controller treats ADMA descriptors with length 0000h incorrectly */
>>>>  #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC           (1<<30)
>>>> +/* Controller shared data bus or other pins with other controllers */
>>>> +#define SDHCI_QUIRK_SHARED_PINS                         (1<<31)
>>>> 
>>>>        int irq;                /* Device IRQ */
>>>>        void __iomem *ioaddr;   /* Mapped address */
>>>> --
>>>> 1.7.1
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH 1/7] mmc: sdhci: add quirk for broken 3.0V support
Date: Sat, 21 Jun 2014 12:29:02 +0800
Message-ID: <CAOEd-H1AW9UYgtKiwrsU3Tkubinw+LbCfcKcbZwpy7vYK_xDgw@mail.gmail.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1403256928-11359-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<20140620202638.GA21349@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:56281 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaFUE3D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Jun 2014 00:29:03 -0400
Received: by mail-yh0-f45.google.com with SMTP id t59so3529529yho.32
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jun 2014 21:29:02 -0700 (PDT)
In-Reply-To: <20140620202638.GA21349@teo>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, Andy Green <andy.green@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

Hi Anton,
Thanks a lot for your review.
I will update it in next version.


Best regards,
Vincent Yang

2014-06-21 4:26 GMT+08:00 Anton Vorontsov <anton@enomsg.org>:
> On Fri, Jun 20, 2014 at 05:35:22PM +0800, Vincent Yang wrote:
>> This patch defines a quirk for platforms unable
>> to enable 3.0V support.
>> It is a preparation and will be used by Fujitsu
>> SDHCI controller f_sdh30 driver.
>>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>
> I don't think you need this patch. Instead, you can exclude 3V using the
> voltage-ranges = <> in the device tree.
>
> Thanks,
>
> Anton
>
>>  drivers/mmc/host/sdhci.c  | 3 +++
>>  include/linux/mmc/sdhci.h | 2 ++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 47055f3..523075f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3069,6 +3069,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>       }
>>  #endif /* CONFIG_REGULATOR */
>>
>> +     if (host->quirks2 & SDHCI_QUIRK2_NO_3_0_V)
>> +             caps[0] &= ~SDHCI_CAN_VDD_300;
>> +
>>       /*
>>        * According to SD Host Controller spec v3.00, if the Host System
>>        * can afford more than 150mA, Host Driver should set XPC to 1. Also
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index 08abe99..cac0958 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -98,6 +98,8 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK2_BROKEN_HS200                    (1<<6)
>>  /* Controller does not support DDR50 */
>>  #define SDHCI_QUIRK2_BROKEN_DDR50                    (1<<7)
>> +/* The system physically doesn't support 3.0v, even if the host does */
>> +#define SDHCI_QUIRK2_NO_3_0_V                                (1<<8)
>>
>>       int irq;                /* Device IRQ */
>>       void __iomem *ioaddr;   /* Mapped address */
>> --
>> 1.9.0

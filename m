From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 09/18] mmc: meson-gx: change interrupt name
Date: Wed, 15 Feb 2017 20:46:04 +0100
Message-ID: <f2784a55-a319-2aa5-6d9a-a60a1f0cad3d@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <cbe84305-803a-5431-9246-0b30d6f135b0@gmail.com>
 <7ccaed3c-199c-2897-5280-2790ce3676ea@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34707 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOTqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:46:20 -0500
Received: by mail-wr0-f193.google.com with SMTP id c4so6947939wrd.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:46:20 -0800 (PST)
In-Reply-To: <7ccaed3c-199c-2897-5280-2790ce3676ea@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 15.02.2017 um 13:34 schrieb Ben Dooks:
> On 14/02/17 20:06, Heiner Kallweit wrote:
>> So far the driver name is used for the interrupt. Therefore in
>> /proc/interrupts we can't tell which interrupt belongs to which
>> SD_EMMC port.
>> So let's use the device name instead (what is the OF node name).
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index a67c811e..1a76c925 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -757,9 +757,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>      writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
>>      writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
>>
>> -    ret = devm_request_threaded_irq(&pdev->dev, host->irq,
>> -                    meson_mmc_irq, meson_mmc_irq_thread,
>> -                    IRQF_SHARED, DRIVER_NAME, host);
>> +    ret = devm_request_threaded_irq(&pdev->dev, host->irq, meson_mmc_irq,
>> +                    meson_mmc_irq_thread, IRQF_SHARED,
>> +                    dev_name(&pdev->dev), host);
>>      if (ret)
>>          goto free_host;
>>
> 
> I am surpised that the default is not to use dev_name(dev), I wonder if
> that should be something that devm_request_threaded_irq() could be
> updated to do.
> 
I asked myself the same question and submitted a patch:
https://lkml.org/lkml/2017/2/12/80

> 


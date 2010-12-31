From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3] mmc: davinci: add support for SDIO irq handling
Date: Fri, 31 Dec 2010 18:51:12 +0300
Message-ID: <4D1DFBF0.5030607@mvista.com>
References: <1293706357-21358-1-git-send-email-nsekhar@ti.com> <4D1C7E19.7050605@mvista.com> <B85A65D85D7EB246BE421B3FB0FBB593024806DF98@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48478 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab0LaPwS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Dec 2010 10:52:18 -0500
Received: by ewy5 with SMTP id 5so5447021ewy.19
        for <linux-mmc@vger.kernel.org>; Fri, 31 Dec 2010 07:52:17 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024806DF98@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Chris Ball <cjb@laptop.org>

Hello.

On 31-12-2010 8:45, Nori, Sekhar wrote:

>>> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
>>> index b643dde..04c2fa4 100644
>>> --- a/drivers/mmc/host/davinci_mmc.c
>>> +++ b/drivers/mmc/host/davinci_mmc.c
>> [...]
>>> @@ -1209,7 +1267,8 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>>>    		host->nr_sg = MAX_NR_SG;
>>>
>>>    	host->use_dma = use_dma;
>>> -	host->irq = irq;
>>> +	host->mmc_irq = irq;
>>> +	host->sdio_irq = platform_get_irq(pdev, 1);
>>>
>>>    	if (host->use_dma&&   davinci_acquire_dma_channels(host) != 0)
>>>    		host->use_dma = 0;
>>> @@ -1270,6 +1329,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>>>    	if (ret)
>>>    		goto out;
>>>
>>> +	if (host->sdio_irq != NO_IRQ) {

>>      Note that platform_get_irq() will return -EXDEV if the resource is not
>> present. Perhaps you should check for it...

> I checked and got back -ENXIO.

    Yes, sorry -- I've mixed them up.

> arch/arm/include/asm/irq.h suggests NO_IRQ
> as the return value. I guess I will just settle for "host->sdio_irq >= 0"
> to check for a valid IRQ number passed.

    Right.

> Thanks,
> Sekhar

WBR, Sergei

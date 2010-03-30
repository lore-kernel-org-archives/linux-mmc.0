From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH]omap hsmmc: fix incorrect capability reporting
Date: Tue, 30 Mar 2010 13:29:30 -0500
Message-ID: <4BB2430A.80701@ti.com>
References: <618f0c911003300737w5562c18as1bfcb21671919718@mail.gmail.com>	 <002a01cad020$47be5fb0$544ff780@am.dhcp.ti.com> <618f0c911003301111r3781661asa444dd35042772c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54975 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab0C3S3d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Mar 2010 14:29:33 -0400
In-Reply-To: <618f0c911003301111r3781661asa444dd35042772c3@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

S, Venkatraman had written, on 03/30/2010 01:11 PM, the following:
[..]
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 83f0aff..dbf83a6 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -2093,7 +2093,7 @@ static int __init omap_hsmmc_probe(struct
>>> platform_device *pdev)
>>>
>>>       if (mmc_slot(host).wires >= 8)
>>>               mmc->caps |= MMC_CAP_8_BIT_DATA;
>>> -     else if (mmc_slot(host).wires >= 4)
>>> +     if (mmc_slot(host).wires >= 4)
>>>               mmc->caps |= MMC_CAP_4_BIT_DATA;
>>>
>> Since 8-bit is the max how about:
>>
>>        if (mmc_slot(host).wires == 8)
>>                mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
>>        if (mmc_slot(host).wires == 4)
>>                mmc->caps |= MMC_CAP_4_BIT_DATA;
>>
>> This would be little easy to read the code.
> 
> Sure. Works for me.
nitpicky comment: might be better off using a 
switch(mmc_slot(host).wires) statement instead of using == if that is 
the intention here..

-- 
Regards,
Nishanth Menon

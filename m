From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from
 DT node
Date: Fri, 12 Oct 2012 17:14:53 +0200
Message-ID: <507833ED.8060903@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-2-git-send-email-zonque@gmail.com> <5078295E.2090803@gmail.com> <50782F82.8060206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53414 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759209Ab2JLPO5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 11:14:57 -0400
In-Reply-To: <50782F82.8060206@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org

On 12.10.2012 16:56, Balaji T K wrote:
> On Friday 12 October 2012 07:59 PM, Daniel Mack wrote:
>> On 12.10.2012 12:58, Daniel Mack wrote:
>>> When probed from DT, the self-allocated platform data has to be attached
>>> to the actual device. Otherwise a NULL pointer will be dereferenced from
>>> omap_hsmmc_card_detect if a gpio handle for card-detect has been passed.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Cc: Venkatraman S <svenkatr@ti.com>
>>> Cc: Chris Ball <cjb@laptop.org>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>> Cc: linux-omap@vger.kernel.org
>>> ---
>>>   drivers/mmc/host/omap_hsmmc.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 19ccb59..4b70823 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -1728,6 +1728,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>>>   			const u16 *offsetp = match->data;
>>>   			pdata->reg_offset = *offsetp;
>>>   		}
>>> +		pdev->dev.platform_data = pdata;
>>>   	}
>>>
>>>   	if (pdata == NULL) {
>>>
>>
>> FWIW, this is the Oops I see without this patch:
> Hi,
> Shouldn't pdev->dev.platform_data be set to NULL on _remove ?

Why?

> BTW, I posted a patch for the same by accessing saved version from 
> host->pdata
> http://permalink.gmane.org/gmane.linux.kernel.mmc/16996

Ok, that's another solution. I thought about this too, but then chose
the easier way :) I don't care which patch is taken, as long as we have
a fix in mainline.


Thanks,
Daniel


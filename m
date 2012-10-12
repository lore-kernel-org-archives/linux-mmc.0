From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from
 DT node
Date: Fri, 12 Oct 2012 20:53:21 +0530
Message-ID: <507835E9.9020200@ti.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-2-git-send-email-zonque@gmail.com> <5078295E.2090803@gmail.com> <50782F82.8060206@ti.com> <507833ED.8060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756485Ab2JLPXc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Oct 2012 11:23:32 -0400
In-Reply-To: <507833ED.8060903@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org

On Friday 12 October 2012 08:44 PM, Daniel Mack wrote:
> On 12.10.2012 16:56, Balaji T K wrote:
>> On Friday 12 October 2012 07:59 PM, Daniel Mack wrote:
>>> On 12.10.2012 12:58, Daniel Mack wrote:
>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>>> index 19ccb59..4b70823 100644
>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>> @@ -1728,6 +1728,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>>>>    			const u16 *offsetp = match->data;
>>>>    			pdata->reg_offset = *offsetp;
>>>>    		}
>>>> +		pdev->dev.platform_data = pdata;
>>>>    	}
>>>>
>>>>    	if (pdata == NULL) {
>>>>
>>>
>>> FWIW, this is the Oops I see without this patch:
>> Hi,
>> Shouldn't pdev->dev.platform_data be set to NULL on _remove ?
>
> Why?

To make sure on second insmod it is NULL, When built as module,
So that of_get_hsmmc_pdata is called to create pdata.

>
>> BTW, I posted a patch for the same by accessing saved version from
>> host->pdata
>> http://permalink.gmane.org/gmane.linux.kernel.mmc/16996
>
> Ok, that's another solution. I thought about this too, but then chose
> the easier way :) I don't care which patch is taken, as long as we have
> a fix in mainline.
>

Agree this patch is easiest :-)

>
> Thanks,
> Daniel
>

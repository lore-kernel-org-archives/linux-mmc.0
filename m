From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from DT node
Date: Sat, 13 Oct 2012 01:05:01 +0100
Message-ID: <ae718323-6d65-4e69-b8f9-6382c6299294@email.android.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-2-git-send-email-zonque@gmail.com> <5078295E.2090803@gmail.com> <50782F82.8060206@ti.com> <507833ED.8060903@gmail.com> <507835E9.9020200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52628 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab2JMAFL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 20:05:11 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so59207wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Oct 2012 17:05:09 -0700 (PDT)
In-Reply-To: <507835E9.9020200@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org



Balaji T K <balajitk@ti.com> wrote:

>On Friday 12 October 2012 08:44 PM, Daniel Mack wrote:
>> On 12.10.2012 16:56, Balaji T K wrote:
>>> On Friday 12 October 2012 07:59 PM, Daniel Mack wrote:
>>>> On 12.10.2012 12:58, Daniel Mack wrote:
>>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>b/drivers/mmc/host/omap_hsmmc.c
>>>>> index 19ccb59..4b70823 100644
>>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>>> @@ -1728,6 +1728,7 @@ static int __devinit omap_hsmmc_probe(struct
>platform_device *pdev)
>>>>>    			const u16 *offsetp = match->data;
>>>>>    			pdata->reg_offset = *offsetp;
>>>>>    		}
>>>>> +		pdev->dev.platform_data = pdata;
>>>>>    	}
>>>>>
>>>>>    	if (pdata == NULL) {
>>>>>
>>>>
>>>> FWIW, this is the Oops I see without this patch:
>>> Hi,
>>> Shouldn't pdev->dev.platform_data be set to NULL on _remove ?
>>
>> Why?
>
>To make sure on second insmod it is NULL, When built as module,
>So that of_get_hsmmc_pdata is called to create pdata.

Actually the driver should *never* modify the value of dev->platform_data. Ever. Make a copy instead.

g.

-- 
Grant Likely, P.Eng.
Secret Lab Technologies Ltd.

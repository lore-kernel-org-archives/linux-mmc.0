From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from
 DT node
Date: Sat, 13 Oct 2012 10:05:52 +0200
Message-ID: <507920E0.2050104@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-2-git-send-email-zonque@gmail.com> <5078295E.2090803@gmail.com> <50782F82.8060206@ti.com> <507833ED.8060903@gmail.com> <507835E9.9020200@ti.com> <ae718323-6d65-4e69-b8f9-6382c6299294@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <ae718323-6d65-4e69-b8f9-6382c6299294@email.android.com>
Sender: linux-omap-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Grant,

On 13.10.2012 02:05, Grant Likely wrote:
> 
> 
> Balaji T K <balajitk@ti.com> wrote:
> 
>> On Friday 12 October 2012 08:44 PM, Daniel Mack wrote:
>>> On 12.10.2012 16:56, Balaji T K wrote:
>>>> On Friday 12 October 2012 07:59 PM, Daniel Mack wrote:
>>>>> On 12.10.2012 12:58, Daniel Mack wrote:
>>>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>> b/drivers/mmc/host/omap_hsmmc.c
>>>>>> index 19ccb59..4b70823 100644 ---
>>>>>> a/drivers/mmc/host/omap_hsmmc.c +++
>>>>>> b/drivers/mmc/host/omap_hsmmc.c @@ -1728,6 +1728,7 @@
>>>>>> static int __devinit omap_hsmmc_probe(struct
>> platform_device *pdev)
>>>>>> const u16 *offsetp = match->data; pdata->reg_offset =
>>>>>> *offsetp; } +		pdev->dev.platform_data = pdata; }
>>>>>> 
>>>>>> if (pdata == NULL) {
>>>>>> 
>>>>> 
>>>>> FWIW, this is the Oops I see without this patch:
>>>> Hi, Shouldn't pdev->dev.platform_data be set to NULL on _remove
>>>> ?
>>> 
>>> Why?
>> 
>> To make sure on second insmod it is NULL, When built as module, So
>> that of_get_hsmmc_pdata is called to create pdata.
> 
> Actually the driver should *never* modify the value of
> dev->platform_data. Ever.

That's interesting, because many drivers do this, especially since they
were converted to DT probing. Mostly because that way, the platform data
logic in callback functions can be reused, and often the platform
specific data is only stored in pdata and taken from there during the
lifetime of a device.

Is there any particular reason why this approach is frowned upon?

> Make a copy instead.

A copy of what exactly? Of all members of the legacy pdata you mean?


Thanks,
Daniel


From: Balaji T K <balajitk@ti.com>
Subject: Re: [patch] mmc: omap_hsmmc: precedence bug in omap_hsmmc_context_restore()
Date: Thu, 30 Jan 2014 18:34:15 +0530
Message-ID: <52EA4DCF.6090408@ti.com>
References: <20130822125613.GB2543@elgon.mountain> <52162444.1050908@ti.com> <20140130121526.GO4815@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20140130121526.GO4815@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 30 January 2014 05:45 PM, Dan Carpenter wrote:
> On Thu, Aug 22, 2013 at 08:16:28PM +0530, Balaji T K wrote:
>> On Thursday 22 August 2013 06:26 PM, Dan Carpenter wrote:
>>> '!' has higher precedence than '&' so this doesn't work as intended
>>> although since RESETDONE is 1 it would work if none of the other bits
>>> are set.
>>>
>> Hi Dan,
>>
>> Thanks for the patch, Indeed other bits are reserved.
>> however ...
>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> Untested.
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 1865321..7346b15 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -612,7 +612,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>>>   	if (host->context_loss == context_loss)
>>>   		return 1;
>>>
>>> -	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
>>> +	if (!(OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE))
>>>   		return 1;
>>
>> This check is unnecessary, will send a patch to remove this.
>
> What happened with this?

My bad, I missed it, will fix it.

Thanks and Regards,
Balaji T K

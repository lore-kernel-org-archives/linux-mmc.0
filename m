From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] omap_hsmmc: Reduce max_segs
Date: Thu, 22 Jun 2017 11:57:00 +0530
Message-ID: <262aa84b-9780-c4f1-467c-99009cd83c11@ti.com>
References: <20170619093644.16054-1-willn@resin.io>
 <CAFbHwiSuAAophPr2tyHOq2iWrC1Uo2N+EOuvhiNcc9xERuvZZA@mail.gmail.com>
 <20170621062427.GP3730@atomide.com>
 <CAFbHwiQO5dHq59Bab4+9A6-QVcjsTVMzNfni0PQDQA1g3YCcgw@mail.gmail.com>
 <20170621083252.GQ3730@atomide.com>
 <ec8e0bbd-e278-3067-6340-f7b3db293b05@ti.com>
 <CAFbHwiRRAdmJ6OL2u32dcYwiS-5jgmqgT9mgnf3FLkyco2A-5Q@mail.gmail.com>
 <17b9488d-f621-3ce1-4ded-547264b3fde8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:32230 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdFVG1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2017 02:27:07 -0400
In-Reply-To: <17b9488d-f621-3ce1-4ded-547264b3fde8@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ravikumar <rk@ti.com>, Will Newton <will.newton@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>



On Thursday 22 June 2017 11:11 AM, Ravikumar wrote:
> 
> 
> On Wednesday 21 June 2017 08:39 PM, Will Newton wrote:
>> On Wed, Jun 21, 2017 at 10:16 AM, Ravikumar <rk@ti.com> wrote:
>>
>> Hi Ravikumar,
>>
>>> On Wednesday 21 June 2017 02:02 PM, Tony Lindgren wrote:
>>>> * Will Newton <will.newton@gmail.com> [170621 01:18]:
>>>>> On Wed, Jun 21, 2017 at 7:24 AM, Tony Lindgren <tony@atomide.com> wrote:
>>>>>
>>>>> Hi Tony,
>>>>>
>>>>>> * Will Newton <will.newton@gmail.com> [170620 05:39]:
>>>>>>> Just adding a few people to CC. I'd love to get some feedback as to
>>>>>>> whether this patch makes sense or not.
>>>>>>>
>>>>>>> On Mon, Jun 19, 2017 at 10:36 AM, Will Newton <will.newton@gmail.com>
>>>>>>> wrote:
>>>>>>>> Reduce max_segs to a value that allows allocation of an entire
>>>>>>>> descriptor list within a single page. This avoids doing a
>>>>>>>> higher order GFP_ATOMIC allocation when setting up a transfer
>>>>>>>> which can potentially fail and lead to I/O failures.
>>>>>> I recall we only ever have few SG entries so if there is no performance
>>>>>> impact I see no reason to lower it to save memory. Care to check
>>>>>> if that's the case still?
>>>>> I have been seeing allocation failures in edma_prep_slave_sg
>>>>> allocating the descriptor list of order 3, which from my rough
>>>>> calculations is an sg_len of ~800. The memory usage itself doesn't
>>>>> seem like a problem but doing a GFP_ATOMIC allocation of higher order
>>>>> under I/O load seems like it is always going to cause problems.
>>> max_segs= 64  looks like a sensible value to me for edma/sdma, with each
>>> param set ~40Bytes - this will ensure to fit in a single page.
>>> IIRC, edma splits the list at 20. MAX_NR_SEGS set to 20 in edma.c. So,
>>> having a bigger number *may not* guarantee a proportional increase
>>> in throughput.
>>>
>>>> OK
>>>>
>>>>> I'm not an expert on this code but it looks like the scatterlist is
>>>>> created from the queue so if the queue gets full we can get a very
>>>>> large scatterlist. The current value of 1024 seems to be something of
>>>>> an outlier:
>>> When using ADMA, since you allocate the table only once during probe,
>>> there'll be no alloc calls at a later time.
>>> And increase in number of sg entries would increase efficiency. I've seen
>>> as many as 290-300 sg entries being used during file-system init/mount. So,
>>> for ADMA, I would say at least max_segs = 512 is a better option since
>>> descriptor size is 8B,
>>> would still fit in a page.
>>> You can over-wirte it under  "if (host->adma)"
>> I can't find this member in struct mmc_host on master, is there
>> somewhere else I should be looking?
> The exact member is "host->use_adma".

ADMA support patch is not yet merged.
https://patchwork.kernel.org/patch/9791407/

-Kishon

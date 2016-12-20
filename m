From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: sd: Meet alignment requirements for raw_ssr DMA
Date: Tue, 20 Dec 2016 21:54:59 +0100
Message-ID: <5d4329b6-841b-a6e6-f819-b14348bb5ac7@metafoo.de>
References: <20161111142236.8270-1-paul.burton@imgtec.com>
 <CAPDyKFqNNP-M37_ieq2na0agsQvh8oyv=nWdSsW2nQDw+zB9WA@mail.gmail.com>
 <3676563.EjIzX52DqA@np-p-burton>
 <CAPDyKFqehff8FZEcom3QzVy=Yu_H3Pd4Z0excgAsw=YgvcQo1Q@mail.gmail.com>
 <ebe3c261-a1f2-3188-7d36-a85916797bb3@metafoo.de>
 <CAPDyKFprZQ1pCQ+8bRXMi1ArD_VJAhBMGd9=hRRwegXf3PxmyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:43173 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757496AbcLTU4M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 15:56:12 -0500
In-Reply-To: <CAPDyKFprZQ1pCQ+8bRXMi1ArD_VJAhBMGd9=hRRwegXf3PxmyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Paul Burton <paul.burton@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Maarten ter Huurne <maarten@treewalker.org>

On 12/20/2016 09:41 PM, Ulf Hansson wrote:
> [...]
> 
>>>>>> +       raw_ssr = kmalloc(sizeof(card->raw_ssr), GFP_KERNEL);
>>>>>> +       if (!raw_ssr)
>>>>>> +               return -ENOMEM;
>>>>>> +
>>>
>>> Creating this bounce buffer does of course comes with a small cost.
>>> Maybe we could neglect its impact!?
>>>
>>> However we could also make the card->raw_ssr be cacheline aligned, via
>>> using the __cacheline_aligned attribute for it.
>>>
>>> Also, this isn't the only case when the mmc core creates bounce
>>> buffers while reading card registers during the card initialization.
>>>
>>> Perhaps a better method is to use the __cacheline_aligned for these
>>> buffers that needs to be DMA-able (requests which is
>>> MMC_DATA_READ|WRITE)). Of course that change would affect/increase the
>>> number of bytes allocated for each card struct (due to padding), but
>>> since this is just a single struct being allocated per card, this
>>> shouldn't be an issue.
>>>
>>> What do you think?
>>
>> The issue is now in v4.9 and is causing problems on some platforms with the
>> reported card name becoming corrupted (since it cid.prodname is on the same
>> cacheline).
>>
>> I'd say go with the simple solution for the fix, which is using the bounce
>> buffer. If somebody wants to rework this (and all the other bounce buffers)
>> to use __cacheline_aligned or something else that can be done as a separate
>> patch series on top of this.
>>
>> When you apply the patch can you add
>>
>> Fixes: 5275a652d296 ("mmc: sd: Export SD Status via “ssr” device attribute")
> 
> Ahh, I didn't realize this was a fix for a regression. I thought it
> was a long outstanding issue that more or less never occurred.
> 
>>
>> and tag it for stable?
> 
> Yes, of course. I will deal with it as of tomorrow morning. Thanks for
> pinging me on this!

Thanks for the quick reply!


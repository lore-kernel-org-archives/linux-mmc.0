From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: sd: Meet alignment requirements for raw_ssr DMA
Date: Tue, 20 Dec 2016 19:45:18 +0100
Message-ID: <ebe3c261-a1f2-3188-7d36-a85916797bb3@metafoo.de>
References: <20161111142236.8270-1-paul.burton@imgtec.com>
 <CAPDyKFqNNP-M37_ieq2na0agsQvh8oyv=nWdSsW2nQDw+zB9WA@mail.gmail.com>
 <3676563.EjIzX52DqA@np-p-burton>
 <CAPDyKFqehff8FZEcom3QzVy=Yu_H3Pd4Z0excgAsw=YgvcQo1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:56438 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758220AbcLTSpZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 13:45:25 -0500
In-Reply-To: <CAPDyKFqehff8FZEcom3QzVy=Yu_H3Pd4Z0excgAsw=YgvcQo1Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Maarten ter Huurne <maarten@treewalker.org>

On 11/23/2016 01:36 PM, Ulf Hansson wrote:
> [...]
> 
>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>> index 73c762a..f6f40a1 100644
>>>> --- a/drivers/mmc/core/sd.c
>>>> +++ b/drivers/mmc/core/sd.c
>>>> @@ -223,6 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>>>>
>>>>  static int mmc_read_ssr(struct mmc_card *card)
>>>>  {
>>>>
>>>>         unsigned int au, es, et, eo;
>>>>
>>>> +       u32 *raw_ssr;
>>>>
>>>>         int i;
>>>>
>>>>         if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
>>>>
>>>> @@ -231,14 +232,21 @@ static int mmc_read_ssr(struct mmc_card *card)
>>>>
>>>>                 return 0;
>>>>
>>>>         }
>>>>
>>>> -       if (mmc_app_sd_status(card, card->raw_ssr)) {
>>>
>>> So the struct mmc_card, which contains "u32 raw_ssr[16]", is already
>>> allocated via using a kzalloc().
>>> As kzalloc() returns a physically contiguous allocated memory, using
>>> DMA for reading the data into the memory pointed to by card->raw_ssr
>>> should be safe.
>>>
>>> Unless I am missing something, of course.
>>
>> Sadly you are. This is incorrect because the raw_ssr field of struct mmc_card
>> may not begin or end at a cache-line boundary. On systems where mapping a
>> buffer for DMA requires cache invalidation we may therefore lose data if it
>> shares a cache line with some other data. In this case let's say we have
> 
> Yes, of course - you are right! Apologize for my ignorance!
> 
>> something like this:
>>
>> 0x1000: u32 raw_scr[2];
>> 0x1008: u32 raw_ssr[16];
>>
>> Now let's say we have 16 byte cache lines and we try to map raw_ssr for DMA.
>> If the architecture requires that we invalidate the memory being mapped in
>> caches (in order to avoid any writebacks clobbering the DMA'd data) then we
>> have a problem because our choice is either to:
>>
>> - Writeback the line that overlaps with raw_scr, then invalidate it along with
>>   the rest of the cache lines covering raw_ssr. This won't do because there's
>>   nothing stopping us from pulling the line back into the cache whilst the DMA
>>   occurs on some systems - say we access raw_scr whilst the DMA to raw_ssr
>>   happens or the CPU just speculatively prefetches something. The DMA API
>>   cannot detect the former & would have no way to deal with it if it could,
>>   and on systems where the latter is possible we have no choice but to
>>   invalidate the cache lines again after the DMA is complete. What would we do
>>   with the first line then? We can't write it back to preserve raw_scr because
>>   it includes some potentially stale copy of the start of raw_ssr, which we
>>   would then clobber the DMA'd data with.
>>
>> - Or, we just invalidate the line which overlaps with raw_scr. We can't do
>>   this because we might throw away some part of raw_scr.
>>
>> So we have no choice but to align the buffers used for DMA at a cache line
>> boundary. This is what the paragraph in Documentation/DMA-API.txt is about &
>> the MMC code currently fails to meet the requirements it sets out. Allocating
>> the buffer to be DMA'd to with kmalloc will meet that alignment requirement.
>> One possible alternative would be to ensure that the raw_ssr field of struct
>> mmc_card is always aligned at an ARCH_DMA_MINALIGN boundary within the struct,
>> with nothing after it until another ARCH_DMA_MINALIGN boundary. That seems
>> like it'd be a bit messy though, and probably easy for someone to break.
>>
>> Of course when a system has DMA that is coherent with caches there's generally
>> no need to worry about any of this, but users of the DMA API generally can't
>> rely on that, again as Documentation/DMA-API.txt says. Any buffers mapped for
>> DMA should be ensured to be cache-line aligned at minimum giving the
>> architecture code backing the DMA API a chance to do the right thing for the
>> given system.
> 
> Thanks a lot for providing this detailed description to the problem.
> It really helped to refresh my mind for how this works!
> 
>>
>> Thanks,
>>     Paul
>>
>>>
>>>> +       raw_ssr = kmalloc(sizeof(card->raw_ssr), GFP_KERNEL);
>>>> +       if (!raw_ssr)
>>>> +               return -ENOMEM;
>>>> +
> 
> Creating this bounce buffer does of course comes with a small cost.
> Maybe we could neglect its impact!?
> 
> However we could also make the card->raw_ssr be cacheline aligned, via
> using the __cacheline_aligned attribute for it.
> 
> Also, this isn't the only case when the mmc core creates bounce
> buffers while reading card registers during the card initialization.
> 
> Perhaps a better method is to use the __cacheline_aligned for these
> buffers that needs to be DMA-able (requests which is
> MMC_DATA_READ|WRITE)). Of course that change would affect/increase the
> number of bytes allocated for each card struct (due to padding), but
> since this is just a single struct being allocated per card, this
> shouldn't be an issue.
> 
> What do you think?

The issue is now in v4.9 and is causing problems on some platforms with the
reported card name becoming corrupted (since it cid.prodname is on the same
cacheline).

I'd say go with the simple solution for the fix, which is using the bounce
buffer. If somebody wants to rework this (and all the other bounce buffers)
to use __cacheline_aligned or something else that can be done as a separate
patch series on top of this.

When you apply the patch can you add

Fixes: 5275a652d296 ("mmc: sd: Export SD Status via “ssr” device attribute")

and tag it for stable?

Thanks,
- Lars

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sd: Meet alignment requirements for raw_ssr DMA
Date: Wed, 23 Nov 2016 13:36:34 +0100
Message-ID: <CAPDyKFqehff8FZEcom3QzVy=Yu_H3Pd4Z0excgAsw=YgvcQo1Q@mail.gmail.com>
References: <20161111142236.8270-1-paul.burton@imgtec.com> <CAPDyKFqNNP-M37_ieq2na0agsQvh8oyv=nWdSsW2nQDw+zB9WA@mail.gmail.com>
 <3676563.EjIzX52DqA@np-p-burton>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34961 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934685AbcKWMgs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 07:36:48 -0500
Received: by mail-wm0-f52.google.com with SMTP id a197so76013589wmd.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2016 04:36:36 -0800 (PST)
In-Reply-To: <3676563.EjIzX52DqA@np-p-burton>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

[...]

>> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> > index 73c762a..f6f40a1 100644
>> > --- a/drivers/mmc/core/sd.c
>> > +++ b/drivers/mmc/core/sd.c
>> > @@ -223,6 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>> >
>> >  static int mmc_read_ssr(struct mmc_card *card)
>> >  {
>> >
>> >         unsigned int au, es, et, eo;
>> >
>> > +       u32 *raw_ssr;
>> >
>> >         int i;
>> >
>> >         if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
>> >
>> > @@ -231,14 +232,21 @@ static int mmc_read_ssr(struct mmc_card *card)
>> >
>> >                 return 0;
>> >
>> >         }
>> >
>> > -       if (mmc_app_sd_status(card, card->raw_ssr)) {
>>
>> So the struct mmc_card, which contains "u32 raw_ssr[16]", is already
>> allocated via using a kzalloc().
>> As kzalloc() returns a physically contiguous allocated memory, using
>> DMA for reading the data into the memory pointed to by card->raw_ssr
>> should be safe.
>>
>> Unless I am missing something, of course.
>
> Sadly you are. This is incorrect because the raw_ssr field of struct mmc_card
> may not begin or end at a cache-line boundary. On systems where mapping a
> buffer for DMA requires cache invalidation we may therefore lose data if it
> shares a cache line with some other data. In this case let's say we have

Yes, of course - you are right! Apologize for my ignorance!

> something like this:
>
> 0x1000: u32 raw_scr[2];
> 0x1008: u32 raw_ssr[16];
>
> Now let's say we have 16 byte cache lines and we try to map raw_ssr for DMA.
> If the architecture requires that we invalidate the memory being mapped in
> caches (in order to avoid any writebacks clobbering the DMA'd data) then we
> have a problem because our choice is either to:
>
> - Writeback the line that overlaps with raw_scr, then invalidate it along with
>   the rest of the cache lines covering raw_ssr. This won't do because there's
>   nothing stopping us from pulling the line back into the cache whilst the DMA
>   occurs on some systems - say we access raw_scr whilst the DMA to raw_ssr
>   happens or the CPU just speculatively prefetches something. The DMA API
>   cannot detect the former & would have no way to deal with it if it could,
>   and on systems where the latter is possible we have no choice but to
>   invalidate the cache lines again after the DMA is complete. What would we do
>   with the first line then? We can't write it back to preserve raw_scr because
>   it includes some potentially stale copy of the start of raw_ssr, which we
>   would then clobber the DMA'd data with.
>
> - Or, we just invalidate the line which overlaps with raw_scr. We can't do
>   this because we might throw away some part of raw_scr.
>
> So we have no choice but to align the buffers used for DMA at a cache line
> boundary. This is what the paragraph in Documentation/DMA-API.txt is about &
> the MMC code currently fails to meet the requirements it sets out. Allocating
> the buffer to be DMA'd to with kmalloc will meet that alignment requirement.
> One possible alternative would be to ensure that the raw_ssr field of struct
> mmc_card is always aligned at an ARCH_DMA_MINALIGN boundary within the struct,
> with nothing after it until another ARCH_DMA_MINALIGN boundary. That seems
> like it'd be a bit messy though, and probably easy for someone to break.
>
> Of course when a system has DMA that is coherent with caches there's generally
> no need to worry about any of this, but users of the DMA API generally can't
> rely on that, again as Documentation/DMA-API.txt says. Any buffers mapped for
> DMA should be ensured to be cache-line aligned at minimum giving the
> architecture code backing the DMA API a chance to do the right thing for the
> given system.

Thanks a lot for providing this detailed description to the problem.
It really helped to refresh my mind for how this works!

>
> Thanks,
>     Paul
>
>>
>> > +       raw_ssr = kmalloc(sizeof(card->raw_ssr), GFP_KERNEL);
>> > +       if (!raw_ssr)
>> > +               return -ENOMEM;
>> > +

Creating this bounce buffer does of course comes with a small cost.
Maybe we could neglect its impact!?

However we could also make the card->raw_ssr be cacheline aligned, via
using the __cacheline_aligned attribute for it.

Also, this isn't the only case when the mmc core creates bounce
buffers while reading card registers during the card initialization.

Perhaps a better method is to use the __cacheline_aligned for these
buffers that needs to be DMA-able (requests which is
MMC_DATA_READ|WRITE)). Of course that change would affect/increase the
number of bytes allocated for each card struct (due to padding), but
since this is just a single struct being allocated per card, this
shouldn't be an issue.

What do you think?

>> > +       if (mmc_app_sd_status(card, raw_ssr)) {
>> >
>> >                 pr_warn("%s: problem reading SD Status register\n",
>> >
>> >                         mmc_hostname(card->host));
>> >
>> > +               kfree(raw_ssr);
>> >
>> >                 return 0;
>> >
>> >         }
>> >
>> >         for (i = 0; i < 16; i++)
>> >
>> > -               card->raw_ssr[i] = be32_to_cpu(card->raw_ssr[i]);
>> > +               card->raw_ssr[i] = be32_to_cpu(raw_ssr[i]);
>> > +
>> > +       kfree(raw_ssr);
>> >
>> >         /*
>> >
>> >          * UNSTUFF_BITS only works with four u32s so we have to offset the
>> >
>> > --
>> > 2.10.2
>>

Kind regards
Uffe

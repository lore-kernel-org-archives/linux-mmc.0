From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Thu, 19 Dec 2013 12:08:10 -0700
Message-ID: <52B3441A.6080006@wwwdotorg.org>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org> <CAA+hA=StHAna46_356Gfpaa+4Y3yt6KO15W6E7dS8uoz8TPqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAA+hA=StHAna46_356Gfpaa+4Y3yt6KO15W6E7dS8uoz8TPqxg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12/19/2013 01:39 AM, Dong Aisheng wrote:
> On Thu, Dec 19, 2013 at 6:27 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> In mmc_do_calc_max_discard(), if only a single erase block can be
>> discarded within the host controller's timeout, don't allow discard
>> operations at all.
>>
>> Previously, the code allowed sector-at-a-time discard (rather than
>> erase-block-at-a-time), which was chronically slow.
>>
>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>> in qty == 1, which is immediately returned. This causes discard to
>> operate a single sector at a time, which is chronically slow. With this
>> patch in place, discard operates a single erase block at a time, which
>> is reasonably fast.
>>
>> Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
>> Fixes: e056a1b5b67b "(mmc: queue: let host controllers specify maximum discard timeout")
>> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/mmc/core/core.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 57a2b403bf8e..eb952ca634ea 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2150,8 +2150,25 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>>         if (!qty)
>>                 return 0;
>>
>> -       if (qty == 1)
>> -               return 1;
>> +       /*
>> +        * Discard operations may not be aligned to an erase block. In an
>> +        * unaligned case, we need to issue 1 more discard operation to HW
>> +        * than strictly calculated by:
>> +        *     sectors_to_erase / sectors_per_discard_operation
>> +        *
>> +        * To account for this in the timeout calculations, we assume we can
>> +        * actually discard one less erase block than fits into the HW
>> +        * timeout. This explains the --qty below.
>> +        *
>> +        * When only a single discard block operation fits into the timeout,
>> +        * disallow any discard operations at all. For example, discarding one
>> +        * sector at a time is so chronically slow as to be useless. However,
>> +        * make an exception for SD cards without an erase shift, since qty
>> +        * isn't multiplied up by an erase block size in the code below for
>> +        * that case.
>> +        */
>> +       if (qty == 1 && !(!card->erase_shift && mmc_card_sd(card)))
>> +               return 0;
>>
> 
> How about when qty == 2?
> Erase 2 sectors may have no much difference from 1 sector per one time
> for a SD card,
> it may still chronically slow, i guess.
> So i wonder it may not sovle the issues totally.

When qty==2, the number of sectors gets multiplied by the number of
sectors in an erase block, so it isn't chronically slow. It's only slow
with qty==1 because without this patch, the multiplication gets skipped
and "1" returned rather then "1 << card->erase_shift".

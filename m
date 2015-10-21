From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Wed, 21 Oct 2015 11:00:57 +0200
Message-ID: <CAPDyKFpXtio5m6V1M5QQcB1RNt4JtoDZ2qL2FqLDDNV4aODVAg@mail.gmail.com>
References: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
	<CANEJEGtDr+BdP1s=EUpUSqcvWpQfkt+o_3zoXWHk7DdjH4j0Ow@mail.gmail.com>
	<CANEJEGukOKUgRJNPVaeEXpx-REzj8ooSfWdrnRMMCQr6EVaNqQ@mail.gmail.com>
	<CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
	<CANEJEGuwymF-v7rdep4h2eGcvCAzEVvaYtwHCim9UR5NLZPkbg@mail.gmail.com>
	<x49si55v04n.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33231 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbbJUJA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 05:00:58 -0400
Received: by wijp11 with SMTP id p11so84325641wij.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 02:00:57 -0700 (PDT)
In-Reply-To: <x49si55v04n.fsf@segfault.boston.devel.redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>

On 20 October 2015 at 20:57, Jeff Moyer <jmoyer@redhat.com> wrote:
> Hi Grant,
>
> Grant Grundler <grundler@chromium.org> writes:
>
>> Ping? Does no one care how long BLK_SECDISCARD takes?
>>
>> ChromeOS has landed this change as a compromise between "fast" (<10
>> seconds) and "minimize risk" (~90 seconds) for a 23GB partition on
>> eMMC:
>>     https://chromium-review.googlesource.com/#/c/302413/
>
> Including the patch would be helpful.  I believe this is it.  My
> comments are inline.
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 8411be3..43943c7 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
>
> @@ -60,21 +60,37 @@
>         granularity = max(q->limits.discard_granularity >> 9, 1U);
>         alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
>
> -       /*
> -        * Ensure that max_discard_sectors is of the proper
> -        * granularity, so that requests stay aligned after a split.
> -        */
> -       max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
> -       max_discard_sectors -= max_discard_sectors % granularity;
> -       if (unlikely(!max_discard_sectors)) {
> -               /* Avoid infinite loop below. Being cautious never hurts. */
> -               return -EOPNOTSUPP;
> -       }
> +       max_discard_sectors = min(q->limits.max_discard_sectors,
> +                                               UINT_MAX >> 9);
>
> Unnecessary reformatting.
>
>         if (flags & BLKDEV_DISCARD_SECURE) {
>                 if (!blk_queue_secdiscard(q))
>                         return -EOPNOTSUPP;
>                 type |= REQ_SECURE;
> +               /*
> +                * Secure erase performs better by telling the device
> +                * about the largest range possible.  Secure erase
> +                * piecemeal will likely result in mapped sectors
> +                * getting evacuated from one range and parked in
> +                * another range that will get erased by a future
> +                * erase command.  This does NOT happen for normal
> +                * TRIM or DISCARD operations.
> +                *
> +                * 32GB was a compromise to avoid blocking the device
> +                * for potentially minute(s) at a time.
> +                */
> +               if (max_discard_sectors < (1 << (25-9)))        /* 32GiB */
> +                       max_discard_sectors = 1 << (25-9);
>
> And here you're ignoring q->limits.max_discard_sectors.  I'm surprised
> this worked!
>
> +       }
> +
> +       /*
> +        * Ensure that max_discard_sectors is of the proper
> +        * granularity, so that requests stay aligned after a split.
> +        */
> +       max_discard_sectors -= max_discard_sectors % granularity;
> +       if (unlikely(!max_discard_sectors)) {
> +               /* Avoid infinite loop below. Being cautious never hurts. */
> +               return -EOPNOTSUPP;
>         }
>
>         atomic_set(&bb.done, 1);
>
> Grant, can we start over with the problem description? (Sorry, I didn't
> see the previous posts.)  I'd like to know the values of discard_granularity
> and discard_max_bytes for your device.  Additionally, it would be
> interesting to know how the discards are being initiatied.  Is it via a
> userspace utility such as mkfs, online discard via some file system
> mounted with -o discard, or something else?  Finally, can you post
> binary blktrace data somewhere for the slow case?
>
> Thanks!
> Jeff
>
>
>
>
>> On Mon, Sep 28, 2015 at 2:45 PM, Grant Grundler <grundler@chromium.org> wrote:
>>> [resending...I forgot to switch gmail back to text-only mode. grrrh..]
>>>
>>> ---------- Forwarded message ----------
>>> From: Grant Grundler <grundler@chromium.org>
>>> Date: Mon, Sep 28, 2015 at 2:42 PM
>>> Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
>>> To: Grant Grundler <grundler@chromium.org>
>>> Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson
>>> <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
>>> "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
>>>
>>>
>>> On Thu, Sep 24, 2015 at 10:39 AM, Grant Grundler <grundler@chromium.org> wrote:
>>>>
>>>> Some followup.
>>> ...
>>>>
>>>> 2) I've been able to test this hack on an eMMC device:
>>>> [   13.147747] mmc..._secdiscard_rq(mmc1) ERASE from 14116864 cnt
>>>> 0x2c00000 (size 22528 MiB)
>>>> [   13.155964] sdhci cmd: 35/0x1a arg 0xd76800
>>>> [   13.160266] sdhci cmd: 36/0x1a arg 0x39767ff
>>>> [   13.164593] sdhci cmd: 38/0x1b arg 0x80000000
>>>> [   13.803360] random: nonblocking pool is initialized
>>>> [   14.567735] sdhci cmd: 13/0x1a arg 0x10000
>>>> [   14.573324] mmc..._secdiscard_rq(mmc1) err 0
>>>>
>>>> This was with ~15K files and about 5GB written to the device. 1.4
>>>> seconds compared to about 20 minutes to secure erase the same region
>>>> with original v3.18 code.
>>>
>>>
>>> To put a few more numbers on the "chunk size vs perf":
>>>  1EG (512KB) -> 44K commands -> ~20 minutes
>>> 32EG (16MB) -> 1375 commands -> ~1 minute
>>> 128EG (64MB) -> 344 commands -> ~30 seconds
>>> 8191EG (~4GB) -> 6 commands -> 2 seconds + ~8 seconds mkfs
>>> (I'm assuming times above include about 6-10 seconds of mkfs as part
>>> of writing a new file system)
>>>
>>> This is with only ~300MB of data written to the partition. I'm fully
>>> aware that times will vary depending on how much data needs to be
>>> migrated (and in this case very little or none). I'm certain the
>>> difference will only get worse for the smaller the "chunk size" used
>>> to Secure Erase due to repeated data migration.
>>>
>>> Given the different use model for secure erase (legal/contractually
>>> required behavior), is using 4GB chunk size acceptable?
>>>
>>> Would anyone be terribly offended if I used the recently added
>>> "MMC_IOC_MULTI_CMD" to send the cmd 35/36/38 sequence to the eMMC
>>> device to securely erase the offending partition?
>>>
>>> thanks,
>>> grant
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/

I am not sure if this issue is the same as been discussed earlier on
the mmc list regarding "discard/erase".

Anyway, there have been several attempts to fix bugs related to this.
One of these discussion kind of pointed out a viable solution, but
unfortunate no patches that adopts that solution have been posted yet.

You might want to read up on this.
https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg23643.html
http://linux-mmc.vger.kernel.narkive.com/Wp31G953/patch-mmc-core-don-t-return-1-for-max-discard

So this is an old issue, which should have been fixed long long long time ago...

Kind regards
Uffe

From: Grant Grundler <grundler@chromium.org>
Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Wed, 21 Oct 2015 10:38:03 -0700
Message-ID: <CANEJEGtYdkdouEoDrPE-AJ9suMqtthxoyzkkdL-yLPKFTeVK9Q@mail.gmail.com>
References: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
	<CANEJEGtDr+BdP1s=EUpUSqcvWpQfkt+o_3zoXWHk7DdjH4j0Ow@mail.gmail.com>
	<CANEJEGukOKUgRJNPVaeEXpx-REzj8ooSfWdrnRMMCQr6EVaNqQ@mail.gmail.com>
	<CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
	<CANEJEGuwymF-v7rdep4h2eGcvCAzEVvaYtwHCim9UR5NLZPkbg@mail.gmail.com>
	<x49si55v04n.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35455 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbbJURiF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 13:38:05 -0400
Received: by ykaz22 with SMTP id z22so57226515yka.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 10:38:04 -0700 (PDT)
In-Reply-To: <x49si55v04n.fsf@segfault.boston.devel.redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Grant Grundler <grundler@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>

On Tue, Oct 20, 2015 at 11:57 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
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
> Including the patch would be helpful.  I believe this is it.

Thanks Jeff!  Gerrit does provide easy mechanisms to review or pull
the patch - easy to use - not easy to find though. :/

> My comments are inline.
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

See Gwendal's earlier reply. Here is the entire thread:
   https://lkml.org/lkml/2015/9/22/1235

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
> see the previous posts.)

First/second posting in https://lkml.org/lkml/2015/9/22/1235 should
provide this.

>  I'd like to know the values of discard_granularity
> and discard_max_bytes for your device.

Gwendal might be able to provide those. I no longer have possession the HW.

>  Additionally, it would be
> interesting to know how the discards are being initiatied.  Is it via a
> userspace utility such as mkfs, online discard via some file system
> mounted with -o discard, or something else?

BLK_SECDISCARD ioctl with parameters to describe the /data partition
on an android device.

> Finally, can you post
> binary blktrace data somewhere for the slow case?

Sorry,  -ENOHW.
 second
I only have a snippet of printk output from the original code with
slow performance:
[   13.409334] sdhci-cmd:  CMD 0x231a arg 0x3976800
[   13.414150] sdhci-cmd:  CMD 0x241a arg 0x3976bff
[   13.418790] sdhci-cmd:  CMD 0x261b arg 0x80000000
[   13.424488] sdhci-cmd:  CMD 0xd1a arg 0x10000
[   13.429622] sdhci-cmd:  CMD 0x231a arg 0x3976c00
[   13.434333] sdhci-cmd:  CMD 0x241a arg 0x3976fff
[   13.438968] sdhci-cmd:  CMD 0x261b arg 0x80000000
[   13.443717] sdhci-cmd:  CMD 0xd1a arg 0x10000
[   13.448113] sdhci-cmd:  CMD 0x231a arg 0x3977000
[   13.453087] sdhci-cmd:  CMD 0x241a arg 0x39773ff
[   13.457780] sdhci-cmd:  CMD 0x261b arg 0x80000000
[   13.462839] sdhci-cmd:  CMD 0xd1a arg 0x10000
[   13.468237] sdhci-cmd:  CMD 0x231a arg 0x3977400
[   13.472980] sdhci-cmd:  CMD 0x241a arg 0x39777ff
[   13.477619] sdhci-cmd:  CMD 0x261b arg 0x80000000
[   13.482352] sdhci-cmd:  CMD 0xd1a arg 0x10000

"CMD" is 35/36/38/13 (but in hex) + flags (IIRC)

Each command is taking ~20ms. But multiple that by 46k to erase the
entire 23GB partition == 15 minutes.

I will assert this is "best case" since I usually tested with very
little "live" data (< 300MB) that would need to be evacuated from any
given erase block.

> Thanks!

Thanks for the feedback! :)

cheers,
grant

From: Grant Grundler <grundler@chromium.org>
Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Tue, 20 Oct 2015 10:53:45 -0700
Message-ID: <CANEJEGuwymF-v7rdep4h2eGcvCAzEVvaYtwHCim9UR5NLZPkbg@mail.gmail.com>
References: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
	<CANEJEGtDr+BdP1s=EUpUSqcvWpQfkt+o_3zoXWHk7DdjH4j0Ow@mail.gmail.com>
	<CANEJEGukOKUgRJNPVaeEXpx-REzj8ooSfWdrnRMMCQr6EVaNqQ@mail.gmail.com>
	<CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35913 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbJTRxq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 13:53:46 -0400
Received: by wicfx6 with SMTP id fx6so57331469wic.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2015 10:53:45 -0700 (PDT)
In-Reply-To: <CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>

Ping? Does no one care how long BLK_SECDISCARD takes?

ChromeOS has landed this change as a compromise between "fast" (<10
seconds) and "minimize risk" (~90 seconds) for a 23GB partition on
eMMC:
    https://chromium-review.googlesource.com/#/c/302413/

This is a generic problem if we care about data privacy since
consumers won't expect a "secure erase" operation to take 1/2h or more
and think the device is hung.

cheers,
grant

On Mon, Sep 28, 2015 at 2:45 PM, Grant Grundler <grundler@chromium.org> wrote:
> [resending...I forgot to switch gmail back to text-only mode. grrrh..]
>
> ---------- Forwarded message ----------
> From: Grant Grundler <grundler@chromium.org>
> Date: Mon, Sep 28, 2015 at 2:42 PM
> Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
> To: Grant Grundler <grundler@chromium.org>
> Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson
> <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
> "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
>
>
> On Thu, Sep 24, 2015 at 10:39 AM, Grant Grundler <grundler@chromium.org> wrote:
>>
>> Some followup.
> ...
>>
>> 2) I've been able to test this hack on an eMMC device:
>> [   13.147747] mmc..._secdiscard_rq(mmc1) ERASE from 14116864 cnt
>> 0x2c00000 (size 22528 MiB)
>> [   13.155964] sdhci cmd: 35/0x1a arg 0xd76800
>> [   13.160266] sdhci cmd: 36/0x1a arg 0x39767ff
>> [   13.164593] sdhci cmd: 38/0x1b arg 0x80000000
>> [   13.803360] random: nonblocking pool is initialized
>> [   14.567735] sdhci cmd: 13/0x1a arg 0x10000
>> [   14.573324] mmc..._secdiscard_rq(mmc1) err 0
>>
>> This was with ~15K files and about 5GB written to the device. 1.4
>> seconds compared to about 20 minutes to secure erase the same region
>> with original v3.18 code.
>
>
> To put a few more numbers on the "chunk size vs perf":
>  1EG (512KB) -> 44K commands -> ~20 minutes
> 32EG (16MB) -> 1375 commands -> ~1 minute
> 128EG (64MB) -> 344 commands -> ~30 seconds
> 8191EG (~4GB) -> 6 commands -> 2 seconds + ~8 seconds mkfs
> (I'm assuming times above include about 6-10 seconds of mkfs as part
> of writing a new file system)
>
> This is with only ~300MB of data written to the partition. I'm fully
> aware that times will vary depending on how much data needs to be
> migrated (and in this case very little or none). I'm certain the
> difference will only get worse for the smaller the "chunk size" used
> to Secure Erase due to repeated data migration.
>
> Given the different use model for secure erase (legal/contractually
> required behavior), is using 4GB chunk size acceptable?
>
> Would anyone be terribly offended if I used the recently added
> "MMC_IOC_MULTI_CMD" to send the cmd 35/36/38 sequence to the eMMC
> device to securely erase the offending partition?
>
> thanks,
> grant

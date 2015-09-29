From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Tue, 29 Sep 2015 05:56:51 -0700
Message-ID: <CAMHSBOU_iGsq4DkKTOJQ8mJ0paeALPOLRCKHmgyvyVYb=2bByw@mail.gmail.com>
References: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
 <CANEJEGtDr+BdP1s=EUpUSqcvWpQfkt+o_3zoXWHk7DdjH4j0Ow@mail.gmail.com>
 <CANEJEGukOKUgRJNPVaeEXpx-REzj8ooSfWdrnRMMCQr6EVaNqQ@mail.gmail.com> <CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33458 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbbI2M5M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2015 08:57:12 -0400
Received: by iofh134 with SMTP id h134so9217605iof.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2015 05:57:11 -0700 (PDT)
In-Reply-To: <CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The issue is mmc_init_erase() needs to be updated:
On modern eMMC, we set pref_erase to >ext_csd.hc_erase_size.
hc_erase_size, aka High Capacity Erase Group Size, is the minimum
amount of data that can be erased on that device, not the optimal
amount. It is used to be sure a partition ends on group boundaries.
That why we ended up with a preg_size at 512kB.
If hc_erase_size was not defined, we would have pref_erase size to
4MB, because the device 1GB or bigger. Given new eMMC can be found in
128GB capacity, we should increase the scale, maybe 16MB over 4GB and
64MB over 16GB.

Gwendal.

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

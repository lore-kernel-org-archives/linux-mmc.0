From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 19 Feb 2011 22:39:06 -0600
Message-ID: <AANLkTi=GO8N15pCnZWuuJ6FfyQMytFt23LPS5oYMNuMu@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
	<AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
	<201102191054.48706.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:48150 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab1BTEjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Feb 2011 23:39:10 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1K4c4Bo019408
	for <linux-mmc@vger.kernel.org>; Sat, 19 Feb 2011 23:38:04 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1K4c4Bx019397
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 19 Feb 2011 23:38:04 -0500 (EST)
Received: by vws10 with SMTP id 10so661714vws.15
        for <linux-mmc@vger.kernel.org>; Sat, 19 Feb 2011 20:39:07 -0800 (PST)
In-Reply-To: <201102191054.48706.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sat, Feb 19, 2011 at 3:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 February 2011 23:40:16 Andrei Warkentin wrote:
>> On Fri, Feb 18, 2011 at 1:47 PM, Andrei Warkentin <andreiw@motorola.=
com> wrote:
>>
>> Flashbench timings for both Sandisk and Toshiba cards. Attaching due=
 to size.
>
> Very nice, thanks for the measurement!
>
> I don't think having the results inline in the mail is a problem,
> it would even make it easier to quote.
>
>> Some interesting things that I don't understand. For the align test,=
 I
>> extended it to do a write align test (-A). I tried two partitions th=
at
>> I could write over, and both read and writes behaved differently for
>> the two partitions on same device. Odd. They are both 4MB aligned.
>
> I never did a write align test because the results will be highly
> unreliable as soon as you get into thrashing. Your results seem
> to be meaningful still, so maybe we should have it after all, but
> I'll put a big warning on it.
>

Actually it would be a good idea to also bail/warn if you do the au
test with more open au's than the size of the passed device allows,
since it'll just wrap around and skew the results.

>> On the sandisk it was the write align that made the page size stand
>> out. =A0The read align had pretty constant results.
>
> I've noticed on other Sandisk media that the read align test is
> sometimes useless. It may help to do a full erase of the partition,
> or to fill it with data before running the test.
>
>> On the toshiba the results varied wildly for the two partitions. For
>> partition 6, there was a clear pattern in the diff values for read
>> align. For 9, it was all over the place. For 9 with the write align,
>> 8K and 16K the crossing writes took ~115ms!! Look in attached files
>> for all the data.
>
> Partition 6 is a lot smaller, so you have the accesses less than a
> segment apart, so it shows other effects.
>
>> The AU tests were interesting too, especially how with several open
>> AUs the throughput is higher for certain smaller sizes on sandisk, b=
ut
>> if I interpret it correctly both cards have at least 4 AUs, as I
>> didn't see yet a significant drop for small sizes. The larger ones I
>> am running now on mmcblk0p9 which is sufficiently larger for these
>> tests... (mmcblk0p6 is only 40mb, p9 is 314 mb)
>
> Right, you should try larger values for --open-au-nr here. It's at
> least a good sign that the drive can do random access inside a segmen=
t
> and that it can have at least 4 segments open. This is much better
> than I expected from your descriptions at first.

Actually the Toshiba one seems to have 7 AUs if I interpret this correc=
tly.
^C
# ./flashbench -O -0 6  -b 512 /dev/block/mmcblk0p9
4MiB    5.91M/s
2MiB    8.84M/s
1MiB    10.8M/s
512KiB  13M/s
256KiB  13.6M/s

^C
# ./flashbench -O -0 7  -b 512 /dev/block/mmcblk0p9
4MiB    6.32M/s
2MiB    8.63M/s
1MiB    10.5M/s
512KiB  13.2M/s
256KiB  13M/s
^[[A^[[D^[[A128KiB  12.3M/s
^C
# ./flashbench -O -0 8  -b 512 /dev/block/mmcblk0p9
4MiB    6.65M/s
2MiB    7.02M/s
1MiB    6.36M/s
512KiB  3.17M/s
256KiB  1.53M/s

The Sandisk one has 20 AUs.

# ./flashbench -O -0 20  -b 512 /dev/block/mmcblk0p9
4MiB    11.3M/s
2MiB    12.8M/s
1MiB    9.87M/s
512KiB  9.97M/s
256KiB  9.13M/s
128KiB  8.05M/s
^C
# ./flashbench -O -0 50  -b 512 /dev/block/mmcblk0p9
4MiB    7.19M/s
^C
# ./flashbench -O -0 2  -b 512 /dev/block/mmcblk0p9
^C
# ./flashbench -O -0 22  -b 512 /dev/block/mmcblk0p9
4MiB    11.6M/s
2MiB    12.3M/s
1MiB    5.13M/s
512KiB  2.57M/s
256KiB  1.59M/s
128KiB  1.16M/s
64KiB   776K/s
^C
# ./flashbench -O -0 21  -b 512 /dev/block/mmcblk0p9
4MiB    11.2M/s
2MiB    12.4M/s
1MiB    4.65M/s
512KiB  1.95M/s
256KiB  955K/s

>
> However, the drop from 32 KB to 16 KB in performance is horrifying
> for the Toshiba drive, it's clear that this one does not like
> to be accessed smaller than 32 KB at a time, an obvious optimization
> for FAT32 with 32 KB clusters. How does this change with your
> kernel patches?

Since the only performance-increasing patch here would be just the one
that splits unaligned accesses, I wouldn't expect any improvements for
page-aligned accesses < 32KB. As you can see here...

# cat /sys/block/mmcblk0/device/page_size
8192
# ./flashbench -O -0 1  -b 512 /dev/block/mmcblk0p9
4MiB    6.81M/s
2MiB    7.73M/s
1MiB    9.21M/s
512KiB  9.98M/s
256KiB  10.3M/s
128KiB  10.2M/s
64KiB   9.76M/s
32KiB   8.52M/s
16KiB   3.68M/s
8KiB    1.72M/s
4KiB    837K/s
^C
# echo 0 >  /sys/block/mmcblk0/device/page_size
# ./flashbench -O -0 1  -b 512 /dev/block/mmcblk0p9
4MiB    6.42M/s
2MiB    7.79M/s
1MiB    9.22M/s
512KiB  10M/s
256KiB  9.94M/s
128KiB  10.1M/s
64KiB   9.68M/s
32KiB   8.5M/s
16KiB   3.65M/s
8KiB    1.73M/s
4KiB    838K/s
2KiB    417K/s
^C
#


>
> For the sandisk drive, it's funny how it is consistently faster
> doing random access than linear access. I don't think I've seem that
> before. It does seem to have some cache for linear access using
> smaller than 16 KB, and can probably combine them when it's only
> writing to a single segment.

Yes, that is pretty interesting. Smaller than 16K? Not smaller than
32K? I wonder what it is doing...

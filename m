From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 19 Feb 2011 12:20:54 +0100
Message-ID: <201102191220.54815.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com> <AANLkTimWAnPg2sYiLbfZXAAUiu7P5T3LmNoVbPi9RTEG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57936 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab1BSLU7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Feb 2011 06:20:59 -0500
In-Reply-To: <AANLkTimWAnPg2sYiLbfZXAAUiu7P5T3LmNoVbPi9RTEG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Saturday 19 February 2011 00:17:51 Andrei Warkentin wrote:
> # echo 0 > /sys/block/mmcblk0/device/page_size
> # ./flashbench -A -b 1024 /dev/block/mmcblk0p9
> write align 8388608     pre 3.59ms      on 6.54ms       post 3.65ms  =
   diff 2.92ms
> write align 4194304     pre 4.13ms      on 7.37ms       post 4.27ms  =
   diff 3.17ms
> write align 2097152     pre 3.62ms      on 6.81ms       post 3.94ms  =
   diff 3.03ms
> write align 1048576     pre 3.62ms      on 6.53ms       post 3.55ms  =
   diff 2.95ms
> write align 524288      pre 3.62ms      on 6.51ms       post 3.63ms  =
   diff 2.88ms
> write align 262144      pre 3.62ms      on 6.51ms       post 3.63ms  =
   diff 2.89ms
> write align 131072      pre 3.62ms      on 6.5ms        post 3.63ms  =
   diff 2.88ms
> write align 65536       pre 3.61ms      on 6.49ms       post 3.62ms  =
   diff 2.88ms
> write align 32768       pre 3.61ms      on 6.49ms       post 3.61ms  =
   diff 2.88ms
> write align 16384       pre 3.68ms      on 107ms        post 3.51ms  =
   diff 103ms
> write align 8192        pre 3.74ms      on 121ms        post 3.91ms  =
   diff 117ms
> write align 4096        pre 3.88ms      on 3.87ms       post 3.87ms  =
   diff -2937ns
> write align 2048        pre 3.89ms      on 3.88ms       post 3.88ms  =
   diff -8734ns
> # fjnh84@fjnh84-desktop:~/src/n/src/flash$ adb -s 17006185428011d7 sh=
ell
> # echo 8192 > /sys/block/mmcblk0/device/page_size
> # cd data
> # ./flashbench -A -b 1024 /dev/block/mmcblk0p9
> write align 8388608     pre 3.33ms      on 6.8ms        post 3.65ms  =
   diff 3.31ms
> write align 4194304     pre 4.34ms      on 8.14ms       post 4.53ms  =
   diff 3.71ms
> write align 2097152     pre 3.64ms      on 7.31ms       post 4.09ms  =
   diff 3.44ms
> write align 1048576     pre 3.65ms      on 7.52ms       post 3.65ms  =
   diff 3.87ms
> write align 524288      pre 3.62ms      on 6.8ms        post 3.63ms  =
   diff 3.17ms
> write align 262144      pre 3.62ms      on 6.84ms       post 3.63ms  =
   diff 3.22ms
> write align 131072      pre 3.62ms      on 6.85ms       post 3.44ms  =
   diff 3.32ms
> write align 65536       pre 3.39ms      on 6.8ms        post 3.66ms  =
   diff 3.28ms
> write align 32768       pre 3.64ms      on 6.86ms       post 3.66ms  =
   diff 3.21ms
> write align 16384       pre 3.67ms      on 6.86ms       post 3.65ms  =
   diff 3.2ms
> write align 8192        pre 3.66ms      on 6.84ms       post 3.64ms  =
   diff 3.19ms
> write align 4096        pre 3.71ms      on 3.71ms       post 3.64ms  =
   diff 38.6=B5s
> write align 2048        pre 3.71ms      on 3.71ms       post 3.72ms  =
   diff -656ns
>=20
> This was with the split unaligned accesses patch... Which I am
> attaching for comments.

I agree, this is very fascinating behavior. 100ms second latency for a
single 2KB access is definitely something we should try to avoid, and I
wonder why the drive decides to do that. It must get into a state where
it requires an extra garbage collection (you mentioned that earlier).

The numbers you see here are taken over multiple runs. Do you see a lot
of fluctuation when doing this with --count=3D1?

Also, does the same happen with other blocksizes, e.g. 4096 or 8192, pa=
ssed
to flashbench?

	Arnd

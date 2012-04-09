From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: swap on eMMC and other flash
Date: Mon, 9 Apr 2012 12:50:44 +0000
Message-ID: <201204091250.45034.arnd@arndb.de>
References: <201203301744.16762.arnd@arndb.de> <201204021455.25029.arnd@arndb.de> <02cc01cd12c1$769421e0$63bc65a0$%jeong@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55670 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab2DIMvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 08:51:09 -0400
In-Reply-To: <02cc01cd12c1$769421e0$63bc65a0$%jeong@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?euc-kr?q?=C1=A4=C8=BF=C1=F8?= <syr.jeong@samsung.com>
Cc: 'Hugh Dickins' <hughd@google.com>, cpgs@samsung.com, linaro-kernel@lists.linaro.org, 'Rik van Riel' <riel@redhat.com>, linux-mmc@vger.kernel.org, 'Alex Lemberg' <alex.lemberg@sandisk.com>, linux-kernel@vger.kernel.org, "'Luca Porzio (lporzio)'" <lporzio@micron.com>, linux-mm@kvack.org, kernel-team@android.com, 'Yejin Moon' <yejin.moon@samsung.com>

On Thursday 05 April 2012, =C1=A4=C8=BF=C1=F8 wrote:

> I'm not sure that how Linux manage swap area.
> If there are difference of information for invalid data between host =
and
> eMMC device, discard to eMMC is good for performance of IO. It is as =
same
> as general case of discard of user partition which is formatted with
> filesystem.
> As your e-mail mentioned, overwriting the logical address is the anot=
her
> way to send info of invalid data address just for the overwrite area,
> however it is not a best way for eMMC to manage physical NAND array. =
In
> this case, eMMC have to trim physical NAND array, and do write operat=
ion at
> the same time. It needs more latency.
> If host send discard with invalid data address info in advance, eMMC =
can
> find beat way to manage physical NAND page before host usage(write
> operation).
> I'm not sure it is the right comments of your concern.
> If you need more info, please let me know

One specific property of the linux swap code is that we write relativel=
y
large clusters (1 MB today) sequentially and only reuse them once all
of the data in them has become invalid. Part of my suggestion was to
increase that size to the erase block size of the underlying storage,
e.g. 8MB for typical eMMC. Right now, we send a discard command
just before reusing a swap cluster, for the entire cluster.

In my interpretation, this already means a typical device will never to=
 a
garbage collection of that erase block because we never overwrite the
erase block partially.

Luca suggested that we could send the discard command as soon as an
individual 4kb page is freed, which would let the device reuse the
physical erase block as soon as all the pages in that erase block have
been freed over time, but my interpretation is that while this can
help for global wear levelling, it does not help avoid any garbage
collection.

	Arnd

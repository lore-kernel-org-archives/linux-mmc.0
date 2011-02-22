From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 22 Feb 2011 01:05:38 -0600
Message-ID: <AANLkTikZh10-2_BLqq0DOm67xZCAEsW9FaRw=+sh+GTY@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102191220.54815.arnd@arndb.de>
	<AANLkTincLPnW90xvE304dCjkTbKUQGf6H8yWDVdz5Kh4@mail.gmail.com>
	<201102201623.03596.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:33162 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab1BVHFm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 02:05:42 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1M75qt5013331
	for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 02:05:52 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1M75SwD013218
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 02:05:52 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so2515581vws.15
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 23:05:39 -0800 (PST)
In-Reply-To: <201102201623.03596.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sun, Feb 20, 2011 at 9:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The description of the test case is probably suboptimal. What this does
> is 32 KB accesses, with 32 KB alignment in the pre and post case, but 16 KB
> alignment in the "on" case. The idea here is that it should never do
> any access with less than "--blocksize" aligment.
>

Now I feel slightly confused :(.

-b 16384 implies blocksize = 16384, maxalign is 8mb due to count 32,

               ret = time_rw_interval(dev, count, pre, blocksize,
                                       align - blocksize, maxalign,
                                       do_write);   //
<----------------- read 16k at align - 16k with 8mb intervals?
                returnif(ret);

                ret = time_rw_interval(dev, count, on, blocksize,
                                       align - blocksize / 2, maxalign,
                                       do_write);  //
<----------------- read 16k at align - 8k with 8mb intervals?
	        returnif(ret);

                ret = time_rw_interval(dev, count, post, blocksize,
 	                               align, maxalign, do_write); //
<-------- read 16k at align with 8mb intervals?
		returnif(ret);

I hope I'm not missing something obvious...


> This is what I think happens:
> Since the partition is over 64 MB size and it can have 7 4 MB allocation units open,
> writing to 8 locations on the drive separated 8 MB causes it to do garbage collection
> all the time for 32KB accesses and larger. However, the "on" measurement is only
> 16 KB aligned, so it goes into T's buffer A for small writes, and does not hit
> the garbage collection all the time, so it ends up being a lot faster.
>

Can't go to A. A is 8KB big. Strange...

A

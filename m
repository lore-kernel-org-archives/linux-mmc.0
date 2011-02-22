From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 22 Feb 2011 17:49:13 +0100
Message-ID: <201102221749.13992.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102201623.03596.arnd@arndb.de> <AANLkTikZh10-2_BLqq0DOm67xZCAEsW9FaRw=+sh+GTY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53828 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1BVQtW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 11:49:22 -0500
In-Reply-To: <AANLkTikZh10-2_BLqq0DOm67xZCAEsW9FaRw=+sh+GTY@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Tuesday 22 February 2011, Andrei Warkentin wrote:
> On Sun, Feb 20, 2011 at 9:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The description of the test case is probably suboptimal. What this does
> > is 32 KB accesses, with 32 KB alignment in the pre and post case, but 16 KB
> > alignment in the "on" case. The idea here is that it should never do
> > any access with less than "--blocksize" aligment.
> >
> 
> Now I feel slightly confused :(.
> 
> -b 16384 implies blocksize = 16384, maxalign is 8mb due to count 32,
> 
>                ret = time_rw_interval(dev, count, pre, blocksize,
>                                        align - blocksize, maxalign,
>                                        do_write);   //
> <----------------- read 16k at align - 16k with 8mb intervals?
>                 returnif(ret);
> 
>                 ret = time_rw_interval(dev, count, on, blocksize,
>                                        align - blocksize / 2, maxalign,
>                                        do_write);  //
> <----------------- read 16k at align - 8k with 8mb intervals?
>                 returnif(ret);
> 
>                 ret = time_rw_interval(dev, count, post, blocksize,
>                                        align, maxalign, do_write); //
> <-------- read 16k at align with 8mb intervals?
>                 returnif(ret);
> 
> I hope I'm not missing something obvious...

No, you are absolutely right. I think I changed this once and no longer
remembered what the final version did.

	Arnd

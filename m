From: Mahadev Cholachagudda <mgudda@gmail.com>
Subject: Re: [PATCH 1/1] CMD12 error recovery support for SD cards
Date: Mon, 5 Oct 2009 09:53:42 +0530
Message-ID: <bd31ea570910042123l20d97843i57d66cdd5c9eb5a5@mail.gmail.com>
References: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com>
	 <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
	 <20090923102715.GA4307@console-pimps.org>
	 <bd31ea570909300418y4f12bf3bu2d145b94a93319e@mail.gmail.com>
	 <20091002102002.GA6687@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:50628 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZJEEYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2009 00:24:19 -0400
Received: by pxi9 with SMTP id 9so2658796pxi.4
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2009 21:23:43 -0700 (PDT)
In-Reply-To: <20091002102002.GA6687@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>

2009/10/2 Matt Fleming <matt@console-pimps.org>:
>
> I may be looking at an out of date SD Host Controller Spec, but can you
> point me at the place where it says that it's ok to retry the CMD12 if
> it failed? I can find the part explaining that you can issue CMD13 to
> see if CMD12 really failed or not, but not the place where it says you
> can reissue CMD12.
>
> In your testcase, do you always end up issuing the second CMD12?
>

In SD HostController Simplified Spec, page 106, tells about CMD12
failure and CMD13 to check the status.
Page 110, section 3.10.2, tells about AutoCMD12 error recovery, but we
can safely include this for checking with normal CMD12 error recovery.

Yep, In our target board, some-times, we end up issuing the second CMD12.

>
> Are you sure that this recovery procedure is not valid over SPI when
> doing a multiblock read?
>

I'm not able to get the details of recovery procedure for SPI.
Moreover the host controller spec 2.0 does not support SPI mode.

> "successfull" should be "successful"

Shall be updated.

>
> I'm not entirely sure any of these errors are needed. The code below
> this in drivers/mmc/card/block.c will print an error message if
> brq.stop.error is non-zero (and we will have left it non-zero if we
> haven't recovered).
>

OK. I shall update this too.

Regards,
Mahadev

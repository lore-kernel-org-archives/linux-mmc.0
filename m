From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Thu, 20 Oct 2011 08:10:02 -0700
Message-ID: <CAHzg1A-E0ziGaO_4ttm6tWBsLZe+cUVt=Cn7Cr8gwC0XA_PSSw@mail.gmail.com>
References: <1680748273.3852.1317673156420.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<4E8A2275.3050009@linux.intel.com>
	<CANz0V+5HGJpNkoHMmsAupCcCK3tG74Jza=rmZQxjv3pwMWKSuA@mail.gmail.com>
	<CAHzg1A9swGoYy8fE6ULw8WprJQvURQNWHhOZ9vywgrONT9RDpw@mail.gmail.com>
	<CANz0V+48-8wXLjN4=LsU=-iQjLsgczqYo0Vs8xF=0Y=dCG=o=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36953 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1JTPKD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 11:10:03 -0400
Received: by yxl42 with SMTP id 42so320950yxl.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2011 08:10:03 -0700 (PDT)
In-Reply-To: <CANz0V+48-8wXLjN4=LsU=-iQjLsgczqYo0Vs8xF=0Y=dCG=o=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, Andrei Warkentin <awarkentin@vmware.com>, =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

2011/10/20 Andrei E. Warkentin <andrey.warkentin@gmail.com>:
> 2011/10/19 Praveen G K <praveen.gk@gmail.com>:
>> Also, can somebody please tell me the significance of blk_end_request? Thanks.
>> Why do we call this after every block read or write?
>
> Because you want to update the struct request with the amount
> written/read. If the entire
> requested I/O range has been satiffied, blk_end_request also calls
> blk_finish_request and
> completes the request.
Just for a quick understanding, I did the following

During every eMMC write, I called the multi block write command with
the same set of data, and I called the mmc_end_request after  let's
say every 10 transfers (with each transfer being 128 blocks).  I
noticed that I did not see those big busy wait times as frequently as
compared to calling blk_end_request after every 128 block was
transferred.  Why is that happening?

> I/O is asynchronous - hence, you need to let whatever made the request
> know it's completed.
So, does that mean, the actual writes to the eMMC (or reads from the
eMMC) takes place here? If so, what happens when we send the MULTI
BLOCK WRITE command?
> A
>

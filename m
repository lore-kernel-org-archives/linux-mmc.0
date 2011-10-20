From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: slow eMMC write speed
Date: Thu, 20 Oct 2011 11:01:20 -0400
Message-ID: <CANz0V+48-8wXLjN4=LsU=-iQjLsgczqYo0Vs8xF=0Y=dCG=o=Q@mail.gmail.com>
References: <1680748273.3852.1317673156420.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<4E8A2275.3050009@linux.intel.com>
	<CANz0V+5HGJpNkoHMmsAupCcCK3tG74Jza=rmZQxjv3pwMWKSuA@mail.gmail.com>
	<CAHzg1A9swGoYy8fE6ULw8WprJQvURQNWHhOZ9vywgrONT9RDpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40177 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1JTPBW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 11:01:22 -0400
Received: by wwe6 with SMTP id 6so4309510wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2011 08:01:21 -0700 (PDT)
In-Reply-To: <CAHzg1A9swGoYy8fE6ULw8WprJQvURQNWHhOZ9vywgrONT9RDpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, Andrei Warkentin <awarkentin@vmware.com>, =?UTF-8?Q?Per_F=C3=B6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

2011/10/19 Praveen G K <praveen.gk@gmail.com>:
> Also, can somebody please tell me the significance of blk_end_request? Thanks.
> Why do we call this after every block read or write?

Because you want to update the struct request with the amount
written/read. If the entire
requested I/O range has been satiffied, blk_end_request also calls
blk_finish_request and
completes the request.

I/O is asynchronous - hence, you need to let whatever made the request
know it's completed.

A

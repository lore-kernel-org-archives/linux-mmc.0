From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: slow eMMC write speed
Date: Thu, 20 Oct 2011 08:26:36 -0700 (PDT)
Message-ID: <334439217.124350.1319124396858.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <CAHzg1A-E0ziGaO_4ttm6tWBsLZe+cUVt=Cn7Cr8gwC0XA_PSSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:25085 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752757Ab1JTP0h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Oct 2011 11:26:37 -0400
In-Reply-To: <CAHzg1A-E0ziGaO_4ttm6tWBsLZe+cUVt=Cn7Cr8gwC0XA_PSSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, =?utf-8?Q?Per_F=C3=B6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>, "Andrei E. Warkentin" <andrey.warkentin@gmail.com>

----- Original Message -----
> From: "Praveen G K" <praveen.gk@gmail.com>
> To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
> Cc: "J Freyensee" <james_p_freyensee@linux.intel.com>, "Andrei Warken=
tin" <awarkentin@vmware.com>, "Per F=C3=B6rlin"
> <per.forlin@stericsson.com>, "Linus Walleij" <linus.walleij@linaro.or=
g>, linux-mmc@vger.kernel.org, "Arnd Bergmann"
> <arnd@arndb.de>, "Jon Medhurst" <tixy@linaro.org>
> Sent: Thursday, October 20, 2011 11:10:02 AM
> Subject: Re: slow eMMC write speed
>=20
> 2011/10/20 Andrei E. Warkentin <andrey.warkentin@gmail.com>:
> > 2011/10/19 Praveen G K <praveen.gk@gmail.com>:
> >> Also, can somebody please tell me the significance of
> >> blk_end_request? Thanks.
> >> Why do we call this after every block read or write?
> >
> > Because you want to update the struct request with the amount
> > written/read. If the entire
> > requested I/O range has been satiffied, blk_end_request also calls
> > blk_finish_request and
> > completes the request.
> Just for a quick understanding, I did the following
>=20
> During every eMMC write, I called the multi block write command with
> the same set of data, and I called the mmc_end_request=20

What's mmc_end_request? I'm assuming you meant blk_end_request.

> after  let's
> say every 10 transfers (with each transfer being 128 blocks).  I
> noticed that I did not see those big busy wait times as frequently as
> compared to calling blk_end_request after every 128 block was
> transferred.  Why is that happening?

So you did 10 back-to-back 64k transfers inside the request handling ro=
utine, and you noticed that caused a smaller GC delay
rather than doing 10 separate multiblock 64k transfers the normal way?

Depends. Maybe mmc_host_lazy_disable() (called by mmc_release_host) end=
s up doing some power management, which is bound
to affect the card as well.

Or maybe the card is trying to optimize consecutive writes into one lar=
ger write internally, and you're crossing some internal
timestamp checking logic that distinguishes between separate and consec=
utive writes. You should talk to your manufacturer, and investigate wha=
t happens to your host on mmc_release_host.

A

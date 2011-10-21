From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: slow eMMC write speed
Date: Fri, 21 Oct 2011 00:45:06 -0400
Message-ID: <CANz0V+6=shJk2_73RETGk7Y55FCKRJgZf__rp72RHh9U6Z9KEQ@mail.gmail.com>
References: <CAHzg1A-E0ziGaO_4ttm6tWBsLZe+cUVt=Cn7Cr8gwC0XA_PSSw@mail.gmail.com>
	<334439217.124350.1319124396858.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<CAHzg1A9SO6s8vabSGcuNWWGswMkF4UB_vRjdgiEN-qtc_GObeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59592 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1JUEpI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 00:45:08 -0400
Received: by wwe6 with SMTP id 6so5147893wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2011 21:45:07 -0700 (PDT)
In-Reply-To: <CAHzg1A9SO6s8vabSGcuNWWGswMkF4UB_vRjdgiEN-qtc_GObeg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: Andrei Warkentin <awarkentin@vmware.com>, J Freyensee <james_p_freyensee@linux.intel.com>, =?UTF-8?Q?Per_F=C3=B6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

2011/10/20 Praveen G K <praveen.gk@gmail.com>:
>>
>> So you did 10 back-to-back 64k transfers inside the request handling=
 routine, and you noticed that caused a smaller GC delay
>> rather than doing 10 separate multiblock 64k transfers the normal wa=
y?
> That's right. =C2=A0Even though the request is supposed to service on=
ly
> 64k, I sent 10 write commands each with 64k and then completed the
> request (within the loop that takes care of the read/writes in
> block.c) with the same data.
>
> So, instead of calling blk_end_request just after one write, I call
> blk_end_request after 10 writes.
>

Well, if you're just writing 10 times the data to the *same* location
(since it's inside the loop), then of course
your noticed GC delay is smaller when compared to writing 10 times to
different locations - the garbage collection happens
when the card notices you are writing to more allocation units than
are cached internally...

A

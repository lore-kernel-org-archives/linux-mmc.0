From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Thu, 20 Oct 2011 09:07:41 -0700
Message-ID: <CAHzg1A9SO6s8vabSGcuNWWGswMkF4UB_vRjdgiEN-qtc_GObeg@mail.gmail.com>
References: <CAHzg1A-E0ziGaO_4ttm6tWBsLZe+cUVt=Cn7Cr8gwC0XA_PSSw@mail.gmail.com>
	<334439217.124350.1319124396858.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-dy0-f46.google.com ([209.85.220.46]:51831 "EHLO
	mail-dy0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab1JTQHn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 12:07:43 -0400
Received: by dyf17 with SMTP id 17so106417dyf.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2011 09:07:42 -0700 (PDT)
In-Reply-To: <334439217.124350.1319124396858.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>, "Andrei E. Warkentin" <andrey.warkentin@gmail.com>

2011/10/20 Andrei Warkentin <awarkentin@vmware.com>:
> ----- Original Message -----
>> From: "Praveen G K" <praveen.gk@gmail.com>
>> To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
>> Cc: "J Freyensee" <james_p_freyensee@linux.intel.com>, "Andrei Warke=
ntin" <awarkentin@vmware.com>, "Per F=F6rlin"
>> <per.forlin@stericsson.com>, "Linus Walleij" <linus.walleij@linaro.o=
rg>, linux-mmc@vger.kernel.org, "Arnd Bergmann"
>> <arnd@arndb.de>, "Jon Medhurst" <tixy@linaro.org>
>> Sent: Thursday, October 20, 2011 11:10:02 AM
>> Subject: Re: slow eMMC write speed
>>
>> 2011/10/20 Andrei E. Warkentin <andrey.warkentin@gmail.com>:
>> > 2011/10/19 Praveen G K <praveen.gk@gmail.com>:
>> >> Also, can somebody please tell me the significance of
>> >> blk_end_request? Thanks.
>> >> Why do we call this after every block read or write?
>> >
>> > Because you want to update the struct request with the amount
>> > written/read. If the entire
>> > requested I/O range has been satiffied, blk_end_request also calls
>> > blk_finish_request and
>> > completes the request.
>> Just for a quick understanding, I did the following
>>
>> During every eMMC write, I called the multi block write command with
>> the same set of data, and I called the mmc_end_request
>
> What's mmc_end_request? I'm assuming you meant blk_end_request.
Yes, you are right.  I meant blk_end_request.

>> after =A0let's
>> say every 10 transfers (with each transfer being 128 blocks). =A0I
>> noticed that I did not see those big busy wait times as frequently a=
s
>> compared to calling blk_end_request after every 128 block was
>> transferred. =A0Why is that happening?
>
> So you did 10 back-to-back 64k transfers inside the request handling =
routine, and you noticed that caused a smaller GC delay
> rather than doing 10 separate multiblock 64k transfers the normal way=
?
That's right.  Even though the request is supposed to service only
64k, I sent 10 write commands each with 64k and then completed the
request (within the loop that takes care of the read/writes in
block.c) with the same data.

So, instead of calling blk_end_request just after one write, I call
blk_end_request after 10 writes.

> Depends. Maybe mmc_host_lazy_disable() (called by mmc_release_host) e=
nds up doing some power management, which is bound
> to affect the card as well.
>
> Or maybe the card is trying to optimize consecutive writes into one l=
arger write internally, and you're crossing some internal
> timestamp checking logic that distinguishes between separate and cons=
ecutive writes. You should talk to your manufacturer, and investigate w=
hat happens to your host on mmc_release_host.
>
> A
>

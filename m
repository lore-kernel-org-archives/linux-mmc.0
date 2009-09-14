From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Mon, 14 Sep 2009 10:39:44 +0200
Message-ID: <c4e36d110909140139u786f2165oc5a35dce5b2c0527@mail.gmail.com>
References: <20090903232317.GA6760@lst.de>
	 <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com>
	 <m3eiqdqfnm.fsf@pullcord.laptop.org> <200909120036.41725.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40321 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZINIjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2009 04:39:42 -0400
In-Reply-To: <200909120036.41725.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Ball <cjb@laptop.org>, Pavel Machek <pavel@ucw.cz>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

2009/9/12 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday 12 September 2009, Chris Ball wrote:
>> Hi,
>>
>> =A0 =A0> Well system could check basic card ids if they match after =
resume
>>
>> No. =A0That (arguably) guarantees that it's the same card, but not t=
hat
>> it wasn't modified in another machine during the suspend.
>
> Generally speaking, we'd also need to check superblocks for this to w=
ork.
>
>> =A0 =A0> if some users wants to crash his card by randomly swapping =
it
>> =A0 =A0> during suspend/resume - I'd have no problem with that....
>>
>> You should have a problem with it. =A0Taking a card from a suspended
>> machine and working on it with a different machine is not a bizarre
>> thing to want to do.
>
> Agreed.


Well - ok - so let me ask this question - if I'll replace local hard
drive during suspend - what will happen - is this prohibited by hw
(e.i. to switch SATA cables) ?

IMHO filesystem should be able to detect corruption of its data
structures - (assuming fs is notified about suspend/resume operation)

Also there could be one simple quick solution/hack - to require to
have at least all remote drives unmounted - so suspend would be
refused if it runs mounted card/usb drive -  this would be 100% better
than current solution which effectively kills my laptop if I forget to
unmount card in mmc reader - especially if dmesg contains message with
the reason why my suspend fails.


Zdenek

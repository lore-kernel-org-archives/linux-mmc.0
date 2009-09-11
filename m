From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Fri, 11 Sep 2009 23:14:08 +0200
Message-ID: <c4e36d110909111414n716a06b1mdd0cd741230595b5@mail.gmail.com>
References: <c4e36d110909010234i5f1b9357l805132137725a4f8@mail.gmail.com>
	 <20090903232317.GA6760@lst.de> <87ljkvmt71.fsf@devron.myhome.or.jp>
	 <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
	 <87iqfx5mss.fsf@devron.myhome.or.jp> <20090907125130.GA1595@ucw.cz>
	 <87ljko5k3v.fsf@devron.myhome.or.jp>
	 <20090910192354.GD23356@elf.ucw.cz>
	 <87bplim1ce.fsf@devron.myhome.or.jp>
	 <20090911200922.GF8137@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:52160 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877AbZIKVOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2009 17:14:06 -0400
In-Reply-To: <20090911200922.GF8137@elf.ucw.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

2009/9/11 Pavel Machek <pavel@ucw.cz>:
>
>> Um..., sorry, I'm not sure what are you talking about. Of course, th=
e
>> problem of this is that system freeze on suspend.
>>
>> Or are you asking my guess of the cause, or something? =A0If so, alt=
hough
>> I'm not reading all emails on this thread, from Zdenek's backtrace, =
the
>> sequence would be
>>
>> =A0 =A0 1) suspend mmc
>> =A0 =A0 2) mmc generates card removed event
>> =A0 =A0 3) prepare to invalidate blockdev
>> =A0 =A0 4) sync fs on invalidating blockdev
>> =A0 =A0 5) flush buffers on invalidating blockdev (partitions)
>> =A0 =A0 6) delete blockdev (partitions)
>>
>> or like the above. And I can guess some possible issues/root-cause w=
e
>> have to handle from it.
>>
>> =A0 =A0 a) card removed event from mmc for suspend is right design?
>> =A0 =A0 b) the card can be changed/removed before system was resumed=
, mmc
>> =A0 =A0 =A0 =A0can be detect/handle it properly?
>> =A0 =A0 c) flushing buffers on _deleted_ device is right design?
>>
>> and I suspect there are more issues in detail and resume process tho=
ugh.
>
> I guess c) is main problem. If device is not there, how do you want t=
o
> flush buffers on it?
>

Well I do not even understand why someone wants to sync something when
card is removed ??
And why suspend of mmc should generate card removal ??

IMHO steps 2..6 are only valid for the case I would 'remove'
unexpectedly card - but
if I suspend and resume my laptop and I keep the card inside - all
those step looks plain wrong.

Zdenek

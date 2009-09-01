From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Tue, 1 Sep 2009 11:34:04 +0200
Message-ID: <c4e36d110909010234i5f1b9357l805132137725a4f8@mail.gmail.com>
References: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com>
	 <200908312119.12121.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:42847 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbZIAJeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2009 05:34:04 -0400
In-Reply-To: <200908312119.12121.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

2009/8/31 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday 31 August 2009, Zdenek Kabelac wrote:
>> Hi
>>
>> I've noticed that my machine freezes while doing s2r and having
>> mounted filesystem from SD card.
>>
>> My system: Lenovo T61, 4GB, C2D, kernel 2.6.31-rc8
>>
>> Here is the trace of =A0suspend when SD card is inserted, follows re=
sume
>> and again suspend and this time with mounted filesystem from SD card=
=2E
>>
>> System locks with: PM: Removing info for mmc:mmc0:b368
>> Also btusb_bulk_complete: errors are interesting - I've noticed few
>> bugzillas in the google.
>> I could try bisect to find the patch - but it will take time....
>> So hopefully this trace will help.
>
> Not really. :-(
>
> Is this a new regression in 2.6.31-rc, or does 2.6.30 also fail?
>

Well - all I know for now is this:  v2.6.30 goes to suspend (i.e.
machine turns to sleep), but resume fails - I do not get a single line
of output on serial console either - so it's hard to tell whether it
works or not - before suspend there are some INFO traces about lockdep
problems in cpu frequency.   v2.6.31-rc1 doesn't boot on my machine.
v2.6.31-rc2 seems to lock on suspend so this version is already
definitely broken. I may try to do some bisecting between these
kernels - but it might probably easily lead to some dead-ends probably
:(...
Also I'm using  mmc debugs for compilation of these kernels - but
nothing seems to printed from mmc subsystem at the end of suspend log
and the end is still the same - last printed lines:

 mmc0: card b368 removed
 PM: Removing info for mmc:mmc0:b368

Zdenek

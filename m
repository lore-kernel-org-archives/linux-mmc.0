From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: About mmc delayed workqueue.
Date: Wed, 30 Mar 2011 14:10:25 +0900
Message-ID: <AANLkTin3YKGuPT4sSPXaNbwcBWHYw8nOL+wBSR9pB9EE@mail.gmail.com>
References: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
	<20110329233459.GI27290@trinity.fluff.org>
	<m3sju58pap.fsf@pullcord.laptop.org>
	<AANLkTi=5R9w0k_Hg=htyDc=aQDA+t1HOLvWtfAOvMo+z@mail.gmail.com>
	<m3k4fh8i8o.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46739 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1C3FK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 01:10:27 -0400
Received: by wwk4 with SMTP id 4so3639743wwk.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 22:10:26 -0700 (PDT)
In-Reply-To: <m3k4fh8i8o.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Dear. Chris.

kernel is blocking during 5sec included mmc initializing by root_delay.

I think root_wait is better the solution than rootdelay.

Thanks for your advice.


2011/3/30 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Tue, Mar 29 2011, NamJae Jeon wrote:
>> Dear. Chris, Ben.
>>
>> Thanks for your reply.
>>
>> As you know, booting time is important factor in embededd device.
>>
>> If rootdelay is set to 5, kernel will be waiting for 5 sec. root_wai=
t
>> is also looping per 100ms.
>
> No. =A0It will wait for *up to* five seconds, but it will actually
> continue as soon as the device has enumerated. =A0Same with rootwait,
> of course.
>
> MMC is by no means the only subsystem that behaves this way. =A0If yo=
u
> were using a USB or SATA/AHCI device, amongst many others, you would
> have exactly the same problem.
>
> You can see http://lwn.net/Articles/330378/ for some background readi=
ng.
>
>> I have a question. Why is =A0mmc using delayed workqueue ?
>
> So that device enumeration can happen in the background, without
> delaying the kernel boot while we wait for the controller to get all
> the way to creating partitions.
>
> If we didn't use a workqueue and you were working on an embedded proj=
ect
> that had an MMC slot that it *didn't* boot from, you'd be yelling at =
us
> for instead wasting time holding up your non-mmc boot by not letting
> userspace get going until we list MMC partitions. =A0We can't win. =A0=
:-)
>
> In any case, I suspect that your system actually does boot faster tha=
n
> it would if we didn't use a workqueue -- this way the delays in waiti=
ng
> for the controller to come up are parallelized with other boot code.
> That's good, right?
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

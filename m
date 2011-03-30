From: Chris Ball <cjb@laptop.org>
Subject: Re: About mmc delayed workqueue.
Date: Tue, 29 Mar 2011 22:17:11 -0400
Message-ID: <m3k4fh8i8o.fsf@pullcord.laptop.org>
References: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
	<20110329233459.GI27290@trinity.fluff.org>
	<m3sju58pap.fsf@pullcord.laptop.org>
	<AANLkTi=5R9w0k_Hg=htyDc=aQDA+t1HOLvWtfAOvMo+z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43144 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148Ab1C3CLM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Mar 2011 22:11:12 -0400
In-Reply-To: <AANLkTi=5R9w0k_Hg=htyDc=aQDA+t1HOLvWtfAOvMo+z@mail.gmail.com>
	(NamJae Jeon's message of "Wed, 30 Mar 2011 09:26:53 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On Tue, Mar 29 2011, NamJae Jeon wrote:
> Dear. Chris, Ben.
>
> Thanks for your reply.
>
> As you know, booting time is important factor in embededd device.
>
> If rootdelay is set to 5, kernel will be waiting for 5 sec. root_wait
> is also looping per 100ms.

No.  It will wait for *up to* five seconds, but it will actually
continue as soon as the device has enumerated.  Same with rootwait,
of course.

MMC is by no means the only subsystem that behaves this way.  If you
were using a USB or SATA/AHCI device, amongst many others, you would
have exactly the same problem.

You can see http://lwn.net/Articles/330378/ for some background reading.

> I have a question. Why is  mmc using delayed workqueue ?

So that device enumeration can happen in the background, without
delaying the kernel boot while we wait for the controller to get all
the way to creating partitions.

If we didn't use a workqueue and you were working on an embedded project
that had an MMC slot that it *didn't* boot from, you'd be yelling at us
for instead wasting time holding up your non-mmc boot by not letting
userspace get going until we list MMC partitions.  We can't win.  :-)

In any case, I suspect that your system actually does boot faster than
it would if we didn't use a workqueue -- this way the delays in waiting
for the controller to come up are parallelized with other boot code.
That's good, right?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

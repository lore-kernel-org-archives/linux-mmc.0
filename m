From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Sun, 23 Oct 2011 02:38:53 -0400
Message-ID: <m2r5245i0y.fsf@bob.laptop.org>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
	<m2vcrh55lm.fsf@bob.laptop.org>
	<CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57204 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010Ab1JWGjD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 Oct 2011 02:39:03 -0400
In-Reply-To: <CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com>
	(Sebastian Rasmussen's message of "Sun, 23 Oct 2011 02:51:13 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>, linux-mmc@vger.kernel.org

Hi Sebastian,

On Sat, Oct 22 2011, Sebastian Rasmussen wrote:
> Hi!
>
>> What we're worried about is someone issuing the perm read-only command,
>> and not realizing that it really means that they can never ever write
>> any more changes to their eMMC -- it's a one-time fuse
>
> I can see why you are worried that people may brick their devices.
> How about only adding the read-only-until-power-cycled command?

I think that makes sense.  I'd be curious to hear if anyone thinks we
shouldn't even add that command, perhaps on grounds that "the kernel
shouldn't be enthusiastic about locking itself out of future access to
a device" or similar.  As you say, the ioctl interface would still work.

>> I'd rather leave it to specialized manufacturing equipment.
>
> Sure, but then again permanent read-only commands seem to be
> able to be sent by writing a userspace tool that issues a ioctl(fd, 0xb3, ...)
> using the generic command interface by John Calixto mentioned by
> Andrei. I assume that what reassures you in this case is
> that CAP_SYS_RAWIO is required and perhaps also obscurity?

Yes, that's right -- running a userspace program that you explicitly
downloaded from somewhere and compiled is more intentional than
wondering what a kernel argument or sysfs node does and trying it.
(Maybe I'm special, but I often use kernel arguments and sysfs nodes
without reading their code or finding the best documentation for them
first, when trying to get something to work.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

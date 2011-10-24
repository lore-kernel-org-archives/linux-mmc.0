From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Mon, 24 Oct 2011 11:23:30 +0200
Message-ID: <4EA52E92.1010406@stericsson.com>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>	<m24nz171vj.fsf@bob.laptop.org>	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>	<m2vcrh55lm.fsf@bob.laptop.org>	<CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com> <m2r5245i0y.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:54619 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753961Ab1JXJYM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 05:24:12 -0400
In-Reply-To: <m2r5245i0y.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Sebastian Rasmussen <sebras@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan RUDHOLM <johan.rudholm@stericsson.com>, John BECKETT <john.beckett@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Chris Ball wrote:
> Hi Sebastian,
> 
> On Sat, Oct 22 2011, Sebastian Rasmussen wrote:
>> Hi!
>>
>>> What we're worried about is someone issuing the perm read-only command,
>>> and not realizing that it really means that they can never ever write
>>> any more changes to their eMMC -- it's a one-time fuse
>> I can see why you are worried that people may brick their devices.
>> How about only adding the read-only-until-power-cycled command?
> 
> I think that makes sense.  I'd be curious to hear if anyone thinks we
> shouldn't even add that command, perhaps on grounds that "the kernel
> shouldn't be enthusiastic about locking itself out of future access to
> a device" or similar.  As you say, the ioctl interface would still work.
> 
>>> I'd rather leave it to specialized manufacturing equipment.
>> Sure, but then again permanent read-only commands seem to be
>> able to be sent by writing a userspace tool that issues a ioctl(fd, 0xb3, ...)
>> using the generic command interface by John Calixto mentioned by
>> Andrei. I assume that what reassures you in this case is
>> that CAP_SYS_RAWIO is required and perhaps also obscurity?
> 
> Yes, that's right -- running a userspace program that you explicitly
> downloaded from somewhere and compiled is more intentional than
> wondering what a kernel argument or sysfs node does and trying it.
> (Maybe I'm special, but I often use kernel arguments and sysfs nodes
> without reading their code or finding the best documentation for them
> first, when trying to get something to work.)

The kernel could very much be used in manufacturing environment as well. 
Don't know if and how we should consider this.

Do you think a change to an ioctl is a better alternative than sysfs? 
Then let's change to that!

BR
Ulf Hansson



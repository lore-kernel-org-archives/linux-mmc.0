From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
Date: Fri, 18 Mar 2011 20:25:13 +0100
Message-ID: <201103182025.14036.arnd@arndb.de>
References: <201103172255.51442.arnd@arndb.de> <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01> <alpine.DEB.2.00.1103180927390.5267@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57164 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1CRTZR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 15:25:17 -0400
In-Reply-To: <alpine.DEB.2.00.1103180927390.5267@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Friday 18 March 2011 18:32:41 John Calixto wrote:
> I started down that route, but part of the problem with putting any more
> than a simple passthrough in kernel space is that the CPRM algorithms
> live in the next highest logic layer, and 4C licensees are not allowed
> to reveal those algorithms.  If you have access to the SD Specification,
> you will see that it documents all of the individual security commands.
> However, the sequence of commands is documented in the 4C CPRM
> Specification.

Implementing this without revealing the algorithm is hardly possible:
As soon as there is an implementation in binary form, someone can
reverse-engineer and document it, and then we can write a proper
implementation in the kernel. The question is whether we can skip
this detour and get the correct implementation right-away ;-)

Since you have already signed an NDA, you can obviously not
send the implementation for this, but someone else could
fill in the blanks.

> Installing this passthrough also has the added benefit of allowing
> other, non-security-related, application specific commands to be sent.

Yes, I understand that part, and I think that's good, although
it would still be better to do the CPRM stuff in the kernel,
as I said.

> > A few more comments about the implementation below.
> >
> > > Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621 SoC, TI
> > > OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
> >
> > Is this safe to do while the device is operating and a file system
> > writes data?
> 
> If you mean:
> 
>     Is it safe for one process to write data to the User Area (i.e. the
>     non-secure part; the normal use case for SD as unencrypted storage),
>     while another process issues secure commands?
> 
> then, no, it is not.  Should I try and protect against this in the
> kernel driver?

I guess that would be better. You cannot really stop the kernel
from issuing block commands on a mounted file system from user
space, which appears to be required here.

> If you mean:
> 
>     Can a program use both the User Area and the Protected Area?
> 
> then, yes, it can.  In broad terms, the typical program would:
> 
>     - mount /dev/mmcblk0p1 /mnt/sdcard
>     - find encrypted file /mnt/sdcard/encrypted_blob
>     - issue secure commands via ioctl() to /dev/mmcblk0p1 to find
>       decryption keys; no need to umount
>     - decrypt /mnt/sdcard/encrypted_blob using keys retrieved above

What if /dev/mmcblk0 contains your root file system and/or
swap space, and the program that uses ioctl here happens
to be paged out?

You may get into a situation where the card is owned by the
program that needs to complete talking to it before the kernel
can do more block commands, but the program cannot continue until
the block driver reads back the program .text section from the
card.

> > Does it allow sending all commands or just the ones you require?
> >
> 
> I did not choose to filter out commands.  I expected that other folks
> might want to send other ACMDs.

What about regular commands, read/write/erase or the more
sophisticated ones? We might not want to do those on a mounted
card, but it would be useful for the case where you pass through
a real SD card to a virtual machine using qemu.

	Arnd

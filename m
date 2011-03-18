From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMD
Date: Fri, 18 Mar 2011 15:06:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103181332310.6084@peruna>
References: <201103172255.51442.arnd@arndb.de> <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01> <alpine.DEB.2.00.1103180927390.5267@peruna> <201103182025.14036.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:40986 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932837Ab1CRWUN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 18:20:13 -0400
In-Reply-To: <201103182025.14036.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Fri, 18 Mar 2011, Arnd Bergmann wrote:
> On Friday 18 March 2011 18:32:41 John Calixto wrote:
> > I started down that route, but part of the problem with putting any more
> > than a simple passthrough in kernel space is that the CPRM algorithms
> > live in the next highest logic layer, and 4C licensees are not allowed
> > to reveal those algorithms.  If you have access to the SD Specification,
> > you will see that it documents all of the individual security commands.
> > However, the sequence of commands is documented in the 4C CPRM
> > Specification.
> 
> Implementing this without revealing the algorithm is hardly possible:
> As soon as there is an implementation in binary form, someone can
> reverse-engineer and document it, and then we can write a proper
> implementation in the kernel. The question is whether we can skip
> this detour and get the correct implementation right-away ;-)
> 

Certainly, physical access to any device makes reverse engineering of
any of these 'security' techniques possible to anyone with time and
patience.  That said, I am not in a position to help with this - Sorry!

> Since you have already signed an NDA, you can obviously not
> send the implementation for this, but someone else could
> fill in the blanks.
> 
> > Installing this passthrough also has the added benefit of allowing
> > other, non-security-related, application specific commands to be sent.
> 
> Yes, I understand that part, and I think that's good, although
> it would still be better to do the CPRM stuff in the kernel,
> as I said.
> 

This is a matter to take up with the 4C.  Looking at the rest of the
MMC/SD code in the kernel, it appears that somebody with access to the
SD specs got permission to implement what we have now.  Perhaps they
could help with filling in the blanks?  IANAL, so the patch I am
submitting does not include proprietary elements.  However, it does
allow anyone with access to the specs a way to use what they know.

> > > A few more comments about the implementation below.
> > >
> > > > Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621 SoC, TI
> > > > OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
> > >
> > > Is this safe to do while the device is operating and a file system
> > > writes data?
> > 
> > If you mean:
> > 
> >     Is it safe for one process to write data to the User Area (i.e. the
> >     non-secure part; the normal use case for SD as unencrypted storage),
> >     while another process issues secure commands?
> > 
> > then, no, it is not.  Should I try and protect against this in the
> > kernel driver?
> 
> I guess that would be better. You cannot really stop the kernel
> from issuing block commands on a mounted file system from user
> space, which appears to be required here.
> 

Actually, I got ahead of myself in my initial response.  I believe I
already protected against concurrent access with mmc_claim_host().

> > If you mean:
> > 
> >     Can a program use both the User Area and the Protected Area?
> > 
> > then, yes, it can.  In broad terms, the typical program would:
> > 
> >     - mount /dev/mmcblk0p1 /mnt/sdcard
> >     - find encrypted file /mnt/sdcard/encrypted_blob
> >     - issue secure commands via ioctl() to /dev/mmcblk0p1 to find
> >       decryption keys; no need to umount
> >     - decrypt /mnt/sdcard/encrypted_blob using keys retrieved above
> 
> What if /dev/mmcblk0 contains your root file system and/or
> swap space, and the program that uses ioctl here happens
> to be paged out?
> 
> You may get into a situation where the card is owned by the
> program that needs to complete talking to it before the kernel
> can do more block commands, but the program cannot continue until
> the block driver reads back the program .text section from the
> card.
> 

Having used mmc_claim_host() (see my previous comment above), the ioctl
should complete before the kernel gets a chance to page the program out
shouldn't it?

> > > Does it allow sending all commands or just the ones you require?
> > >
> > 
> > I did not choose to filter out commands.  I expected that other folks
> > might want to send other ACMDs.
> 
> What about regular commands, read/write/erase or the more
> sophisticated ones? We might not want to do those on a mounted
> card, but it would be useful for the case where you pass through
> a real SD card to a virtual machine using qemu.
> 
> 	Arnd

The patch is only for ACMDs for now.  When calling the ioctl with
cmd=SD_IOC_ACMD, it implies you expect CMD55 to be sent *before* sending
your command.  There are specs that describe the values and behaviours
of ACMDs.  You'll find that the SD card's state machine is pretty
resilient, and that apps that are messing with tossing garbage ACMDs in
should expect garbage back out.

I expect for more general purposes, like your qemu passthrough case, you
would want to add a handler for cmd=SD_IOC_CMD?

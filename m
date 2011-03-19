From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMD
Date: Sat, 19 Mar 2011 12:52:49 +0100
Message-ID: <201103191252.49490.arnd@arndb.de>
References: <201103172255.51442.arnd@arndb.de> <201103182025.14036.arnd@arndb.de> <alpine.DEB.2.00.1103181332310.6084@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49546 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1CSLw5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Mar 2011 07:52:57 -0400
In-Reply-To: <alpine.DEB.2.00.1103181332310.6084@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Friday 18 March 2011, John Calixto wrote:
> On Fri, 18 Mar 2011, Arnd Bergmann wrote:
> > On Friday 18 March 2011 18:32:41 John Calixto wrote:
> > > I started down that route, but part of the problem with putting any more
> > > than a simple passthrough in kernel space is that the CPRM algorithms
> > > live in the next highest logic layer, and 4C licensees are not allowed
> > > to reveal those algorithms.  If you have access to the SD Specification,
> > > you will see that it documents all of the individual security commands.
> > > However, the sequence of commands is documented in the 4C CPRM
> > > Specification.
> > 
> > Implementing this without revealing the algorithm is hardly possible:
> > As soon as there is an implementation in binary form, someone can
> > reverse-engineer and document it, and then we can write a proper
> > implementation in the kernel. The question is whether we can skip
> > this detour and get the correct implementation right-away ;-)
> > 
> 
> Certainly, physical access to any device makes reverse engineering of
> any of these 'security' techniques possible to anyone with time and
> patience.  That said, I am not in a position to help with this - Sorry!

I understand your problem.

> > Since you have already signed an NDA, you can obviously not
> > send the implementation for this, but someone else could
> > fill in the blanks.
> > 
> > > Installing this passthrough also has the added benefit of allowing
> > > other, non-security-related, application specific commands to be sent.
> > 
> > Yes, I understand that part, and I think that's good, although
> > it would still be better to do the CPRM stuff in the kernel,
> > as I said.
> > 
> 
> This is a matter to take up with the 4C.  Looking at the rest of the
> MMC/SD code in the kernel, it appears that somebody with access to the
> SD specs got permission to implement what we have now.  Perhaps they
> could help with filling in the blanks?  IANAL, so the patch I am
> submitting does not include proprietary elements.  However, it does
> allow anyone with access to the specs a way to use what they know.

Many of the SD specifications have redacted versions that allow
us to write OS drivers. For instance there is
http://www.sdcard.org/developers//tech/sdcard/pls/simplified_specs/Part_A1_ASSD_Extension_Simplified_Specification_Ver2.00_Final_100518.pdf
that describes some of the "advanced security SD" card 

> > I guess that would be better. You cannot really stop the kernel
> > from issuing block commands on a mounted file system from user
> > space, which appears to be required here.
> > 
> 
> Actually, I got ahead of myself in my initial response.  I believe I
> already protected against concurrent access with mmc_claim_host().

Ok, so is the protocol designed in a way that you don't need to
mmc_claim_host() across multiple ACMDs to do CPRM?

> > You may get into a situation where the card is owned by the
> > program that needs to complete talking to it before the kernel
> > can do more block commands, but the program cannot continue until
> > the block driver reads back the program .text section from the
> > card.
> > 
> 
> Having used mmc_claim_host() (see my previous comment above), the ioctl
> should complete before the kernel gets a chance to page the program out
> shouldn't it?

Right. But is that enough? The qeustion is whether the card may be
in a state where it's expecting another ACMD after the first ioctl
and cannot deal with regular block commands.

> The patch is only for ACMDs for now.  When calling the ioctl with
> cmd=SD_IOC_ACMD, it implies you expect CMD55 to be sent *before* sending
> your command.  There are specs that describe the values and behaviours
> of ACMDs.  You'll find that the SD card's state machine is pretty
> resilient, and that apps that are messing with tossing garbage ACMDs in
> should expect garbage back out.
> 
> I expect for more general purposes, like your qemu passthrough case, you
> would want to add a handler for cmd=SD_IOC_CMD?

Yes, but I suspect that would mean blocking all other activity on the
same device, possibly with an ioctl for claiming the host for an
extended period of time.

	Arnd

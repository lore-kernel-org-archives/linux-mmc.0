From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMD
Date: Sat, 19 Mar 2011 19:12:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103191849040.13315@peruna>
References: <201103172255.51442.arnd@arndb.de> <201103182025.14036.arnd@arndb.de> <alpine.DEB.2.00.1103181332310.6084@peruna> <201103191252.49490.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:34962 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187Ab1CTCNC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Mar 2011 22:13:02 -0400
In-Reply-To: <201103191252.49490.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

On Sat, 19 Mar 2011, Arnd Bergmann wrote:
> Many of the SD specifications have redacted versions that allow
> us to write OS drivers. For instance there is
> http://www.sdcard.org/developers//tech/sdcard/pls/simplified_specs/Part_A1_ASSD_Extension_Simplified_Specification_Ver2.00_Final_100518.pdf
> that describes some of the "advanced security SD" card 

Thanks for the reference.  I was not aware of those docs.  Note that
anything related to CPRM is redacted.  I suspect it's because it's a
separate organization that actually publishes and licenses the CPRM
specs - the 4C Entity, LLC.  I agree with you that it would be ideal for
us if we could include much of the CPRM code directly into the kernel,
but I don't see how that's possible at this time.

> Ok, so is the protocol designed in a way that you don't need to
> mmc_claim_host() across multiple ACMDs to do CPRM?
> 
> > > You may get into a situation where the card is owned by the
> > > program that needs to complete talking to it before the kernel
> > > can do more block commands, but the program cannot continue until
> > > the block driver reads back the program .text section from the
> > > card.
> > > 
> > 
> > Having used mmc_claim_host() (see my previous comment above), the ioctl
> > should complete before the kernel gets a chance to page the program out
> > shouldn't it?
> 
> Right. But is that enough? The qeustion is whether the card may be
> in a state where it's expecting another ACMD after the first ioctl
> and cannot deal with regular block commands.
> 

I see your point.  The card certainly will not allow access to the
secure area if you interleave secure commands with regular, non-secure
commands - Failed secure ops would be the immediately observable
behaviour that I would expect.  However, I am not sure about the
potential negative effects on the regular block operations.  I will go
back and specifically test for these scenarios.  Though I must say that
in the thousands of hours of manual and automated testing, and at least
hundreds of hours of use by end-users, this patch has held its own.

Again, I will go back and specifically focus on breaking regular block
operations with interleaved injections of ACMDs using this ioctl.

> > The patch is only for ACMDs for now.  When calling the ioctl with
> > cmd=SD_IOC_ACMD, it implies you expect CMD55 to be sent *before* sending
> > your command.  There are specs that describe the values and behaviours
> > of ACMDs.  You'll find that the SD card's state machine is pretty
> > resilient, and that apps that are messing with tossing garbage ACMDs in
> > should expect garbage back out.
> > 
> > I expect for more general purposes, like your qemu passthrough case, you
> > would want to add a handler for cmd=SD_IOC_CMD?
> 
> Yes, but I suspect that would mean blocking all other activity on the
> same device, possibly with an ioctl for claiming the host for an
> extended period of time.
> 

Sure.  And if the testing I described above shows that regular block
operations are indeed negatively affected, then I'll have to implement
that ioctl for claiming the host myself and you'll have a head start! :)

John

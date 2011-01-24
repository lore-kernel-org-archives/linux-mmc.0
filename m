From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Mon, 24 Jan 2011 16:08:29 +0000
Message-ID: <1295885309.1677.21.camel@apple-mac>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	 <20101116150022.GA27726@void.printf.net>
	 <27884BED0E3C489C8849EE12A803F536@AN00536>
	 <m3oc9pnt6g.fsf@pullcord.laptop.org>
	 <4CE41BE3.1060806@elandigitalsystems.com>
	 <m3oc9n241c.fsf@pullcord.laptop.org>
	 <4CEA86D4.9050109@elandigitalsystems.com>
	 <1295607004.1816.6.camel@apple-mac>
	 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
	 <1295858946.1677.3.camel@apple-mac>
	 <alpine.LFD.2.00.1101240936260.8580@xanadu.home>
	 <1295881846.1677.9.camel@apple-mac>
	 <alpine.LFD.2.00.1101241051460.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65394 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab1AXQIo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 11:08:44 -0500
In-Reply-To: <alpine.LFD.2.00.1101241051460.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

On Mon, 2011-01-24 at 10:55 -0500, Nicolas Pitre wrote:
> On Mon, 24 Jan 2011, Tony Olech wrote:
> 
> > On Mon, 2011-01-24 at 09:43 -0500, Nicolas Pitre wrote:
> > > Uninitialized global scope variables are by definition assigned to the 
> > > .bss section.  The .bss section is dynamically allocated at run time 
> > > rather than being stored in the compiled binary, and also cleared to 
> > > zero at run time.  So the preference is for zero-initialized global 
> > > variables not to be initialized at all because 1) they are implicitly 
> > > initialized to zero anyway, and 2) that makes the resulting binaries 
> > > smaller.
> > > So this is not about fixing a bug, but rather to conform to the adopted 
> > > policy for kernel code.
> > > Nicolas
> > Thanks for the reply. I had not realized that saving 20 bytes on the
> > binary size was so important.
> With the size of the kernel they add up.
> > How then can one do static code analysis
> > to determine which uninitialized variables are uninitialized as
> > a result of a bug?
> A good static code analysis tool should know already that uninitialized 
> global variables are implicitly initialized to zero.  This is not the 
> case for local variables of course
> Nicolas
Thanks for the reply.
I had assumed that for a module the global initialized variables were
loaded at module load. That then is a problem given that new devices
(and drivers) are appearing quite rapidly. I therefore do not understand
how the global initialized variables from an externally compiled kernel
module get added into the kernel image - does "depmod" do that?
A good static code analysis tool surely can only show a list of
uninitialized static global variables leaving it for the user to
trawl through and decide which are OK and which are not - so much
easier if one has no uninitialized static global variables to start
with.
Tony Olech



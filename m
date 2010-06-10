From: Mark Hills <mark@pogo.org.uk>
Subject: Re: SD card on Dell D420 (Ricoh R5C822)
Date: Thu, 10 Jun 2010 23:54:22 +0100 (BST)
Message-ID: <alpine.NEB.2.01.1006102345450.23786@jrf.vwaro.pbz>
References: <alpine.NEB.2.01.1006100007290.6369@jrf.vwaro.pbz>  <m3r5kfg1us.fsf@pullcord.laptop.org>  <alpine.NEB.2.01.1006100902200.15823@jrf.vwaro.pbz>  <1276162780.18013.3.camel@dell20>  <alpine.NEB.2.01.1006102243010.10395@jrf.vwaro.pbz>
 <1276208162.3113.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:65235 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751145Ab0FJWyY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 18:54:24 -0400
In-Reply-To: <1276208162.3113.4.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, 11 Jun 2010, Maxim Levitsky wrote:

> On Thu, 2010-06-10 at 22:54 +0100, Mark Hills wrote: 
> > On Thu, 10 Jun 2010, Maxim Levitsky wrote:
[...] 
> > > Did you do a suspend/resume cycle before this test?
> > 
> > No, I didn't suspect or resume the laptop. The dmesg is from a cold 
> > reboot, where I let the machine boot, then inserted the card (and the same 
> > in the previous email)
> 
> In fact, you need to undo the work of CONFIG_MMC_RICOH_MMC you need to
> shutdown the system and then boot into kernel that hasn't this option.
> But anyway, I don't think its to blame.

Sorry, perhaps I wasn't clear. I did a full kernel compile, installing it 
and the new modules (without CONFIG_MMC_RICOH_MMC), then I re-booted and 
tried again to produce the new dmesg.
 
> Thanks for kernel log I hope I get enough clues from it.
> I am interested in this problem because this isn't first time I seen it.

Okay, well it is promising that you think it should be working. Good luck 
finding any clues.
 
> It might be related to too high clock or hispeed mode that card doesn't
> support.
> 
> As suggested, try 'debug_quirks=1' too.

I have tried with and without this, with the same error.
 
> Best regards,
> Maxim Levitsky

-- 
Mark

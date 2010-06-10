From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: SD card on Dell D420 (Ricoh R5C822)
Date: Thu, 10 Jun 2010 12:39:40 +0300
Message-ID: <1276162780.18013.3.camel@dell20>
References: <alpine.NEB.2.01.1006100007290.6369@jrf.vwaro.pbz>
	 <m3r5kfg1us.fsf@pullcord.laptop.org>
	 <alpine.NEB.2.01.1006100902200.15823@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46223 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab0FJJjs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 05:39:48 -0400
Received: by bwz7 with SMTP id 7so6579bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2010 02:39:46 -0700 (PDT)
In-Reply-To: <alpine.NEB.2.01.1006100902200.15823@jrf.vwaro.pbz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, 2010-06-10 at 09:08 +0100, Mark Hills wrote:
> On Wed, 9 Jun 2010, Chris Ball wrote:
> 
> > Hi Mark,
> > 
> >    >   mmc0: error -84 whilst initialising SD card
> > 
> > Not sure how much this'll help, but:
> > 
> > errno -84 is defined in include/asm-generic/errno.h as EILSEQ, and
> > there are two occurences of EILSEQ in sdhci.c, one of which has a
> > printk next to it that you aren't seeing.  So, it's likely that you're
> > seeing:
> > 
> >     else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX))
> >         host->cmd->error = -EILSEQ;
> > 
> > So, it seems like your controller is returning a successful command
> > response, but with some sort of data error attached.  Have you tried
> > multiple SD cards, and are they known-working?
> 
> I have two SD cards -- a 2GB Crucial, and a 32MB Sandisk (actually a 
> micro-SD in an adaptor). Both cards work in a USB card reader with the 
> same kernel, and in my digital radio.
>  
> > If you're sure it's not the card, try passing debug_quirks=1 to the
> > sdhci module.  (Let me know if you're not sure how to do that.)
> 
> I've tried this with 2.6.35-rc2, and the result is the same. I also diff'd 
> the dmesg, with no relevant differences.

Could you disable the CONFIG_MMC_RICOH_MMC and try again?
This setting is only relevant to MMC cards, and I have seen some
problems with it.

Also please post lsmod, dmesg, lspci output.

Did you do a suspend/resume cycle before this test?

You can also contact me via IRC (freenode, oftc, my nick MaximLevitsky),
and I try do some debugging.

Best regards,
	Maxim Levitsky


From: Mark Hills <mark@pogo.org.uk>
Subject: Re: SD card on Dell D420 (Ricoh R5C822)
Date: Thu, 10 Jun 2010 09:08:03 +0100 (BST)
Message-ID: <alpine.NEB.2.01.1006100902200.15823@jrf.vwaro.pbz>
References: <alpine.NEB.2.01.1006100007290.6369@jrf.vwaro.pbz> <m3r5kfg1us.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:56164 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752524Ab0FJIII (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 04:08:08 -0400
In-Reply-To: <m3r5kfg1us.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, 9 Jun 2010, Chris Ball wrote:

> Hi Mark,
> 
>    >   mmc0: error -84 whilst initialising SD card
> 
> Not sure how much this'll help, but:
> 
> errno -84 is defined in include/asm-generic/errno.h as EILSEQ, and
> there are two occurences of EILSEQ in sdhci.c, one of which has a
> printk next to it that you aren't seeing.  So, it's likely that you're
> seeing:
> 
>     else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX))
>         host->cmd->error = -EILSEQ;
> 
> So, it seems like your controller is returning a successful command
> response, but with some sort of data error attached.  Have you tried
> multiple SD cards, and are they known-working?

I have two SD cards -- a 2GB Crucial, and a 32MB Sandisk (actually a 
micro-SD in an adaptor). Both cards work in a USB card reader with the 
same kernel, and in my digital radio.
 
> If you're sure it's not the card, try passing debug_quirks=1 to the
> sdhci module.  (Let me know if you're not sure how to do that.)

I've tried this with 2.6.35-rc2, and the result is the same. I also diff'd 
the dmesg, with no relevant differences.

> Thanks,
> 
> - Chris.
>

Thanks 

-- 
Mark

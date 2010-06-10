From: Chris Ball <cjb@laptop.org>
Subject: Re: SD card on Dell D420 (Ricoh R5C822)
Date: Wed, 09 Jun 2010 20:36:43 -0400
Message-ID: <m3r5kfg1us.fsf@pullcord.laptop.org>
References: <alpine.NEB.2.01.1006100007290.6369@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43968 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab0FJAdG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Jun 2010 20:33:06 -0400
In-Reply-To: <alpine.NEB.2.01.1006100007290.6369@jrf.vwaro.pbz> (Mark Hills's
	message of "Thu, 10 Jun 2010 00:52:10 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
Cc: linux-mmc@vger.kernel.org

Hi Mark,

   >   mmc0: error -84 whilst initialising SD card

Not sure how much this'll help, but:

errno -84 is defined in include/asm-generic/errno.h as EILSEQ, and
there are two occurences of EILSEQ in sdhci.c, one of which has a
printk next to it that you aren't seeing.  So, it's likely that you're
seeing:

    else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX))
        host->cmd->error = -EILSEQ;

So, it seems like your controller is returning a successful command
response, but with some sort of data error attached.  Have you tried
multiple SD cards, and are they known-working?

If you're sure it's not the card, try passing debug_quirks=1 to the
sdhci module.  (Let me know if you're not sure how to do that.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child

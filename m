From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [RFC] mmc: sdhci: work around broken dma boundary behavior
Date: Wed, 13 Apr 2011 00:04:57 -0700 (PDT)
Message-ID: <699629.28764.qm@web161807.mail.bf1.yahoo.com>
References: <20110314172129.GA20654@pengutronix.de> <1301388814-10931-1-git-send-email-mmvinni@yahoo.com> <m3y63fz8c2.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm1.bullet.mail.bf1.yahoo.com ([98.139.212.160]:21326 "HELO
	nm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756898Ab1DMHE6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 03:04:58 -0400
In-Reply-To: <m3y63fz8c2.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

>From Chris Ball:

> > Some SD host  controllers (noticed on an integrated JMicron
> > SD reader on an HP  Pavilion dv5-1250eo laptop) don't update
> > the dma address register before  signaling a dma interrupt due
> > to a dma boundary. Update the register  manually to the next
> > boundary (by default 512KiB), at which the transfer  stopped.
> >
> > As long as each transfer is at most 512KiB in size  (guaranteed
> > by a BUG_ON in sdhci_prepare_data()) and the boundary is  kept
> > at the default value, this fix is needed at most once per
> >  transfer. Smaller boundaries are taken care of by counting
> > the  transferred bytes.
> >
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462
> >
> >  Signed-off-by: Mikko Vinni <mmvinni@yahoo.com>
> 
> I know you  posted this as an RFC, but I've pushed it to mmc-next for
> testing now, and  will plan on merging it for .40 if everything goes well.

Ok, thanks.

Mikko


> Thanks very  much!
> 
> - Chris.
> 


      

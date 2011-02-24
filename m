From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Thu, 24 Feb 2011 21:48:19 +0800
Message-ID: <20110224134818.GA1404@S2100-06.ap.freescale.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
 <20110221174016.GN2616@pengutronix.de>
 <20110222080905.GB16141@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:59086
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab1BXNss (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 08:48:48 -0500
Received: from mail49-ch1 (localhost.localdomain [127.0.0.1])	by
 mail49-ch1-R.bigfish.com (Postfix) with ESMTP id 6B78B48816B	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 13:48:47 +0000 (UTC)
Received: from CH1EHSMHS003.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail49-ch1.bigfish.com (Postfix) with ESMTP id D262813804B
	for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 13:48:46 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id p1ODmf1O011911	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 06:48:43 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1ODmeMm027256	for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 07:48:41
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110222080905.GB16141@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, arnd@arndb.de

Please ignore the message which is the one I sent a few days ago
and I thought it did not get through.

On Tue, Feb 22, 2011 at 04:09:06PM +0800, Shawn Guo wrote:
> Hi Wolfram,
> 
> On Mon, Feb 21, 2011 at 06:40:16PM +0100, Wolfram Sang wrote:
> > Shawn,
> > 
> > On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> > > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > > The driver calls into mxs-dma via generic dmaengine api for both pio
> > > and data transfer.
> > > 
> > > Thanks Chris Ball for the indentation patch.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > What throughput rates do you get on a mx28-regulated slot serving a card
> > at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
> 
> To make sure we are on the same page, can you share me the test you
> ran?  And I can give it a try on my board.
> 
> > board issue though (or we can fix it later), rest works fine, thus:
> > 
> > Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> > 
> 
> -- 
> Regards,
> Shawn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Shawn


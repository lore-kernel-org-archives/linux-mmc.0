From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 16:52:57 +0800
Message-ID: <20110222085256.GA19871@S2100-06.ap.freescale.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
 <20110221174016.GN2616@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:41747 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab1BVIxf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 03:53:35 -0500
Received: from mail196-tx2 (localhost.localdomain [127.0.0.1])	by
 mail196-tx2-R.bigfish.com (Postfix) with ESMTP id 76D9EA28073	for
 <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 08:53:34 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.251])	by
 mail196-tx2.bigfish.com (Postfix) with ESMTP id 2D88412F804F	for
 <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 08:53:34 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1M8rJpB005991	for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 01:53:20
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1M8rIhL002686	for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 02:53:19
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110221174016.GN2616@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux@arm.linux.org.uk, cjb@laptop.org, linux-mmc@vger.kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Mon, Feb 21, 2011 at 06:40:16PM +0100, Wolfram Sang wrote:
> Shawn,
> 
> On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Thanks Chris Ball for the indentation patch.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> What throughput rates do you get on a mx28-regulated slot serving a card
> at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a

To make sure we are on the same test, can you share the test case
you ran to get the result?  So that I can run it here for the result
on my board.

> board issue though (or we can fix it later), rest works fine, thus:
> 
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> 

-- 
Regards,
Shawn


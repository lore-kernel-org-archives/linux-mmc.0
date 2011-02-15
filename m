From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 16 Feb 2011 06:39:42 +0800
Message-ID: <20110215223941.GJ10990@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
 <20110214165958.GH10709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:43493 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1BOOk6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 09:40:58 -0500
Received: from mail107-tx2 (localhost.localdomain [127.0.0.1])	by
 mail107-tx2-R.bigfish.com (Postfix) with ESMTP id A1CBF768126	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 14:40:57 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.251])	by
 mail107-tx2.bigfish.com (Postfix) with ESMTP id 3BE0A3C804D	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 14:40:57 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id p1FEeroG023000	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 07:40:53 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 p1FEeqfw029726	for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 08:40:53
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110214165958.GH10709@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Mon, Feb 14, 2011 at 05:59:58PM +0100, Wolfram Sang wrote:
> On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> While trying, I got this lockdep-warning and BUG. It might be that my setup is
> wrong, causing all these timeouts. But they probably are meant to be handled
> more gracefully? I can continue testing tomorrow, maybe this report already
> helps identifying a problem?
> 
Ah, yes.  I can also see the problem here after turning on
DEBUG_SPINLOCK.  I really should always turn it on in daily
development.

Thanks for catching.  I will fix it in v3.

Regards,
Shawn


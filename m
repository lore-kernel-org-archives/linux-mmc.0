From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Mon, 14 Feb 2011 01:53:02 +0800
Message-ID: <20110213175300.GA10271@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
 <201102042126.52701.arnd@arndb.de>
 <20110211003533.GA9151@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:40428 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab1BMJx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 04:53:57 -0500
Received: from mail80-tx2 (localhost.localdomain [127.0.0.1])	by
 mail80-tx2-R.bigfish.com (Postfix) with ESMTP id C178519A81AF	for
 <linux-mmc@vger.kernel.org>; Sun, 13 Feb 2011 09:53:56 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.248])	by
 mail80-tx2.bigfish.com (Postfix) with ESMTP id 910D835804E	for
 <linux-mmc@vger.kernel.org>; Sun, 13 Feb 2011 09:53:56 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1D9rrH1017997	for <linux-mmc@vger.kernel.org>; Sun, 13 Feb 2011 02:53:55
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1D9rq1i011646	for <linux-mmc@vger.kernel.org>; Sun, 13 Feb 2011 03:53:53
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110211003533.GA9151@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

Hi Arnd,

On Fri, Feb 11, 2011 at 08:35:34AM +0800, Shawn Guo wrote:
> 
> > > +	unsigned			present:1;
> > 
> > Your card detection by polling through this variable is
> > really bad for power management. Is there really no interrupt
> > that gets triggered when installing or removing a card?
> > 
> Good point.  Will try to use interrupt.
> 
I'm trying to use interrupt for card detection.  But unfortunately,
I got stuck for some reason.

There is a known issue that mx28 gpio interrupt from bank0 can not
work, because the pin bank0 irq number 127 was used in
get_irqnr_and_base (entry-macro.S) to tell there is no pending
interrupt any more.

The mmc0 cd pin has no problem to trigger interrupt, as it's GPIO_2_9.
But mmc1 cd pin can not, because it's GPIO_0_20.

So I probably have to stay with polling.

Regards,
Shawn


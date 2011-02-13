From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sun, 13 Feb 2011 16:34:40 +0100
Message-ID: <201102131634.40468.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <20110211003533.GA9151@S2100-06.ap.freescale.net> <20110213175300.GA10271@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61910 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1BMPet (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 10:34:49 -0500
In-Reply-To: <20110213175300.GA10271@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

On Sunday 13 February 2011 18:53:02 Shawn Guo wrote:
> On Fri, Feb 11, 2011 at 08:35:34AM +0800, Shawn Guo wrote:
> > 
> > > > + unsigned                        present:1;
> > > 
> > > Your card detection by polling through this variable is
> > > really bad for power management. Is there really no interrupt
> > > that gets triggered when installing or removing a card?
> > > 
> > Good point.  Will try to use interrupt.
> > 
> I'm trying to use interrupt for card detection.  But unfortunately,
> I got stuck for some reason.
> 
> There is a known issue that mx28 gpio interrupt from bank0 can not
> work, because the pin bank0 irq number 127 was used in
> get_irqnr_and_base (entry-macro.S) to tell there is no pending
> interrupt any more.
> 
> The mmc0 cd pin has no problem to trigger interrupt, as it's GPIO_2_9.
> But mmc1 cd pin can not, because it's GPIO_0_20.
> 
> So I probably have to stay with polling.

I'm not sure if I understand completely. Is this a fundamental restriction,
or something that only happens on a specific board?

Maybe you can do both polling and interrupt driven card detection in
the driver, and make it depend on a board-specific quirk. E.g. if you
pass an interrupt number in the platform data, it should just use the
interrupt, but if the interrupt is missing, you can fall back to
polling.

	Arnd

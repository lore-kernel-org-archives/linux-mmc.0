From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Sun, 23 Jan 2011 20:06:39 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934E7F44E6@irsmsx501.ger.corp.intel.com>
References: <20110114082310.GB27523@intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
 <20110120050803.GA5732@void.printf.net>
 <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
 <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8608 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab1AWUGr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Jan 2011 15:06:47 -0500
In-Reply-To: <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>

> 
> First case:  you want to stop the clock _to_ the _card_ when not talking
> to it.  That has nothing to do with power saving performed within the
> host controller.  This is for reducing power consumption by the _card_
> (and possibly by the clock generator).  The runtime PM stuff has no
> business here as the decision to gate the clock on the card require
> MMC/SD protocol knowledge.

Could not the mmcclock be a device on this own, and use rpm to manage its state?

> Second case: you want the _host_CONTROLLER_ to be shut down so it
> doesn't consume power by itself when idle.  This would be performed when
> case 1 has gated the clock, but not necessarily always. 
Agree with this, this is the idea of the my implementation.

> Here the
> runtime PM infrastructure could make some sense.
> 
> All host controllers can gate the card's clock, but not all of them can
> power themselves down.  And maybe there would be a case for keeping the
> clock to a SDIO card active while the host controller is powered down.

> Knowledge for gating the card's clock is in the core code and
> independent from the host controller.
But knowledge on *how* to gate the clock is in the host controller driver, and/or platform code.


Pierre
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


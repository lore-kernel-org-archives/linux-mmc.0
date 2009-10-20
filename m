From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: MMC_CAP_SDIO_IRQ for omap 3430
Date: Mon, 19 Oct 2009 21:53:58 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B3CE505@dlee02.ent.ti.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>
	 <4AD8C959.1000004@googlemail.com>
	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
	 <4ADB4604.2090704@googlemail.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>
	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
 <4b73d43f0910191813j6089f4a4q3a4768d99cc82e30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50828 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbZJTCx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Oct 2009 22:53:56 -0400
In-Reply-To: <4b73d43f0910191813j6089f4a4q3a4768d99cc82e30@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <sakoman@gmail.com>


> From: John Rigby [mailto:jcrigby@gmail.com]
> Sent: Monday, October 19, 2009 8:13 PM

> It is not perfect yet,  I am still polling in sdio_irq.c because
> sometimes the card irq does get dropped.  I suspect that is why the
> davinci driver had extra checks and calls in various places.

Maybe.

Do make sure all power management is shut down during initial testing.  The wake up mechanism for INACTIVE and OFF mode likely is not in place properly for MMC.  This will make you a bit late for servicing interrupts.  It seems unlikely you hit this issue yet, but you will.

To wake from OFF mode you will need to set up a GPIO wake from SDIO line.  Users I'm aware of so far (ti-wlan chips, etc) have used a separate gpio line for interrupts.

Regards,
Richard W.



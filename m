From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Resubmission
Date: Tue, 15 Mar 2011 16:41:08 +0100
Message-ID: <201103151641.08336.arnd@arndb.de>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <20110315094041.GA32015@pengutronix.de> <m3y64gqv7c.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64671 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073Ab1COPlS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 11:41:18 -0400
In-Reply-To: <m3y64gqv7c.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Tony Olech <tony.olech@elandigitalsystems.com>, linux-mmc@vger.kernel.org

On Tuesday 15 March 2011, Chris Ball wrote:
> I thought about it, but I think staging drivers generally have a much
> larger TODO list than this one would.
> 
> Perhaps a good plan is:  I'll push it to mmc-next after the 2.6.39 merge,
> then I'll try to work on style changes a bit (I'll send each patch to the
> list and Tony can ACK/NACK them), and then we can include it in 2.6.40
> either as a normal driver if we're comfortable with how it's ended up,
> or as a staging driver if we'd still like to get some more eyes on it.
> 
> Does that sound okay to everyone?

Sounds good to me. I certainly wouldn't rush it now after the
merge window is open. I'll also do a quick review for a TODO
list.

	Arnd

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 18:30:32 +0100
Message-ID: <201102121830.32387.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102121107.17779.arnd@arndb.de> <20110212183726.GC9821@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63558 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1BLRaf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 12:30:35 -0500
In-Reply-To: <20110212183726.GC9821@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

On Saturday 12 February 2011 19:37:27 Shawn Guo wrote:
> > If you use a flattened device tree, you can avoid the need for
> > platform data by adding the phandle of the dma engine device to
> > a property of the mmc driver, along with the channel number inside
> > of that device. I think that would be the cleanest approach, but
> > some people still need to be convinced that changing drivers to
> > use fdt data is the right direction for ARM.
> > 
> Could we keep the current the approach for now and go to the cleanest
> way directly when Grant's dt patches get merged?

Sounds good to me. If you are planning to use device trees anyway,
I don't have a problem with leaving it your way in the meantime.

	Arnd

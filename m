From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 11:07:17 +0100
Message-ID: <201102121107.17779.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102120959.22707.arnd@arndb.de> <20110212172357.GB9821@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51825 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1BLKHb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 05:07:31 -0500
In-Reply-To: <20110212172357.GB9821@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Saturday 12 February 2011 18:23:58 Shawn Guo wrote:
> Well, we are removing inclusion of mach/dma.h from mmc driver, but
> adding it to every mxs based machine code.  This makes mmc driver
> clean but machine code becomes not.  For some dma client devices
> coming later, the platform data could be saved at all, if they do not
> have any.  But with the approach you are suggesting, every single
> client device will have to get platform data.

Right, unless there is a way to encode it exlusively in the resources,
which is what I was suggesting at first: If the dma engine driver
knows about all the channels, you only need to pass the channel number.

If you use a flattened device tree, you can avoid the need for
platform data by adding the phandle of the dma engine device to
a property of the mmc driver, along with the channel number inside
of that device. I think that would be the cleanest approach, but
some people still need to be convinced that changing drivers to
use fdt data is the right direction for ARM.

	Arnd

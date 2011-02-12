From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sun, 13 Feb 2011 02:37:27 +0800
Message-ID: <20110212183726.GC9821@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <201102120959.22707.arnd@arndb.de>
 <20110212172357.GB9821@S2100-06.ap.freescale.net>
 <201102121107.17779.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:24211 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1BLKjV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 05:39:21 -0500
Received: from mail148-tx2 (localhost.localdomain [127.0.0.1])	by
 mail148-tx2-R.bigfish.com (Postfix) with ESMTP id E780D19C867F	for
 <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 10:39:19 +0000 (UTC)
Received: from TX2EHSMHS039.bigfish.com (unknown [10.9.14.250])	by
 mail148-tx2.bigfish.com (Postfix) with ESMTP id 068909C005B	for
 <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 10:38:12 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id p1CAcAjU019637	for
 <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 03:38:10 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1CAc9Nq026415	for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 04:38:09
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <201102121107.17779.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

On Sat, Feb 12, 2011 at 11:07:17AM +0100, Arnd Bergmann wrote:
> On Saturday 12 February 2011 18:23:58 Shawn Guo wrote:
> > Well, we are removing inclusion of mach/dma.h from mmc driver, but
> > adding it to every mxs based machine code.  This makes mmc driver
> > clean but machine code becomes not.  For some dma client devices
> > coming later, the platform data could be saved at all, if they do not
> > have any.  But with the approach you are suggesting, every single
> > client device will have to get platform data.
> 
> Right, unless there is a way to encode it exlusively in the resources,
> which is what I was suggesting at first: If the dma engine driver
> knows about all the channels, you only need to pass the channel number.
> 
> If you use a flattened device tree, you can avoid the need for
> platform data by adding the phandle of the dma engine device to
> a property of the mmc driver, along with the channel number inside
> of that device. I think that would be the cleanest approach, but
> some people still need to be convinced that changing drivers to
> use fdt data is the right direction for ARM.
> 
Could we keep the current the approach for now and go to the cleanest
way directly when Grant's dt patches get merged?

Regards,
Shawn


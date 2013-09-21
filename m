From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Adding aliases to mmc
Date: Sat, 21 Sep 2013 15:52:47 +0200
Message-ID: <20130921135247.GL30088@pengutronix.de>
References: <5239C40C.9030503@wwwdotorg.org>
 <5239DC65.3080803@gmail.com>
 <5239DF55.8010308@wwwdotorg.org>
 <523A8A08.2060508@gmail.com>
 <523C7231.7040701@wwwdotorg.org>
 <523C79C4.1070308@gmail.com>
 <523C7FD0.3030006@wwwdotorg.org>
 <523D2D4F.6030802@gmail.com>
 <20130921074238.GI30088@pengutronix.de>
 <20130921123051.GN1736@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3IUNwx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Sep 2013 09:52:53 -0400
Content-Disposition: inline
In-Reply-To: <20130921123051.GN1736@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Olbrich <m.olbrich@pengutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On Sat, Sep 21, 2013 at 02:30:51PM +0200, Michael Olbrich wrote:
> Hi,
> 
> > > 
> > > An embedded system typically doesn't have an initrd. The kernel
> > > boots directly into the rootfs on SD/eMMC.
> > > 
> > > >>To my understanding, the UUID is different for each SD card/eMMC, correct?
> > > >
> > > >Yes by default.
> > > >
> > > >Although for an embedded product with a fixed eMMC, there's no reason
> > > >you couldn't make every device have the same UUID for the fixed device.
> > > 
> > > How do you make the eMMC on 1000 boards have the same UUID?
> > 
> > The same way you ensure an identical partition table in these 1000
> > boards. The disk signature is just a four byte value at offset 440 in
> > the MBR. Set this to your birthday or whatever on all boards, pass
> > root=PARTUUID=<yourbirthday>-01 on all boards and you're done.
> 
> Until someone inserts a SD-Card with the same disk signature...

Indeed. That would be a nice way to boot your own rootfs on otherwise
locked devices ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

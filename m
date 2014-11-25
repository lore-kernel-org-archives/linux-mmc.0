From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: eMMC write error in IMX6 Sabre AI board
Date: Tue, 25 Nov 2014 22:04:10 +0100
Message-ID: <20141125210410.GG28355@pengutronix.de>
References: <loom.20141107T122543-102@post.gmane.org>
 <CAOMZO5D1n7JutWCJAVafFSOKPZaS_HJjLPp26ROR-Gk12=b0yw@mail.gmail.com>
 <0CE86CAC7146084190A01E87F7DCD5E908A0CFA5@TOSBLRMBX01.TOSHIBA-TSIP.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43965 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaKYVEO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 16:04:14 -0500
Content-Disposition: inline
In-Reply-To: <0CE86CAC7146084190A01E87F7DCD5E908A0CFA5@TOSBLRMBX01.TOSHIBA-TSIP.COM>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vadivelan M <Vadivelan.Mani@toshiba-tsip.com>
Cc: 'Fabio Estevam' <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 10, 2014 at 08:44:29AM +0000, Vadivelan M wrote:
> Thanks for your suggestion. But my kernel is fixed to version 3.0.35
> and hence unable to use a different kernel. Please tell what is the
> problem in this kernel version if you already know. That would be very
> helpful.

If you use such an old kernel, you are basically on your own;
community development & support takes place on top-of-tree.

Note that 3.0.35 is 227048 patches behind 3.18-rc6, and this does not
even take into account that you are probably using 3.0.35 plus thousands
of vendor patches. You can't seriously expect anyone in the community to
help you with issues which have long been solved.

Regards,
Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

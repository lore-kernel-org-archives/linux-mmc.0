From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
Date: Thu, 5 Jun 2014 12:39:49 +0200
Message-ID: <20140605103949.GL15686@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
 <20140601152216.GD11061@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbaFEKj4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 06:39:56 -0400
Content-Disposition: inline
In-Reply-To: <20140601152216.GD11061@dragon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Dong Aisheng <b29396@freescale.com>

On Sun, Jun 01, 2014 at 11:22:19PM +0800, Shawn Guo wrote:
> On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> > - Move cd/wp pinctrl from the hog group to the esdhc groups
> > - use gpio for card detection / write protection on esdhc2 since
> >   the controller based detection does not work
> 
> I tracked it a little bit and found that the controller based detection
> works fine with v3.13 and starts being broken from v3.14-rc1.  The
> offending commit seems to be 89d7e5c13122 (mmc: sdhci-esdhc-imx: add
> runtime pm support).

This makes sense. When the controller is disabled it obviously can't
detect card insertion/removal events anymore. So you can only have one:
controller based card detection or runtime pm for the controller.
So it probably makes sense to use gpio card detection whenever possible
to get additional power savings.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

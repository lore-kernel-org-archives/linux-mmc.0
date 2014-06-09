From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
Date: Mon, 9 Jun 2014 11:38:57 +0800
Message-ID: <20140609033854.GE11061@dragon>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
 <20140601152216.GD11061@dragon> <20140605103949.GL15686@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:32701
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753992AbaFIDjN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 8 Jun 2014 23:39:13 -0400
Content-Disposition: inline
In-Reply-To: <20140605103949.GL15686@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Dong Aisheng <b29396@freescale.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>

On Thu, Jun 05, 2014 at 12:39:49PM +0200, Sascha Hauer wrote:
> On Sun, Jun 01, 2014 at 11:22:19PM +0800, Shawn Guo wrote:
> > On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> > > - Move cd/wp pinctrl from the hog group to the esdhc groups
> > > - use gpio for card detection / write protection on esdhc2 since
> > >   the controller based detection does not work
> > 
> > I tracked it a little bit and found that the controller based detection
> > works fine with v3.13 and starts being broken from v3.14-rc1.  The
> > offending commit seems to be 89d7e5c13122 (mmc: sdhci-esdhc-imx: add
> > runtime pm support).
> 
> This makes sense. When the controller is disabled it obviously can't
> detect card insertion/removal events anymore. So you can only have one:
> controller based card detection or runtime pm for the controller.
> So it probably makes sense to use gpio card detection whenever possible
> to get additional power savings.

Can we have something like that in commit log to explain the breakage?
Also, the patch does not apply to my branch, so you may need to rebase
anyway.

Lothar, Denis,

FYI.  The controller based card detection / write protection are broken
right now, and I see your boards (imx53-tx53 and
imx51-eukrea-mbimxsd51-baseboard) are using them.  You may want to
switch to use GPIO if available.

Shawn

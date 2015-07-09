From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 4/6] mmc: sdhci-esdhc-imx: remove duplicated dts parsing
Date: Thu, 9 Jul 2015 16:59:48 +0800
Message-ID: <20150709085945.GA3917@shlinux1.ap.freescale.net>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <1434564337-24720-5-git-send-email-aisheng.dong@freescale.com>
 <20150709073835.GC23464@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0132.outbound.protection.outlook.com ([157.56.110.132]:39936
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751236AbbGIJGH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 05:06:07 -0400
Content-Disposition: inline
In-Reply-To: <20150709073835.GC23464@tiger>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, linux-mmc@vger.kernel.org, fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

On Thu, Jul 09, 2015 at 03:38:35PM +0800, Shawn Guo wrote:
> On Thu, Jun 18, 2015 at 02:05:35AM +0800, Dong Aisheng wrote:
> > After commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()"),
> > we do not need those duplicated parsing anymore.
> > 
> > Note: fsl,cd-controller is also deleted due to the driver does
> > not support controller card detection anymore after switch to runtime pm.
> > And there's no user of it right now in device tree.
> > 
> > wp-gpios is kept because we're still support fsl,wp-controller,
> > so we need a way to check if it's gpio wp or controller wp.
> 
> I do not remember the reason why controller based CD stops working after
> we switch to runtime PM.  But if CD stops working for some reason,
> shouldn't controller based WP stop working for the same reason?
> 

The main reason may be CD/WP function needs controller clock on.
But after enable runtime pm, the clock will be disabled.

See below commit:
commit dacf49223fc680e6d5b5ca4ea43dcd197c1814c5
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Fri May 23 14:33:04 2014 +0200

ARM: dts: imx51-babbage: Fix esdhc setup

Since commit 89d7e5c13122 (mmc: sdhci-esdhc-imx: add runtime pm
support), controller based card detection / write protection is not
supported anymore by esdhc driver.  Let's use GPIO for CD/WP on esdhc1
instead.

While at it, fix cd gpio polarity for esdhc2. This is wrong and
currently only works because the imx esdhc driver ignores the polarity.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

WP is bit different since sdhci_get_ro will call runtime_pm_get to enable
clocks. So i guess WP may still work.
I did not test, but i did see there's still a lot users of fsl,wp_controller
in device tree which is supposed to work.

There's no fsl,cd-controller users anymore.

Regards
Dong Aisheng

> Shawn
> 
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>

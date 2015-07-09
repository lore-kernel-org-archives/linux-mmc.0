From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 4/6] mmc: sdhci-esdhc-imx: remove duplicated dts parsing
Date: Thu, 9 Jul 2015 15:38:35 +0800
Message-ID: <20150709073835.GC23464@tiger>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <1434564337-24720-5-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51250 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbbGIHiv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 03:38:51 -0400
Content-Disposition: inline
In-Reply-To: <1434564337-24720-5-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: linux-mmc@vger.kernel.org, fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

On Thu, Jun 18, 2015 at 02:05:35AM +0800, Dong Aisheng wrote:
> After commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()"),
> we do not need those duplicated parsing anymore.
> 
> Note: fsl,cd-controller is also deleted due to the driver does
> not support controller card detection anymore after switch to runtime pm.
> And there's no user of it right now in device tree.
> 
> wp-gpios is kept because we're still support fsl,wp-controller,
> so we need a way to check if it's gpio wp or controller wp.

I do not remember the reason why controller based CD stops working after
we switch to runtime PM.  But if CD stops working for some reason,
shouldn't controller based WP stop working for the same reason?

Shawn

> 
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>

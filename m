From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Thu, 9 Jul 2015 21:27:36 +0800
Message-ID: <20150709132736.GG23464@tiger>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <20150709075032.GD23464@tiger>
 <20150709092949.GB3917@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46393 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbbGIN16 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 09:27:58 -0400
Content-Disposition: inline
In-Reply-To: <20150709092949.GB3917@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, ulf.hansson@linaro.org, chris@printf.net, smoch@web.de, s.trumtrar@pengutronix.de, LW@KARO-electronics.de, marex@denx.de, rabeeh@solid-run.com, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, hs@denx.de, tharvey@gateworks.com, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, lisovy@gmail.com, robertcnelson@gmail.com, linux-arm-kernel@lists.infradead.org, ipaton0@gmail.com, fabio.estevam@freescale.com, linux-mmc@vger.kernel.org, p.zabel@pengutronix.de, shawn.guo@linaro.org

On Thu, Jul 09, 2015 at 05:29:50PM +0800, Dong Aisheng wrote:
> I agree with you.
> One difference is that i'd like to fix it ASAP without reverting 8d86e4f
> due to more patches depends on it is already there as i mentioned above..
> Revert it may need to revert a lot others.
> 
> The pain is that v4.1 is left broken.

Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
the best option.  I suggest you rebase the dts series on top of
v4.2-rc1, and send it via mmc tree.

Shawn

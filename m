From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V2 00/11] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Thu, 23 Jul 2015 12:45:48 +0800
Message-ID: <20150723044548.GG12927@tiger>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37823 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbbGWEqH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jul 2015 00:46:07 -0400
Content-Disposition: inline
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: linux-mmc@vger.kernel.org, fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, hs@denx.de, p.zabel@pengutronix.de, tharvey@gateworks.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, ipaton0@gmail.com, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, smoch@web.de, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, lisovy@gmail.com, s.trumtrar@pengutronix.de, robertcnelson@gmail.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de

On Wed, Jul 22, 2015 at 08:52:59PM +0800, Dong Aisheng wrote:
> Dong Aisheng (11):
>   dts: imx51: fix sd card gpio polarity specified in device tree
>   dts: imx53: fix sd card gpio polarity specified in device tree
>   dts: imx6: fix sd card gpio polarity specified in device tree
>   dts: imx25: fix sd card gpio polarity specified in device tree
>   dts: imx7: fix sd card gpio polarity specified in device tree

Acked-by: Shawn Guo <shawnguo@kernel.org>

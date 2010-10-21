From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Thu, 21 Oct 2010 15:13:02 +0100
Message-ID: <20101021141302.GA11912@void.printf.net>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49995 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186Ab0JUONE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Oct 2010 10:13:04 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Zhangfei,

On Mon, Oct 18, 2010 at 08:32:46AM -0400, zhangfei gao wrote:
> Update with comments from Matt and Eric.
> Test with sd and emmc.
> 
> >From e5dd554ed4d3488a83d9a4888d68d1d85482f747 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 20 Sep 2010 10:51:28 -0400
> Subject: [PATCH] mmc: add support of sdhci-pxa driver
> 
> 	Support Marvell PXA168/PXA910/MMP2 SD Host Controller
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
>  drivers/mmc/host/Kconfig               |   12 ++
>  drivers/mmc/host/Makefile              |    1 +
>  drivers/mmc/host/sdhci-pxa.c           |  259 ++++++++++++++++++++++++++++++++
>  4 files changed, 304 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
>  create mode 100644 drivers/mmc/host/sdhci-pxa.c

I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
patch through the ARM tree.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

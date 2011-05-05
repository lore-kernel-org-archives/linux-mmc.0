From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Thu, 5 May 2011 18:20:52 +0400
Message-ID: <20110505142051.GA17915@oksana.dev.rtsoft.ru>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61208 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1EEOU6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 10:20:58 -0400
Received: by eyx24 with SMTP id 24so687408eyx.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 07:20:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> This patch is to consolidate SDHCI driver for Freescale eSDHC
> controller found on both MPCxxx and i.MX platforms.  It merges
> sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> .probe/.remove hook works with eSDHC for two platforms.
> 
> As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> header esdhc.h containing the definition of esdhc_platform_data is
> put into the public folder.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'm not sure if that makes sense to merge these two.
I'd rather vote for renaming sdhci-of-esdhc to sdhci-esdhc-mpc. :-)

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com

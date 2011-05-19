From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get them
 self registered
Date: Fri, 20 May 2011 00:09:02 +0800
Message-ID: <20110519160901.GC26816@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <20110519094046.GA2219@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:22293
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932336Ab1ESQEn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 12:04:43 -0400
Content-Disposition: inline
In-Reply-To: <20110519094046.GA2219@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

Hi Wolfram,

On Thu, May 19, 2011 at 11:40:46AM +0200, Wolfram Sang wrote:
> Hi Shawn,
> 
> > Changes since v1:
> >  * Rebase on cjb's mmc-next tree
> 
> Is it maybe possible that you get access to
> http://opensource.freescale.com/git or another machine? A branch to pull
> from would be more convenient, because the series does not apply to
> mmc-next anymore, so an extra step to go "back in time" is needed.
> 
> (minor) When applying I got:
> 
> Applying: mmc: sdhci: make sdhci-pltfm device drivers self registered
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:384: trailing whitespace.
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:817: space before tab in indent.
>  	struct tegra_sdhci_platform_data *plat;
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:867: trailing whitespace.
> 
> Applying: sdhci: rename sdhci-esdhc-imx.c to sdhci-esdhc.c
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:780: trailing whitespace.
> 
> See later comments for further issues.
> 
Should I go for v3 right now to address the patch applying problems
and that ESDHC_IMX build issue, or hold for a while to see if you
have more comments on v2?

And what is your position on patch #5 which merges esdhc imx and mpc
support into one?  As Anton has voted a NO there, I would probably
drop the patch if there is another person has strong opinion to get
imx and mpc stay separated.

-- 
Regards,
Shawn


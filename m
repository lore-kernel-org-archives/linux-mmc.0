From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Wed, 25 May 2011 14:06:37 +0800
Message-ID: <20110525060637.GA30583@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
 <20110524194054.GC25727@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:58855
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752674Ab1EYGCG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 02:02:06 -0400
Content-Disposition: inline
In-Reply-To: <20110524194054.GC25727@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

On Tue, May 24, 2011 at 09:40:54PM +0200, Wolfram Sang wrote:
> On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> > This patch is to consolidate SDHCI driver for Freescale eSDHC
> > controller found on both MPCxxx and i.MX platforms.  It merges
> > sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> > .probe/.remove hook works with eSDHC for two platforms.
> > 
> > As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> > header esdhc.h containing the definition of esdhc_platform_data is
> > put into the public folder.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I agree with Anton about not merging the two...
> 
> > +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> > +#define cpu_is_mx25()	(0)
> > +#define cpu_is_mx35()	(0)
> > +#define cpu_is_mx51()	(0)
> > +#define cpu_is_imx()	(0)
> > +#else
> > +#define cpu_is_imx()	(1)
> > +#endif
> 
> ... e.g. that looks a bit frightening.
> 
Agree.

The use of cpu_is_mx..() in the driver itself seems a churn to me
even without this consolidation patch.  Is it possible for us to
eliminate them by using pdata, and eventually device tree?  When we
are there, I might want to revisit the consolidation again.

-- 
Regards,
Shawn


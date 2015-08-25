From: Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
Date: Tue, 25 Aug 2015 11:34:19 +0800
Message-ID: <20150825033418.GA15468@b51421-server.ap.freescale.net>
References: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
 <20150813085854.GA19166@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0140.outbound.protection.outlook.com ([157.56.110.140]:55521
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752220AbbHYDbF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Aug 2015 23:31:05 -0400
Content-Disposition: inline
In-Reply-To: <20150813085854.GA19166@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>, ulf.hansson@linaro.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, johan.derycke@barco.com, mkl@pengutronix.de, haibo.chen@freescale.com, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Thu, Aug 13, 2015 at 04:58:56PM +0800, Dong Aisheng wrote:
> On Tue, Aug 11, 2015 at 07:38:25PM +0800, Haibo Chen wrote:
> > Changes for v6:
> > -remove duplicate code in esdhc_set_uhs_signaling().
> > -fix a typo for patch-2.
> > -make commit log of patch-3 more specific.
> > 
> > Haibo Chen (6):
> >   mmc: sdhci-esdhc-imx: add imx7d support and support HS400
> >   mmc: sdhci-esdhc-imx: add tuning-step setting support
> >   mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
> >   ARM: dts: imx7d-sdb: add eMMC5.0 support
> >   mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
> >   mmc: sdhci-esdhc-imx: change default watermark level and burst length
> > 
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
> >  arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
> >  drivers/mmc/host/sdhci-esdhc-imx.c                 | 114 ++++++++++++++++++++-
> >  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
> >  4 files changed, 130 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 1.9.1
> > 
> 
> The patch set looks good to me.
> 
> Acked-by: Dong Aisheng <aisheng.dong@freescale.com>
> 
> Regards
> Dong Aisheng

Hi Ulf,

Can you help pull these patches into your branch?


Best regards

Haibo
-- 

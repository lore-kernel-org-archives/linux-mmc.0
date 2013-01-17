From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unused variables
Date: Thu, 17 Jan 2013 10:25:48 +0800
Message-ID: <20130117022546.GG26179@S2101-09.ap.freescale.net>
References: <1358383916-23614-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:7792
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757667Ab3AQCZR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 21:25:17 -0500
Content-Disposition: inline
In-Reply-To: <1358383916-23614-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Jan 16, 2013 at 10:51:56PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> commit 842afc02cf (mmc: sdhci-esdhc-imx: do not reference platform data after 
> probe) introduced the following build warnings:
> 
My bad.  The warnings are introduced by my commit 78b2b04 (mmc:
sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from IO accessory).

So with the commit log corrected,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> drivers/mmc/host/sdhci-esdhc-imx.c:149:30: warning: unused variable 'boarddata' [-Wunused-variable]
> drivers/mmc/host/sdhci-esdhc-imx.c:181:30: warning: unused variable 'boarddata' [-Wunused-variable]
> 
> Remove the unused variables.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>


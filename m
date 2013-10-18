From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum
 imx_esdhc_type
Date: Fri, 18 Oct 2013 16:09:23 +0800
Message-ID: <20131018080922.GC22289@shlinux2.ap.freescale.net>
References: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:44022
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751228Ab3JRIZw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 04:25:52 -0400
Content-Disposition: inline
In-Reply-To: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, kernel@pengutronix.de

On Thu, Oct 17, 2013 at 03:19:43PM +0800, Shawn Guo wrote:
> Changes since v1:
> * Create flags only for features and errata such things, and keep using
>   is_imx*_esdhc() for small register differences between esdhc variants.
> 
> Shawn Guo (4):
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
>   mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
>   mmc: sdhci-esdhc-imx: create struct esdhc_soc_data
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c |  126 +++++++++++++++++++-----------------
>  1 file changed, 68 insertions(+), 58 deletions(-)
> 
> -- 
> 1.7.9.5
> 

Acked-by: Dong Aisheng <b29396@freescale.com>

I will rebase my mx6sl std tuning patch series based on it
and send out again.

Regards
Dong Aisheng


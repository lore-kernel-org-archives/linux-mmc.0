From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 0/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Tue, 15 Oct 2013 08:50:44 +0200
Message-ID: <1381819844.4243.7.camel@weser.hi.pengutronix.de>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42088 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3JOGyp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 02:54:45 -0400
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org

Am Montag, den 14.10.2013, 16:23 +0800 schrieb Shawn Guo:
> When I was reviewing Dong's imx6sl standard tuning patches, I found that
> it's a little clumsy to use enum imx_esdhc_type for handling features
> and quirks on different esdhc variants.  Instead, the approach used in
> fec driver (drivers/net/ethernet/freescale/fec_main.c) should be more
> scalable in the long run.  It defines flags for all those features and
> quirks and creates a mapping between esdhc variant and the flags.
> 
> Actually, sdhci-esdhc-imx driver already has one such flag, i.e.
> ESDHC_FLAG_MULTIBLK_NO_INT, but there is currently an unnecessary
> translation between the flag and imx_esdhc_type.  The series creates
> another 3 flags and identify features/quirks using these flags and then
> eliminate enum imx_esdhc_type completely.
> 
Other than the comment on patch 2 this series, with the addition of
patch 6/6 is
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> Shawn Guo (5):
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_NO_DMAS_BITS
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
>   mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
>   mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c |  108 +++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 63 deletions(-)
> 

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


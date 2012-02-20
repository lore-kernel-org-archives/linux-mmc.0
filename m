From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc sdhci i.MX5: make mmc cards work
Date: Mon, 20 Feb 2012 14:31:36 +0800
Message-ID: <20120220063132.GA19668@S2101-09.ap.freescale.net>
References: <1329475909-29047-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40263 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2BTGSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 01:18:22 -0500
Received: by pbcun15 with SMTP id un15so5944581pbc.19
        for <linux-mmc@vger.kernel.org>; Sun, 19 Feb 2012 22:18:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329475909-29047-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>

I do not have a mmc card to test the patch, but I tested it and
confirmed it does not break anything about SD support.

On Fri, Feb 17, 2012 at 11:51:49AM +0100, Sascha Hauer wrote:
> On i.MX53 we have to write a special SDHCI_CMD_ABORTCMD to the

Is this i.MX53 only?

> SDHCI_TRANSFER_MODE register during a MMC_STOP_TRANSMISSION
> command. This works for SD cards. However, with MMC cards
> the MMC_SET_BLOCK_COUNT command is used instead, but this needs
> the same handling. Fix MMC cards by testing for the
> MMC_SET_BLOCK_COUNT command aswell. Tested on a custom i.MX53
> board with a Transcend MMC+ card and eMMC.
> 
I did not find the similar handling in FSL internal tree, but I think
that FSL QA team should have tested it with MMC/eMMC card.

Regards,
Shawn

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d601e41..cd35dc4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -269,7 +269,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		imx_data->scratchpad = val;
>  		return;
>  	case SDHCI_COMMAND:
> -		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION)
> +		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION ||
> +			host->cmd->opcode == MMC_SET_BLOCK_COUNT)
>  			&& (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
>  			val |= SDHCI_CMD_ABORTCMD;
>  
> -- 
> 1.7.9

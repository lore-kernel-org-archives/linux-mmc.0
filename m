From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove repetitive clear interrupt
Date: Mon, 25 Jan 2016 13:14:18 +0900
Message-ID: <56A5A11A.5030103@samsung.com>
References: <1453684420-1860-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48536 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbcAYEO0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2016 23:14:26 -0500
In-reply-to: <1453684420-1860-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

On 01/25/2016 10:13 AM, Shawn Lin wrote:
> This patch remove repetitive clear interrupt while
> probing dw_mmc.

Could you explain to me more?

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7128351..1991872 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3117,7 +3117,6 @@ int dw_mci_probe(struct dw_mci *host)
>  	 * Enable interrupts for command done, data over, data empty,
>  	 * receive ready and error such as transmit, receive timeout, crc error
>  	 */
> -	mci_writel(host, RINTSTS, 0xFFFFFFFF);
>  	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>  		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>  		   DW_MCI_ERROR_FLAGS);
> 


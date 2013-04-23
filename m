From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: clear INSTS register when initialize
Date: Tue, 23 Apr 2013 18:57:40 +0900
Message-ID: <002201ce4008$fe0e0210$fa2a0630$%jun@samsung.com>
References: <1366262497-22560-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50674 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab3DWJ5n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Apr 2013 05:57:43 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLP00BYQD05WUZ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 23 Apr 2013 18:57:41 +0900 (KST)
In-reply-to: <1366262497-22560-1-git-send-email-jy0922.shim@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, will.newton@imgtec.com, jh80.chung@samsung.com

Hi,

On Thursday, April 18, 2013, Joonyoung Shim wrote:
> If pending interrupt for IDMAC exists when probe, it will call interrupt
> handler unnecessarily.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 323c502..b0057a2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2192,6 +2192,7 @@ int dw_mci_probe(struct dw_mci *host)
> 
>  	/* Clear the interrupts for the host controller */
>  	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, IDSTS, 0xFFFFFFFF);
0x337 is correct for bits. Could you check the bit filed?

>  	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> 
>  	/* Put in max timeout */
> @@ -2243,6 +2244,7 @@ int dw_mci_probe(struct dw_mci *host)
>  	 * receive ready and error such as transmit, receive timeout, crc error
>  	 */
>  	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, IDSTS, 0xFFFFFFFF);
No need, it's already done above.

>  	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>  		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>  		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> @@ -2393,6 +2395,7 @@ int dw_mci_resume(struct dw_mci *host)
>  	mci_writel(host, FIFOTH, host->fifoth_val);
> 
>  	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, IDSTS, 0xFFFFFFFF);
Same, incorrect bits.

Thanks,
Seungwon Jeon

>  	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>  		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>  		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


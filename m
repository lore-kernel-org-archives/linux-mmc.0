From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw-mmc: enable trim in eMMC device
Date: Mon, 10 Feb 2014 13:07:22 +0900
Message-ID: <52F8507A.4030904@samsung.com>
References: <1391798398-24634-1-git-send-email-puthik@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49294 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaBJEHT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Feb 2014 23:07:19 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0R0015UI44CU70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 10 Feb 2014 13:07:16 +0900 (KST)
In-reply-to: <1391798398-24634-1-git-send-email-puthik@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Puthikorn Voravootivat <puthik@chromium.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: MMC list <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>

Hi,

On 02/08/2014 03:39 AM, Puthikorn Voravootivat wrote:
> Force host to have erase capacity to enable trim or
> discard feature in supported eMMC device.
> 
> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
> ---
> In mmc_init_queue() before setting up the discard function, mmc driver
> will call mmc_can_erase() which will always return 0 because the host
> erase capacity is not set anywhere. So to enable discard function, we
> need to add erase capacity to the host.
> 
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 55cd110..f47f1c1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -55,6 +55,8 @@
>  #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
>  #define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
>  
> +#define DW_MCI_DEFAULT_CAPS (MMC_CAP_ERASE)
> +

This define didn't need.

>  #ifdef CONFIG_MMC_DW_IDMAC
>  #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
>  				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
> @@ -2371,6 +2373,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	pdata->caps |= DW_MCI_DEFAULT_CAPS;
> +
I didn't want to enable by default. If it's possible, how about using dt-file?
Well, if need to enable by default, just use the "pdata->caps |= MMC_CAPS_ERASE;"

Best Regards,
Jaehoon Chung
>  	/* find out number of slots supported */
>  	if (of_property_read_u32(dev->of_node, "num-slots",
>  				&pdata->num_slots)) {
> 


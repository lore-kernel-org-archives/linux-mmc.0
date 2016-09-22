From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 4/4] mmc: dw_mmc: use macro to define ring buffer size
Date: Thu, 22 Sep 2016 13:27:03 +0900
Message-ID: <382333f8-5bd3-f61e-2802-16a36db5c75f@samsung.com>
References: <1472789679-15121-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160902041957epcas1p189597d4cb2f5726632674947ddd5a81c@epcas1p1.samsung.com>
 <1472789679-15121-4-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43539 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbcIVE1F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 00:27:05 -0400
In-reply-to: <1472789679-15121-4-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org

On 09/02/2016 01:14 PM, Shawn Lin wrote:
> It's very prone to make mistake as we might forget
> to replace all PAGE_SIZEs with new values if we try
> to modify the ring buffer size for whatever reasons.
> Let's use a macro to define it.

Applied on my tree. Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 833b6ad..6e5926b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -61,6 +61,8 @@
>  				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
>  				 SDMMC_IDMAC_INT_TI)
>  
> +#define DESC_RING_BUF_SZ	PAGE_SIZE
> +
>  struct idmac_desc_64addr {
>  	u32		des0;	/* Control Descriptor */
>  
> @@ -474,7 +476,8 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>  	if (host->dma_64bit_address == 1) {
>  		struct idmac_desc_64addr *p;
>  		/* Number of descriptors in the ring buffer */
> -		host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc_64addr);
> +		host->ring_size =
> +			DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
>  
>  		/* Forward link the descriptor list */
>  		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1;
> @@ -500,7 +503,8 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>  	} else {
>  		struct idmac_desc *p;
>  		/* Number of descriptors in the ring buffer */
> -		host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
> +		host->ring_size =
> +			DESC_RING_BUF_SZ / sizeof(struct idmac_desc);
>  
>  		/* Forward link the descriptor list */
>  		for (i = 0, p = host->sg_cpu;
> @@ -609,7 +613,7 @@ static inline int dw_mci_prepare_desc64(struct dw_mci *host,
>  err_own_bit:
>  	/* restore the descriptor chain as it's polluted */
>  	dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
> -	memset(host->sg_cpu, 0, PAGE_SIZE);
> +	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
>  	dw_mci_idmac_init(host);
>  	return -EINVAL;
>  }
> @@ -685,7 +689,7 @@ static inline int dw_mci_prepare_desc32(struct dw_mci *host,
>  err_own_bit:
>  	/* restore the descriptor chain as it's polluted */
>  	dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
> -	memset(host->sg_cpu, 0, PAGE_SIZE);
> +	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
>  	dw_mci_idmac_init(host);
>  	return -EINVAL;
>  }
> @@ -2750,7 +2754,8 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  		}
>  
>  		/* Alloc memory for sg translation */
> -		host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
> +		host->sg_cpu = dmam_alloc_coherent(host->dev,
> +						   DESC_RING_BUF_SZ,
>  						   &host->sg_dma, GFP_KERNEL);
>  		if (!host->sg_cpu) {
>  			dev_err(host->dev,
> 


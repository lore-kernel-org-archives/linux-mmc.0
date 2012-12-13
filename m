From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add support for use_hold_reg
Date: Fri, 14 Dec 2012 08:33:06 +0900
Message-ID: <50CA65B2.9040709@samsung.com>
References: <1355428991-4602-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62590 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab2LMXdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Dec 2012 18:33:22 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MEZ001OBTFKVF60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Dec 2012 08:33:20 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MEZ00681TFJP310@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Dec 2012 08:33:20 +0900 (KST)
In-reply-to: <1355428991-4602-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: cjb@laptop.org, dinh.linux@gmail.com, linux-mmc@vger.kernel.org, tgih.jun@samsung.com, thomas.abraham@linaro.org, kyungmin.park@samsung.com, james.hogan@imgtec.com

Hi Dinh,

According to  DesignWare Spec, we need to check which bus-mode use.
You can refer to "https://patchwork.kernel.org/patch/1379521/".
I know that hold_reg didn't use always, although hold_reg is set.

Best Regards,
Jaehoon Chung

On 12/14/2012 05:03 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add code to read value of the use_hold_reg in the cmd register so that
> the cmdflags can be correct.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |    6 ++++++
>  drivers/mmc/host/dw_mmc.h  |    1 +
>  include/linux/mmc/dw_mmc.h |    3 +++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 323c502..490490b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -265,6 +265,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  	if (drv_data && drv_data->prepare_command)
>  		drv_data->prepare_command(slot->host, &cmdr);
>  
> +	if (slot->host->use_hold_reg)
> +		cmdr |= SDMMC_CMD_USE_HOLD_REG;
> +
>  	return cmdr;
>  }
>  
> @@ -2183,6 +2186,9 @@ int dw_mci_probe(struct dw_mci *host)
>  		host->data_shift = 2;
>  	}
>  
> +	/* Get the USE_HOLD_REG */
> +	host->use_hold_reg = mci_readl(host, CMD) & SDMMC_CMD_USE_HOLD_REG;
> +
>  	/* Reset all blocks */
>  	if (!mci_wait_reset(host->dev, host))
>  		return -ENODEV;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 53b8fd9..6172900 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -111,6 +111,7 @@
>  #define SDMMC_INT_ERROR			0xbfc2
>  /* Command register defines */
>  #define SDMMC_CMD_START			BIT(31)
> +#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>  #define SDMMC_CMD_UPD_CLK		BIT(21)
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 34be4f4..36cab8a 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -187,6 +187,9 @@ struct dw_mci {
>  	struct regulator	*vmmc;	/* Power regulator */
>  	unsigned long		irq_flags; /* IRQ flags */
>  	int			irq;
> +
> +	/* Set to one for SDR12 and SDR25 */
> +	unsigned int use_hold_reg;
>  };
>  
>  /* DMA ops for Internal/External DMAC interface */
> 


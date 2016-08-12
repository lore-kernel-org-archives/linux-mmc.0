From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 06/10] mmc: sdhci: Add get_clk_div callback support
Date: Fri, 12 Aug 2016 10:34:05 +0900
Message-ID: <39e6afe2-8615-45ae-9ea5-feb6a6b58732@samsung.com>
References: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
 <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
 <CGME20160811135325epcas1p41e0758a598b81e837653de7ef8ff56ec@epcas1p4.samsung.com>
 <1470923574-411-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35791 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcHLBeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2016 21:34:08 -0400
In-reply-to: <1470923574-411-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org

Hi,

On 08/11/2016 10:52 PM, Ritesh Harjani wrote:
> Few controllers (like MSM) may have to override div
> in certain cases. Hence provide a callback to get the
> div value for their driver.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cd65d47..cc3d6f2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1318,6 +1318,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  clock_set:
>  	if (real_div)
>  		*actual_clock = (host->max_clk * clk_mul) / real_div;
> +	/*
> +	 * Few controllers may have to override div
> +	 * here. Hence provide a callback to get the
> +	 * div value for them.
> +	 */
> +	if (host->ops->get_clk_div)
> +		div = host->ops->get_clk_div(host, div);

This is for only getting your div value. Few controllers?
Rather, use the existent callback function..It's better than adding new callback.

In your controller, add the your set_clock() callback. not get_clk_div.
(Well, Adrian might have other opinion.)

Best Regards,
Jaehoon Chung


> +
>  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>  		<< SDHCI_DIVIDER_HI_SHIFT;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0411c9f..4701001 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -562,6 +562,7 @@ struct sdhci_ops {
>  					 struct mmc_card *card,
>  					 unsigned int max_dtr, int host_drv,
>  					 int card_drv, int *drv_type);
> +	int	(*get_clk_div)(struct sdhci_host *host, int div);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 


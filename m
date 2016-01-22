From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: remove DW_MCI_QUIRK_BROKEN_CARD_DETECTION
 quirk
Date: Fri, 22 Jan 2016 11:06:38 +0900
Message-ID: <56A18EAE.6030900@samsung.com>
References: <1453359172-5977-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49697 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbcAVCGl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 21:06:41 -0500
In-reply-to: <1453359172-5977-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

On 01/21/2016 03:52 PM, Shawn Lin wrote:
> dw_mmc already use mmc_of_parse to get "broken-cd" property,
> but it considered "broken-cd" to be a quirk in its driver. We
> don't need this quirk here, and just take what we need from
> mmc->caps.

I have reverted the previous version, this version looks good to me.
I will apply this.

With Exynos SoCs,

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix wrong using of cur_slot
> 
>  drivers/mmc/host/dw_mmc.c  | 35 ++++++++++-------------------------
>  include/linux/mmc/dw_mmc.h |  4 +---
>  2 files changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7128351..96f173b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1450,12 +1450,11 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  {
>  	int present;
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> -	struct dw_mci_board *brd = slot->host->pdata;
>  	struct dw_mci *host = slot->host;
>  	int gpio_cd = mmc_gpio_get_cd(mmc);
>  
>  	/* Use platform get_cd function, else try onboard card detect */
> -	if ((brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) ||
> +	if ((mmc->caps & MMC_CAP_NEEDS_POLL) ||
>  	    (mmc->caps & MMC_CAP_NONREMOVABLE))
>  		present = 1;
>  	else if (!IS_ERR_VALUE(gpio_cd))
> @@ -2840,23 +2839,13 @@ static void dw_mci_dto_timer(unsigned long arg)
>  }
>  
>  #ifdef CONFIG_OF
> -static struct dw_mci_of_quirks {
> -	char *quirk;
> -	int id;
> -} of_quirks[] = {
> -	{
> -		.quirk	= "broken-cd",
> -		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> -	},
> -};
> -
>  static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  {
>  	struct dw_mci_board *pdata;
>  	struct device *dev = host->dev;
>  	struct device_node *np = dev->of_node;
>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
> -	int idx, ret;
> +	int ret;
>  	u32 clock_frequency;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> @@ -2871,11 +2860,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  		pdata->num_slots = 1;
>  	}
>  
> -	/* get quirks */
> -	for (idx = 0; idx < ARRAY_SIZE(of_quirks); idx++)
> -		if (of_get_property(np, of_quirks[idx].quirk, NULL))
> -			pdata->quirks |= of_quirks[idx].id;
> -
>  	if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
>  		dev_info(dev,
>  			 "fifo-depth property not found, using value of FIFOTH register as default\n");
> @@ -2908,18 +2892,19 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  
>  static void dw_mci_enable_cd(struct dw_mci *host)
>  {
> -	struct dw_mci_board *brd = host->pdata;
>  	unsigned long irqflags;
>  	u32 temp;
>  	int i;
> +	struct dw_mci_slot *slot;
>  
> -	/* No need for CD if broken card detection */
> -	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> -		return;
> -
> -	/* No need for CD if all slots have a non-error GPIO */
> +	/*
> +	 * No need for CD if all slots have a non-error GPIO
> +	 * as well as broken card detection is found.
> +	 */
>  	for (i = 0; i < host->num_slots; i++) {
> -		struct dw_mci_slot *slot = host->slot[i];
> +		slot = host->slot[i];
> +		if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
> +			return;
>  
>  		if (IS_ERR_VALUE(mmc_gpio_get_cd(slot->mmc)))
>  			break;
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 89df7ab..250d822 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -235,10 +235,8 @@ struct dw_mci_dma_ops {
>  };
>  
>  /* IP Quirks/flags. */
> -/* Unreliable card detection */
> -#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(0)
>  /* Timer for broken data transfer over scheme */
> -#define DW_MCI_QUIRK_BROKEN_DTO			BIT(1)
> +#define DW_MCI_QUIRK_BROKEN_DTO			BIT(0)
>  
>  struct dma_pdata;
>  
> 


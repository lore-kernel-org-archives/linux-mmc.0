From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove "disable-wp" property
Date: Mon, 18 Jan 2016 19:13:46 +0900
Message-ID: <569CBADA.20508@samsung.com>
References: <1453110604-8169-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51083 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbcARKNu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 05:13:50 -0500
In-reply-to: <1453110604-8169-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

On 01/18/2016 06:50 PM, Shawn Lin wrote:
> dw_mmc already use mmc_of_parse to get disable-wp,
> so we remove it from dw_mmc. And dw_mci_slot_of_parse
> will not be removed as well.

Yes, it's already used "mmc_of_parse".
You can see "slot quirks 'disable-wp' is deprecated".
Since the properties was included in slot regs before using "mmc_of_parse".

So we chosen to print the message "deprecated" to prevent the developer's confusion.
At this time, actually, i think there are no developers who confused this.

I will consider more about this patch.
Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 43 -------------------------------------------
>  1 file changed, 43 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index fddbcb6..8687554 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2493,47 +2493,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -#ifdef CONFIG_OF
> -/* given a slot, find out the device node representing that slot */
> -static struct device_node *dw_mci_of_find_slot_node(struct dw_mci_slot *slot)
> -{
> -	struct device *dev = slot->mmc->parent;
> -	struct device_node *np;
> -	const __be32 *addr;
> -	int len;
> -
> -	if (!dev || !dev->of_node)
> -		return NULL;
> -
> -	for_each_child_of_node(dev->of_node, np) {
> -		addr = of_get_property(np, "reg", &len);
> -		if (!addr || (len < sizeof(int)))
> -			continue;
> -		if (be32_to_cpup(addr) == slot->id)
> -			return np;
> -	}
> -	return NULL;
> -}
> -
> -static void dw_mci_slot_of_parse(struct dw_mci_slot *slot)
> -{
> -	struct device_node *np = dw_mci_of_find_slot_node(slot);
> -
> -	if (!np)
> -		return;
> -
> -	if (of_property_read_bool(np, "disable-wp")) {
> -		slot->mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
> -		dev_warn(slot->mmc->parent,
> -			"Slot quirk 'disable-wp' is deprecated\n");
> -	}
> -}
> -#else /* CONFIG_OF */
> -static void dw_mci_slot_of_parse(struct dw_mci_slot *slot)
> -{
> -}
> -#endif /* CONFIG_OF */
> -
>  static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  {
>  	struct mmc_host *mmc;
> @@ -2590,8 +2549,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (host->pdata->caps2)
>  		mmc->caps2 = host->pdata->caps2;
>  
> -	dw_mci_slot_of_parse(slot);
> -
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
>  		goto err_host_allocated;
> 


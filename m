From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove parsing for each slot subnode
Date: Tue, 26 Jul 2016 09:49:37 +0900
Message-ID: <5796B3A1.1050002@samsung.com>
References: <CGME20160715020607epcas1p1d7c7b7fd23c280be82d74d83225bf795@epcas1p1.samsung.com>
 <1468547254-805-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54068 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbcGZAtq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2016 20:49:46 -0400
In-reply-to: <1468547254-805-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/15/2016 10:47 AM, Shawn Lin wrote:
> The intention to remove it comes from the conflict of
> what the mmc-core does with the way dw_mmc treats disable-wp.
> We could see that 'disable-wp' is supported by core but
> it's deprecated by dw_mmc as we don't expect it to be existed
> for each slot subnode but should be in the parent node. Based
> on searching for all the upstream dts using dw_mmc, we're
> confident that none of them use the deprecated way. Maybe
> we should take old dtb in consideration but it was a flag day
> since the time we was considering to take it away. The fact is
> that there are none of dts using the deprecated way since v3.18
> or even earlier. So personally I don't believe the old dtb
> would/could bootup current kernel(may not?). Let's remove it now.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied on my repository. Thanks!

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/host/dw_mmc.c | 43 -------------------------------------------
>  1 file changed, 43 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2dfdc58..d0adddb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2523,47 +2523,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
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
> @@ -2620,8 +2579,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (host->pdata->caps2)
>  		mmc->caps2 = host->pdata->caps2;
>  
> -	dw_mci_slot_of_parse(slot);
> -
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
>  		goto err_host_allocated;
> 


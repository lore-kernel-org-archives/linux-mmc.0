From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv2 1/3] mmc: host: add slot argument to mmc_of_parse
Date: Tue, 27 May 2014 18:48:13 +0900
Message-ID: <002d01cf7990$c6faf220$54f0d660$%jun@samsung.com>
References: <1401104107-17651-1-git-send-email-jh80.chung@samsung.com>
 <1401104107-17651-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1401104107-17651-2-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Mon, May 26, 2014, Jaehoon Chung wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Some hosts manage several slots. In these case information such as the
> bus width, chip detect and others are into the slot node. So we have to
> parse child node. If not NULL, slot node will be used instead of the
> device node.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> ---
> Changelog V2:
> 	- Fix the typo.
> 
>  drivers/mmc/core/host.c  |   13 +++++++++----
>  include/linux/mmc/host.h |   10 +++++++++-
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 95cceae..0f677b3 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -298,15 +298,17 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
>  #endif
> 
>  /**
> - *	mmc_of_parse() - parse host's device-tree node
> + *	__mmc_of_parse() - parse host's device-tree node
>   *	@host: host whose node should be parsed.
> + *	@slot : some device provide several slots so the node to parse
> + *		is not the host one.
>   *
>   * To keep the rest of the MMC subsystem unaware of whether DT has been
>   * used to to instantiate and configure this host instance or not, we
>   * parse the properties and set respective generic mmc-host flags and
>   * parameters.
>   */
> -int mmc_of_parse(struct mmc_host *host)
> +int __mmc_of_parse(struct mmc_host *host, struct device_node *slot)
>  {
>  	struct device_node *np;
>  	u32 bus_width;
> @@ -317,7 +319,10 @@ int mmc_of_parse(struct mmc_host *host)
>  	if (!host->parent || !host->parent->of_node)
>  		return 0;
> 
> -	np = host->parent->of_node;
> +	if (slot)
> +		np = slot;
> +	else
> +		np = host->parent->of_node;
> 
>  	/* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
>  	if (of_property_read_u32(np, "bus-width", &bus_width) < 0) {
> @@ -459,7 +464,7 @@ out:
>  	return ret;
>  }
> 
> -EXPORT_SYMBOL(mmc_of_parse);
> +EXPORT_SYMBOL(__mmc_of_parse);
> 
>  /**
>   *	mmc_alloc_host - initialise the per-host structure.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7960424..c62af91 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -372,7 +372,15 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> -int mmc_of_parse(struct mmc_host *host);
> +int __mmc_of_parse(struct mmc_host *host, struct device_node *slot);
> +/*
> + * mmc_of_parse - parse host's device-tree node
> + *	@host: host whose node should be parsed.
> + */
> +static inline int mmc_of_parse(struct mmc_host *host)
> +{
> +	return __mmc_of_parse(host, NULL);
> +}
> 
>  static inline void *mmc_priv(struct mmc_host *host)
>  {
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/3] mmc: host: add slot argument to mmc_of_parse
Date: Mon, 26 May 2014 10:09:16 +0200
Message-ID: <20140526080916.GE12777@ldesroches-Latitude-E6320>
References: <1400840721-11050-1-git-send-email-jh80.chung@samsung.com>
 <1400840721-11050-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400840721-11050-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 23, 2014 at 07:25:19PM +0900, Jaehoon Chung wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Some hosts manage several slots. In these case information such as the
> bus width, chi detect and others are into the slot node. So we have to

/s/chi detect/chip detect

> parse child node. If not NULL, slot node will be used instead of the
> device node.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
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

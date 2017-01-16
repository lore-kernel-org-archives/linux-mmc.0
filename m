From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 08/15] mmc: core: Move some host specific public
 functions to host.h
Date: Mon, 16 Jan 2017 11:02:17 +0800
Message-ID: <9d3598d0-8f75-17cf-74c6-720d67dcbcb7@rock-chips.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:37676 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdAPDDK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 22:03:10 -0500
In-Reply-To: <1484313256-25993-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 2017/1/13 21:14, Ulf Hansson wrote:
> Ideally the public mmc header file, core.h, shouldn't contain interfaces
> particularly intended to be used by host drivers. Instead those should
> remain in the host.h header file. Therefore, let's move a couple functions
> from core.h to host.h.
>


Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/mmc/core.h | 6 ------
>  include/linux/mmc/host.h | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index e679a86..faacc90 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -163,8 +163,6 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>  					   enum mmc_blk_status *);
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
> -extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
> -extern int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
>
>  #define MMC_ERASE_ARG		0x00000000
>  #define MMC_SECURE_ERASE_ARG	0x80000000
> @@ -179,8 +177,4 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>  extern int mmc_hw_reset(struct mmc_host *host);
>  extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
>
> -struct device_node;
> -extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> -extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
> -
>  #endif /* LINUX_MMC_CORE_H */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8d38c76..7de0519 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -392,11 +392,14 @@ struct mmc_host {
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>
> +struct device_node;
> +
>  struct mmc_host *mmc_alloc_host(int extra, struct device *);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
>  int mmc_of_parse(struct mmc_host *host);
> +int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
>
>  static inline void *mmc_priv(struct mmc_host *host)
>  {
> @@ -452,6 +455,7 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
>  }
>  #endif
>
> +u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>
>  static inline int mmc_card_is_removable(struct mmc_host *host)
> @@ -538,6 +542,8 @@ static inline bool mmc_can_retune(struct mmc_host *host)
>  	return host->can_retune == 1;
>  }
>
> +int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
> +int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
>  void mmc_retune_pause(struct mmc_host *host);
>  void mmc_retune_unpause(struct mmc_host *host);
>
>


-- 
Best Regards
Shawn Lin


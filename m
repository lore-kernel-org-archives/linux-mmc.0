From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 15/15] mmc: core: Don't use extern declarations of
 public mmc functions
Date: Mon, 16 Jan 2017 11:16:05 +0800
Message-ID: <3fef6372-ee5e-bcae-1d5f-199b73100a68@rock-chips.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-16-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:35188 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdAPDQx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 22:16:53 -0500
In-Reply-To: <1484313256-25993-16-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 2017/1/13 21:14, Ulf Hansson wrote:
> Using extern when declaring functions in the public header, core.h, is
> redundant. Let's just remove the use of it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/mmc/core.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>


Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 6440e10..6dcb339 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -158,13 +158,14 @@ struct mmc_request {
>  struct mmc_card;
>  struct mmc_async_req;
>
> -extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
> -					   struct mmc_async_req *,
> -					   enum mmc_blk_status *);
> -extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
> -extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
> -
> -extern int mmc_hw_reset(struct mmc_host *host);
> -extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
> +struct mmc_async_req *mmc_start_req(struct mmc_host *host,
> +				struct mmc_async_req *areq,
> +				enum mmc_blk_status *ret_stat);
> +void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
> +int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
> +		int retries);
> +
> +int mmc_hw_reset(struct mmc_host *host);
> +void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>
>  #endif /* LINUX_MMC_CORE_H */
>


-- 
Best Regards
Shawn Lin


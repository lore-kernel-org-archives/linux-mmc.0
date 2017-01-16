From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 09/15] mmc: core: Move erase/trim/discard defines from
 public core.h to mmc.h
Date: Mon, 16 Jan 2017 11:05:34 +0800
Message-ID: <7c4e3f95-0273-f8a0-bcf3-7a1a0ae88b70@rock-chips.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:38525 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdAPDGZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 22:06:25 -0500
In-Reply-To: <1484313256-25993-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

ÔÚ 2017/1/13 21:14, Ulf Hansson Ð´µÀ:
> As the public mmc.h header already contains similar defines for other mmc
> commands and arguments, let's move those for erase/trim/discard into here
> as well.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/mmc/core.h | 10 ----------
>  include/linux/mmc/mmc.h  | 13 ++++++++++++-
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index faacc90..6440e10 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -164,16 +164,6 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
>
> -#define MMC_ERASE_ARG		0x00000000
> -#define MMC_SECURE_ERASE_ARG	0x80000000
> -#define MMC_TRIM_ARG		0x00000001
> -#define MMC_DISCARD_ARG		0x00000003
> -#define MMC_SECURE_TRIM1_ARG	0x80000001
> -#define MMC_SECURE_TRIM2_ARG	0x80008000
> -
> -#define MMC_SECURE_ARGS		0x80000000
> -#define MMC_TRIM_ARGS		0x00008001
> -
>  extern int mmc_hw_reset(struct mmc_host *host);
>  extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 261772e..8f78543 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -462,12 +462,23 @@ struct _mmc_csd {
>  /*
>   * MMC_SWITCH access modes
>   */
> -

It's not relevant to remove this blank line?

Otherwise,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>  #define MMC_SWITCH_MODE_CMD_SET		0x00	/* Change the command set */
>  #define MMC_SWITCH_MODE_SET_BITS	0x01	/* Set bits which are 1 in value */
>  #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
>  #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
>
> +/*
> + * Erase/trim/discard
> + */
> +#define MMC_ERASE_ARG			0x00000000
> +#define MMC_SECURE_ERASE_ARG		0x80000000
> +#define MMC_TRIM_ARG			0x00000001
> +#define MMC_DISCARD_ARG			0x00000003
> +#define MMC_SECURE_TRIM1_ARG		0x80000001
> +#define MMC_SECURE_TRIM2_ARG		0x80008000
> +#define MMC_SECURE_ARGS			0x80000000
> +#define MMC_TRIM_ARGS			0x00008001
> +
>  #define mmc_driver_type_mask(n)		(1 << (n))
>
>  #endif /* LINUX_MMC_MMC_H */
>


-- 
Best Regards
Shawn Lin


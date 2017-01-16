From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 07/15] mmc: core: Move public functions from core.h to
 private headers
Date: Mon, 16 Jan 2017 11:01:11 +0800
Message-ID: <87e14348-b6fa-4962-ef3b-ac9a35d37da3@rock-chips.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:57823 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdAPDB7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 22:01:59 -0500
In-Reply-To: <1484313256-25993-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 2017/1/13 21:14, Ulf Hansson wrote:
> A significant amount of functions are available through the public mmc
> core.h header file. Let's slim down this public mmc interface, as to
> prevent users from abusing it, by moving some of the functions to private
> mmc header files.
>
> This change concentrates on moving the functions into private mmc headers,
> following changes may continue with additional clean-ups, as an example
> some functions can be turned into static.
>

[...]

> @@ -16,6 +16,7 @@
>  #include <linux/mmc/sdio_func.h>
>
>  #include "sdio_ops.h"
> +#include "core.h"
>

Should we need move it before sdio_ops.h to
slightly keep the order? The same for sdio_orq.c change :)

Otherwise,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>  /**
>   *	sdio_claim_host - exclusively claim a bus for a certain SDIO function
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index f1faf9a..d084635 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -27,6 +27,7 @@
>  #include <linux/mmc/sdio_func.h>
>
>  #include "sdio_ops.h"
> +#include "core.h"
>
>  static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
> diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
> index e1c36d6..bed8a83 100644
> --- a/drivers/mmc/core/sdio_ops.h
> +++ b/drivers/mmc/core/sdio_ops.h
> @@ -24,6 +24,7 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
>  int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>  	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
>  int sdio_reset(struct mmc_host *host);
> +unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz);
>
>  static inline bool mmc_is_io_op(u32 opcode)
>  {
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 64e2ddf..e679a86 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -158,25 +158,13 @@ struct mmc_request {
>  struct mmc_card;
>  struct mmc_async_req;
>
> -extern int mmc_stop_bkops(struct mmc_card *);
> -extern int mmc_read_bkops_status(struct mmc_card *);
>  extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>  					   struct mmc_async_req *,
>  					   enum mmc_blk_status *);
> -extern int mmc_interrupt_hpi(struct mmc_card *);
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
> -extern void mmc_wait_for_req_done(struct mmc_host *host,
> -				  struct mmc_request *mrq);
> -extern bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
> -extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
> -extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
> -	struct mmc_command *, int);
> -extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
> -extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
>  extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  extern int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
> -extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>
>  #define MMC_ERASE_ARG		0x00000000
>  #define MMC_SECURE_ERASE_ARG	0x80000000
> @@ -188,46 +176,8 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
>  #define MMC_SECURE_ARGS		0x80000000
>  #define MMC_TRIM_ARGS		0x00008001
>
> -extern int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
> -		     unsigned int arg);
> -extern int mmc_can_erase(struct mmc_card *card);
> -extern int mmc_can_trim(struct mmc_card *card);
> -extern int mmc_can_discard(struct mmc_card *card);
> -extern int mmc_can_sanitize(struct mmc_card *card);
> -extern int mmc_can_secure_erase_trim(struct mmc_card *card);
> -extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
> -				   unsigned int nr);
> -extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
> -
> -extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
> -extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
> -			      bool is_rel_write);
>  extern int mmc_hw_reset(struct mmc_host *host);
> -extern int mmc_can_reset(struct mmc_card *card);
> -
>  extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
> -extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
> -
> -extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
> -extern void mmc_release_host(struct mmc_host *host);
> -
> -extern void mmc_get_card(struct mmc_card *card);
> -extern void mmc_put_card(struct mmc_card *card);
> -
> -extern int mmc_flush_cache(struct mmc_card *);
> -
> -extern int mmc_detect_card_removed(struct mmc_host *host);
> -
> -/**
> - *	mmc_claim_host - exclusively claim a host
> - *	@host: mmc host to claim
> - *
> - *	Claim a host for a set of operations.
> - */
> -static inline void mmc_claim_host(struct mmc_host *host)
> -{
> -	__mmc_claim_host(host, NULL);
> -}
>
>  struct device_node;
>  extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>


-- 
Best Regards
Shawn Lin


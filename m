From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH V3 1/2] mmc: dw_mmc: Convert to mmc_send_tuning()
Date: Wed, 24 Dec 2014 19:41:41 +0530
Message-ID: <CAGOxZ52rsfgtDM=a6aHp24cDMWguB7ML+Hg3zvkby=W1pHTcUw@mail.gmail.com>
References: <1419350569-7238-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:45172 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaLXOMW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Dec 2014 09:12:22 -0500
Received: by mail-yk0-f181.google.com with SMTP id 142so3928099ykq.12
        for <linux-mmc@vger.kernel.org>; Wed, 24 Dec 2014 06:12:21 -0800 (PST)
In-Reply-To: <1419350569-7238-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

Hi Ulf,

On Tue, Dec 23, 2014 at 9:32 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Instead of having a local hack taking care of sending the tuning
> command and as well to verify the response pattern, let's convert to
> the common mmc_send_tuning() API.
>
> This change affects the Exynos variant, since it's the only one which
> support the dw_mmc's ->execute_tuning() callback.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
yes, this works fine now, with the other patch which add STOP command,
and I don't need to modify  DT timing values. So,

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Tested on exynos5800-peach-pi board, so

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

> Changes in v3:
>         Fix return value from dw_mci_exynos_execute_tuning() according to
>         comment from Jaehoon Chung.
>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 48 +++-------------------------------------
>  drivers/mmc/host/dw_mmc.c        | 22 +-----------------
>  drivers/mmc/host/dw_mmc.h        |  8 +------
>  3 files changed, 5 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 74eb081..12a5eaa 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -340,64 +340,23 @@ out:
>         return loc;
>  }
>
> -static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
> -                                       struct dw_mci_tuning_data *tuning_data)
> +static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
>  {
>         struct dw_mci *host = slot->host;
>         struct mmc_host *mmc = slot->mmc;
> -       const u8 *blk_pattern = tuning_data->blk_pattern;
> -       u8 *blk_test;
> -       unsigned int blksz = tuning_data->blksz;
>         u8 start_smpl, smpl, candiates = 0;
>         s8 found = -1;
>         int ret = 0;
>
> -       blk_test = kmalloc(blksz, GFP_KERNEL);
> -       if (!blk_test)
> -               return -ENOMEM;
> -
>         start_smpl = dw_mci_exynos_get_clksmpl(host);
>
>         do {
> -               struct mmc_request mrq = {NULL};
> -               struct mmc_command cmd = {0};
> -               struct mmc_command stop = {0};
> -               struct mmc_data data = {0};
> -               struct scatterlist sg;
> -
> -               cmd.opcode = opcode;
> -               cmd.arg = 0;
> -               cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> -
> -               stop.opcode = MMC_STOP_TRANSMISSION;
> -               stop.arg = 0;
> -               stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
> -
> -               data.blksz = blksz;
> -               data.blocks = 1;
> -               data.flags = MMC_DATA_READ;
> -               data.sg = &sg;
> -               data.sg_len = 1;
> -
> -               sg_init_one(&sg, blk_test, blksz);
> -               mrq.cmd = &cmd;
> -               mrq.stop = &stop;
> -               mrq.data = &data;
> -               host->mrq = &mrq;
> -
>                 mci_writel(host, TMOUT, ~0);
>                 smpl = dw_mci_exynos_move_next_clksmpl(host);
>
> -               mmc_wait_for_req(mmc, &mrq);
> +               if (!mmc_send_tuning(mmc))
> +                       candiates |= (1 << smpl);
>
> -               if (!cmd.error && !data.error) {
> -                       if (!memcmp(blk_pattern, blk_test, blksz))
> -                               candiates |= (1 << smpl);
> -               } else {
> -                       dev_dbg(host->dev,
> -                               "Tuning error: cmd.error:%d, data.error:%d\n",
> -                               cmd.error, data.error);
> -               }
>         } while (start_smpl != smpl);
>
>         found = dw_mci_exynos_get_best_clksmpl(candiates);
> @@ -406,7 +365,6 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>         else
>                 ret = -EIO;
>
> -       kfree(blk_test);
>         return ret;
>  }
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6e4d864..88dc50f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1312,30 +1312,10 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         struct dw_mci *host = slot->host;
>         const struct dw_mci_drv_data *drv_data = host->drv_data;
> -       struct dw_mci_tuning_data tuning_data;
>         int err = -ENOSYS;
>
> -       if (opcode == MMC_SEND_TUNING_BLOCK_HS200) {
> -               if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> -                       tuning_data.blk_pattern = tuning_blk_pattern_8bit;
> -                       tuning_data.blksz = sizeof(tuning_blk_pattern_8bit);
> -               } else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> -                       tuning_data.blk_pattern = tuning_blk_pattern_4bit;
> -                       tuning_data.blksz = sizeof(tuning_blk_pattern_4bit);
> -               } else {
> -                       return -EINVAL;
> -               }
> -       } else if (opcode == MMC_SEND_TUNING_BLOCK) {
> -               tuning_data.blk_pattern = tuning_blk_pattern_4bit;
> -               tuning_data.blksz = sizeof(tuning_blk_pattern_4bit);
> -       } else {
> -               dev_err(host->dev,
> -                       "Undefined command(%d) for tuning\n", opcode);
> -               return -EINVAL;
> -       }
> -
>         if (drv_data && drv_data->execute_tuning)
> -               err = drv_data->execute_tuning(slot, opcode, &tuning_data);
> +               err = drv_data->execute_tuning(slot);
>         return err;
>  }
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index d27d4c0..18c4afe 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -249,11 +249,6 @@ struct dw_mci_slot {
>         int                     sdio_id;
>  };
>
> -struct dw_mci_tuning_data {
> -       const u8 *blk_pattern;
> -       unsigned int blksz;
> -};
> -
>  /**
>   * dw_mci driver data - dw-mshc implementation specific driver data.
>   * @caps: mmc subsystem specified capabilities of the controller(s).
> @@ -275,7 +270,6 @@ struct dw_mci_drv_data {
>         void            (*prepare_command)(struct dw_mci *host, u32 *cmdr);
>         void            (*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>         int             (*parse_dt)(struct dw_mci *host);
> -       int             (*execute_tuning)(struct dw_mci_slot *slot, u32 opcode,
> -                                       struct dw_mci_tuning_data *tuning_data);
> +       int             (*execute_tuning)(struct dw_mci_slot *slot);
>  };
>  #endif /* _DW_MMC_H_ */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim

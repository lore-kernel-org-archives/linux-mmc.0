From: shashidhar hiremath <shashidar1887@gmail.com>
Subject: Re: [PATCH v3 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Tue, 21 Aug 2012 12:47:35 +0530
Message-ID: <CAPM_RLb9P61E+DVQh6e_gFO5QtcVLbxmEPX4WBVO_XxHA=7Saw@mail.gmail.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	<1344265951-22437-6-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61002 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab2HUHRg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Aug 2012 03:17:36 -0400
Received: by vcbfk26 with SMTP id fk26so5816196vcb.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Aug 2012 00:17:35 -0700 (PDT)
In-Reply-To: <1344265951-22437-6-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>, Loic Pallardy <loic.pallardy@stericsson.com>

On Mon, Aug 6, 2012 at 8:42 PM, Loic Pallardy
<loic.pallardy-ext@stericsson.com> wrote:
>
> RPMB partition is accessing though /dev/block/mmcXrpmb device
> User callers can read and write entire data frame(s) as defined
> by JEDEC Standard JESD84-A441, using standard IOCTL interface.
>
> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> ---
>  drivers/mmc/card/block.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index d8edb8d..a9e1f1f 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -126,6 +126,10 @@ enum mmc_blk_status {
>  module_param(perdev_minors, int, 0444);
>  MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
>
> +static inline int mmc_blk_part_switch(struct mmc_card *card,
> +                                     struct mmc_blk_data *md);
> +static int get_card_status(struct mmc_card *card, u32 *status, int retries);
> +
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
>         struct mmc_blk_data *md;
> @@ -357,6 +361,38 @@ out:
>         return ERR_PTR(err);
>  }
>
> +static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
> +                                      u32 retries_max)
> +{
> +       int err;
> +       u32 retry_count = 0;
> +
> +       if (!status || !retries_max)
> +               return -EINVAL;
> +
> +       do {
> +               err = get_card_status(card, status, 5);
> +               if (err)
> +                       break;
> +
> +               if (!R1_STATUS(*status) &&
> +                               (R1_CURRENT_STATE(*status) != R1_STATE_PRG))
> +                       break; /* RPMB programming operation complete */
> +
> +               /*
> +                * Rechedule to give the MMC device a chance to continue
> +                * processing the previous command without being polled too
> +                * frequently.
> +                */
> +               usleep_range(1000, 5000);
> +       } while (++retry_count < retries_max);
> +
> +       if (retry_count == retries_max)
> +               err = -EPERM;
> +
> +       return err;
> +}
> +
>  static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>         struct mmc_ioc_cmd __user *ic_ptr)
>  {
> @@ -368,6 +404,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>         struct mmc_request mrq = {NULL};
>         struct scatterlist sg;
>         int err;
> +       int is_rpmb = false;
> +       u32 status = 0;
>
>         /*
>          * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> @@ -387,6 +425,9 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>                 goto cmd_err;
>         }
>
> +       if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
> +               is_rpmb = true;
> +
>         card = md->queue.card;
>         if (IS_ERR(card)) {
>                 err = PTR_ERR(card);
> @@ -437,12 +478,23 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>
>         mmc_claim_host(card->host);
>
> +       err = mmc_blk_part_switch(card, md);
> +       if (err)
> +               goto cmd_rel_host;
> +
>         if (idata->ic.is_acmd) {
>                 err = mmc_app_cmd(card->host, card);
>                 if (err)
>                         goto cmd_rel_host;
>         }
>
> +       if (is_rpmb) {
> +               err = mmc_set_blockcount(card, data.blocks,
> +                       idata->ic.write_flag & (1 << 31));
> +               if (err)
> +                       goto cmd_rel_host;
> +       }
> +
>         mmc_wait_for_req(card->host, &mrq);
>
>         if (cmd.error) {
> @@ -478,6 +530,18 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>                 }
>         }
>
> +       if (is_rpmb) {
> +               /*
> +                * Ensure RPMB command has completed by polling CMD13
> +                * "Send Status".
> +                */
> +               err = ioctl_rpmb_card_status_poll(card, &status, 5);
> +               if (err)
> +                       dev_err(mmc_dev(card->host),
> +                                       "%s: Card Status=0x%08X, error %d\n",
> +                                       __func__, status, err);
> +       }
> +
>  cmd_rel_host:
>         mmc_release_host(card->host);
>
> --
> 1.7.11.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hi,
  Any specific reason why the RPMB support is implemented using the
IOCTL interface. Can this be done by the Kernel itself instead of
being initiated by a user space application ?

--
regards,
Shashidhar Hiremath

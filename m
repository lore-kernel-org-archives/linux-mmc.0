From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: remove unnecessary assignment statements before return
Date: Wed, 27 Jan 2016 15:15:35 +0100
Message-ID: <CAPDyKFo2Kd52QD_r3hZjPV7XNdPCP=3B29083n9Y7dTsbSXZgw@mail.gmail.com>
References: <1452219325-25357-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452219325-25357-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 8 January 2016 at 03:15, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Variable assignment just before return is redundant.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next.

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/mmc_ops.c  | 19 ++++---------------
>  drivers/mmc/core/sd_ops.c   |  7 +------
>  drivers/mmc/core/sdio_ops.c |  3 +--
>  3 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 1f44426..ddbb918 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -90,7 +90,6 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
>
>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
> -       int err;
>         struct mmc_command cmd = {0};
>
>         BUG_ON(!host);
> @@ -105,11 +104,7 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>                 cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;
>         }
>
> -       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>  }
>
>  int mmc_select_card(struct mmc_card *card)
> @@ -244,7 +239,6 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
>
>  int mmc_set_relative_addr(struct mmc_card *card)
>  {
> -       int err;
>         struct mmc_command cmd = {0};
>
>         BUG_ON(!card);
> @@ -254,11 +248,7 @@ int mmc_set_relative_addr(struct mmc_card *card)
>         cmd.arg = card->rca << 16;
>         cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>
> -       err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>  }
>
>  static int
> @@ -736,7 +726,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>
>  int mmc_bus_test(struct mmc_card *card, u8 bus_width)
>  {
> -       int err, width;
> +       int width;
>
>         if (bus_width == MMC_BUS_WIDTH_8)
>                 width = 8;
> @@ -752,8 +742,7 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
>          * is a problem.  This improves chances that the test will work.
>          */
>         mmc_send_bus_test(card, card->host, MMC_BUS_TEST_W, width);
> -       err = mmc_send_bus_test(card, card->host, MMC_BUS_TEST_R, width);
> -       return err;
> +       return mmc_send_bus_test(card, card->host, MMC_BUS_TEST_R, width);
>  }
>
>  int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 48d0c93..16b774c 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -120,7 +120,6 @@ EXPORT_SYMBOL(mmc_wait_for_app_cmd);
>
>  int mmc_app_set_bus_width(struct mmc_card *card, int width)
>  {
> -       int err;
>         struct mmc_command cmd = {0};
>
>         BUG_ON(!card);
> @@ -140,11 +139,7 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
>                 return -EINVAL;
>         }
>
> -       err = mmc_wait_for_app_cmd(card->host, card, &cmd, MMC_CMD_RETRIES);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return mmc_wait_for_app_cmd(card->host, card, &cmd, MMC_CMD_RETRIES);
>  }
>
>  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 62508b4..34f6e80 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -217,7 +217,6 @@ int sdio_reset(struct mmc_host *host)
>         else
>                 abort |= 0x08;
>
> -       ret = mmc_io_rw_direct_host(host, 1, 0, SDIO_CCCR_ABORT, abort, NULL);
> -       return ret;
> +       return mmc_io_rw_direct_host(host, 1, 0, SDIO_CCCR_ABORT, abort, NULL);
>  }
>
> --
> 1.9.1
>

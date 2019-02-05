From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: Calculate the discard arg only once
Date: Tue, 5 Feb 2019 14:33:12 +0100
Message-ID: <CAPDyKFqO0RX-Nz+WDo6VA5Sqh-npJKkqfHN9cpH6gxMPo1tJPw@mail.gmail.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com> <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avri Altman <avri.altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 3 Feb 2019 at 09:51, Avri Altman <avri.altman@wdc.com> wrote:
>
> The discard arg is a read-only ext_csd parameter -
> set it once on card init.

I like the idea here. There is really no point checking this for every
corresponding request, nice!

However, the "discard arg" isn't specific to eMMC, as it's also used
for SD cards. So, the change log is a bit miss-leading, I think. Can
you please clarify this.

>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 12 +++---------
>  drivers/mmc/core/mmc.c   |  8 ++++++++
>  include/linux/mmc/card.h |  2 ++
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b08fb91..3502f2c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1124,7 +1124,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
>         struct mmc_card *card = md->queue.card;
> -       unsigned int from, nr, arg;
> +       unsigned int from, nr;
>         int err = 0, type = MMC_BLK_DISCARD;
>         blk_status_t status = BLK_STS_OK;
>
> @@ -1136,24 +1136,18 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>         from = blk_rq_pos(req);
>         nr = blk_rq_sectors(req);
>
> -       if (mmc_can_discard(card))
> -               arg = MMC_DISCARD_ARG;
> -       else if (mmc_can_trim(card))
> -               arg = MMC_TRIM_ARG;
> -       else
> -               arg = MMC_ERASE_ARG;
>         do {
>                 err = 0;
>                 if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>                         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                          INAND_CMD38_ARG_EXT_CSD,
> -                                        arg == MMC_TRIM_ARG ?
> +                                        card->discard_arg == MMC_TRIM_ARG ?
>                                          INAND_CMD38_ARG_TRIM :
>                                          INAND_CMD38_ARG_ERASE,
>                                          0);
>                 }
>                 if (!err)
> -                       err = mmc_erase(card, from, nr, arg);
> +                       err = mmc_erase(card, from, nr, card->discard_arg);
>         } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>         if (err)
>                 status = BLK_STS_IOERR;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index da892a5..120739c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
>         }
>
> +       /* set discard_arg */
> +       if (mmc_can_discard(card))
> +               card->discard_arg = MMC_DISCARD_ARG;
> +       else if (mmc_can_trim(card))
> +               card->discard_arg = MMC_TRIM_ARG;
> +       else
> +               card->discard_arg = MMC_ERASE_ARG;

You are assigning card->discard_arg only for (e)MMC, while I think you
should do that also for SD.

I guess it practice it doesn't matter, because MMC_ERASE_ARG is zero.
Although, I would prefer to keep the code consistent, so I think you
should assign card->discard_arg for for SD cards as well.

> +
>         /*
>          * Select timing interface
>          */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index de73778..447648b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -308,6 +308,8 @@ struct mmc_card {
>         unsigned int    nr_parts;
>
>         unsigned int            bouncesz;       /* Bounce buffer size */
> +
> +       unsigned int            discard_arg;    /* discard args */

Please move this a couple of lines above, close to the other "erase"
related variables.

You may even consider to rename the arg to "erase_arg", but I have no
strong opinion changing to that.

>  };
>
>  static inline bool mmc_large_sector(struct mmc_card *card)
> --
> 1.9.1
>

Kind regards
Uffe

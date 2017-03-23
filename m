From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V1] mmc: core: fix still flush cache when eMMC cache off
Date: Thu, 23 Mar 2017 11:03:23 +0100
Message-ID: <CAPDyKFoy_EDRNkicPAMPReB3GCxZPkO+H9Jh14nxg3YfVzchOw@mail.gmail.com>
References: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34940 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdCWKDZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 06:03:25 -0400
Received: by mail-ua0-f173.google.com with SMTP id q7so90708833uaf.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 03:03:24 -0700 (PDT)
In-Reply-To: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "axboe@fb.com" <axboe@fb.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>

On 19 March 2017 at 01:45, Bean Huo (beanhuo) <beanhuo@micron.com> wrote:
> This patch fixes the issue that mmc_blk_issue_rq still
> flushes cache when eMMC cache has already been off
> through user space tool, such as mmc-utils.
> The reason is that card->ext_csd.cache_ctrl isn't reset.

First, why do you want to turn of the cache ctrl? Is the eMMC device
having issues with it? Then we should invent a card quirk instead.

Second, what errors do you encounter when the mmc core tries to flush
the cache when it has been turned off? Can you please elaborate on
this.

>
> Signed-off-by: beanhuo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/block.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1621fa0..fb3635ac 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -64,6 +64,7 @@ MODULE_ALIAS("mmc:block");
>  #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
>  #define MMC_SANITIZE_REQ_TIMEOUT 240000
>  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> +#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
>
>  #define mmc_req_rel_wr(req)    ((req->cmd_flags & REQ_FUA) && \
>                                   (rq_data_dir(req) == WRITE))
> @@ -535,6 +536,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                 return data.error;
>         }
>
> +       if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
> +           (cmd.opcode == MMC_SWITCH) && (card->ext_csd.cache_size > 0)) {
> +               if (MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1)
> +                       card->ext_csd.cache_ctrl = 1;
> +               else
> +                       card->ext_csd.cache_ctrl = 0;
> +       }
> +

I am sure "cache ctrl" isn't the only thing user space via mmc ioctl
can cause problems for. The mmc core keep tracks of other ext csd
states, etc, as well. I don't think it's worth to compensate and try
to act accordingly to cover cases when user space has messed up.

To be clear, it would have been entirely different if the something
was changed via a mmc sysfs interface. Then we really should act
accordingly, however for mmc ioctls it just becomes unmanageable due
to its flexibility.

>         /*
>          * According to the SD specs, some commands require a delay after
>          * issuing the command.
> --
> 2.7.4

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc-utils: feature spec 5.0+, Pre EOL information
Date: Mon, 20 Mar 2017 13:07:48 +0100
Message-ID: <CAPDyKFpj8UqbY-Y2z8u-R52B-oLL-_bPyj1idqptcRpnhf+70w@mail.gmail.com>
References: <20170320110709.31079-1-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34612 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbdCTMHz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 08:07:55 -0400
Received: by mail-vk0-f47.google.com with SMTP id z204so11656272vkd.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2017 05:07:54 -0700 (PDT)
In-Reply-To: <20170320110709.31079-1-alexander.stein@systec-electronic.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 20 March 2017 at 12:07, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Alexander, Chris Ball is the maintainer of mmc-utils. I think you
should re-post and make sure he is on the to list.

Kind regards
Uffe

> ---
>  mmc.h      | 1 +
>  mmc_cmds.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/mmc.h b/mmc.h
> index f3fa03f..fa49df6 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -63,6 +63,7 @@
>  #define EXT_CSD_NUM_OF_FW_SEC_PROG_0   302     /* RO */
>  #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B     269     /* RO */
>  #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A     268     /* RO */
> +#define EXT_CSD_PRE_EOL_INFO           267     /* RO */
>  #define EXT_CSD_FIRMWARE_VERSION       254     /* RO */
>  #define EXT_CSD_CACHE_SIZE_3           252
>  #define EXT_CSD_CACHE_SIZE_2           251
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 0e4322e..728ad77 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1748,6 +1748,11 @@ int do_read_extcsd(int nargs, char **argv)
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
>         }
>
> +       if (ext_csd_rev >= 7) {
> +               printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
> +                       ext_csd[EXT_CSD_PRE_EOL_INFO]);
> +       }
> +
>         if (ext_csd_rev >= 8) {
>                 printf("Command Queue Support [CMDQ_SUPPORT]: 0x%02x\n",
>                        ext_csd[EXT_CSD_CMDQ_SUPPORT]);
> --
> 2.10.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

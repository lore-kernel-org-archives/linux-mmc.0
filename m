From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: make MAN_BKOPS_EN message a debug
Date: Fri, 29 Jan 2016 12:41:00 +0100
Message-ID: <CAPDyKFqzQsf_EXwF+Z6b3n6vQ-2UHCxBHYy-R47hUfVN-tkpKg@mail.gmail.com>
References: <1453749492-2064-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36236 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943AbcA2LlB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 06:41:01 -0500
Received: by mail-yk0-f175.google.com with SMTP id v14so65180633ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jan 2016 03:41:00 -0800 (PST)
In-Reply-To: <1453749492-2064-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

On 25 January 2016 at 20:18, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> IMO this info is only useful for developers. Most users won't need this
> information, since there is not much they can do about it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index bf49e44571f20a..07a135bc893057 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -501,7 +501,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                         card->ext_csd.raw_bkops_status =
>                                 ext_csd[EXT_CSD_BKOPS_STATUS];
>                         if (!card->ext_csd.man_bkops_en)
> -                               pr_info("%s: MAN_BKOPS_EN bit is not set\n",
> +                               pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
>                                         mmc_hostname(card->host));
>                 }
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

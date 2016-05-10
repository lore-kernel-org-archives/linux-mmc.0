From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdio: fall back to SDIO 1.0 for broken 1.1 cards
Date: Tue, 10 May 2016 12:28:29 +0200
Message-ID: <CAPDyKFqCwxzkc1EeTE7jDBkfDXRznKphdcAH85YVYOHrNKjk6Q@mail.gmail.com>
References: <1462780799-5366-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37401 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbcEJK2b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 06:28:31 -0400
Received: by mail-wm0-f51.google.com with SMTP id a17so19172543wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 03:28:30 -0700 (PDT)
In-Reply-To: <1462780799-5366-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

On 9 May 2016 at 09:59, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I have two SDIO WLAN cards which specify being SDIO Rev. 1.1 cards but
> their FUNCE tuple reports the smaller size of a Rev 1.0 card. So,
> enforce 1.0 on these cards to avoid reading the not present registers.
> They are not really used anyhow. My cards initialize properly after this
> patch.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_cis.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index 6f6fc527a26338..dcb3dee59fa5f2 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -177,8 +177,13 @@ static int cistpl_funce_func(struct mmc_card *card, struct sdio_func *func,
>         vsn = func->card->cccr.sdio_vsn;
>         min_size = (vsn == SDIO_SDIO_REV_1_00) ? 28 : 42;
>
> -       if (size < min_size)
> +       if (size == 28 && vsn == SDIO_SDIO_REV_1_10) {
> +               pr_warn("%s: card has broken SDIO 1.1 CIS, forcing SDIO 1.0\n",
> +                       mmc_hostname(card->host));
> +               vsn = SDIO_SDIO_REV_1_00;
> +       } else if (size < min_size) {
>                 return -EINVAL;
> +       }
>
>         /* TPLFE_MAX_BLK_SIZE */
>         func->max_blksize = buf[12] | (buf[13] << 8);
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

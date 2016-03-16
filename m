From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: remove redundant memset of sdio_read_cccr
Date: Wed, 16 Mar 2016 12:38:15 +0100
Message-ID: <CAPDyKFrCP4SB9e7D-JAX15kCjsD8RJtbrjDRi9Jmkai3Hyr9RA@mail.gmail.com>
References: <1457930493-19021-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457930493-19021-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 March 2016 at 05:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When initializing sdio card, we get struct mmc_card
> from mmc_alloc_card which allocates it by kzalloc. So we
> don't need another memset while reading cccr.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/sdio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 467b3cf..bd44ba8 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -106,8 +106,6 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
>         unsigned char data;
>         unsigned char speed;
>
> -       memset(&card->cccr, 0, sizeof(struct sdio_cccr));
> -
>         ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_CCCR, 0, &data);
>         if (ret)
>                 goto out;
> --
> 2.3.7
>
>

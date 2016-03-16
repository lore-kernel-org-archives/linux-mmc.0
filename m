From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: remove redundant memset of mmc_decode_cid
Date: Wed, 16 Mar 2016 12:38:10 +0100
Message-ID: <CAPDyKFp7=G7nCjGtzD-mJ4ZjZUBw8ekc_AK4gAEr-JrdEVevsw@mail.gmail.com>
References: <1457714145-6958-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457714145-6958-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 March 2016 at 17:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When initializing sd or sdio card, we get struct mmc_card
> from mmc_alloc_card which allocates it by kzalloc. So we don't
> need another memset while decoding cid.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/sd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index bb39a29..b95bd24 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -74,8 +74,6 @@ void mmc_decode_cid(struct mmc_card *card)
>  {
>         u32 *resp = card->raw_cid;
>
> -       memset(&card->cid, 0, sizeof(struct mmc_cid));
> -
>         /*
>          * SD doesn't currently have a version field so we will
>          * have to assume we can parse this.
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

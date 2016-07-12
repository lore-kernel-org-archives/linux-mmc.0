From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: fix free of uninitialized 'idata->buf'
Date: Tue, 12 Jul 2016 12:07:35 +0200
Message-ID: <CAPDyKFpEPW-7FrpRceJACkg9uY3FcutPtCNnpxA8uQSE4arnuQ@mail.gmail.com>
References: <1467991622-11036-1-git-send-email-ville@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467991622-11036-1-git-send-email-ville@tuxera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ville Viinikka <ville@tuxera.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ stable

On 8 July 2016 at 17:27, Ville Viinikka <ville@tuxera.com> wrote:
> Set 'idata->buf' to NULL so that it never gets returned without
> initialization. This fixes a bug where mmc_blk_ioctl_cmd() would
> free both 'idata' and 'idata->buf' but 'idata->buf' was returned
> uninitialized.
>
> Fixes: 1ff8950c0433 ("mmc: block: change to use kmalloc when copy data from userspace")
> Signed-off-by: Ville Viinikka <ville@tuxera.com>

I added a stable tag to this and applied it for next!

Thanks and kind regards!
Uffe

> ---
>  drivers/mmc/card/block.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 747c4b0..334d637 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -355,8 +355,10 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>                 goto idata_err;
>         }
>
> -       if (!idata->buf_bytes)
> +       if (!idata->buf_bytes) {
> +               idata->buf = NULL;
>                 return idata;
> +       }
>
>         idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
>         if (!idata->buf) {
> --
> 2.1.4
>

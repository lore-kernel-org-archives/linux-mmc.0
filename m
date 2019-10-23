From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: remove unused variable
Date: Wed, 23 Oct 2019 14:39:57 +0200
Message-ID: <CAPDyKFq7_Obp2Qc2iZDC4wCokMt9-ttuZ0A8A1CYR+b4=JbqOw@mail.gmail.com>
References: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 22 Oct 2019 at 15:00, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> The use of 'status' was removed but the variable itself was not
> removed and thus adding a build warning.
>
> Fixes: 05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

This has already been taken care of, by amending the original patch.
Thanks anyway!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ee1fd7df4ec8..95b41c0891d0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -497,7 +497,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         struct scatterlist sg;
>         int err;
>         unsigned int target_part;
> -       u32 status = 0;
>
>         if (!card || !md || !idata)
>                 return -EINVAL;
> --
> 2.11.0
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ms_block: fix spelling mistake "randomally" -> "randomly"
Date: Wed, 11 Sep 2019 16:21:16 +0200
Message-ID: <CAPDyKFrLOEQkv4SrBfYQo=EPRgcFs7XH3ez22ZyDerMqGDiZFw@mail.gmail.com>
References: <20190911103357.1744-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190911103357.1744-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 11 Sep 2019 at 12:33, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dbg_verbose message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 384927ebde74..d9ee8e3dc72d 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1087,7 +1087,7 @@ static u16 msb_get_free_block(struct msb_data *msb, int zone)
>
>         pos %= msb->free_block_count[zone];
>
> -       dbg_verbose("have %d choices for a free block, selected randomally: %d",
> +       dbg_verbose("have %d choices for a free block, selected randomly: %d",
>                 msb->free_block_count[zone], pos);
>
>         pba = find_next_zero_bit(msb->used_blocks_bitmap,
> --
> 2.20.1
>

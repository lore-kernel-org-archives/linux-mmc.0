From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Thu, 7 Sep 2017 14:06:52 +0200
Message-ID: <CAPDyKFp3QdVm3oxkMvozuf+hifJi64Fn8T27Gy7Mq8SVpAYTSQ@mail.gmail.com>
References: <20170905194739.GA31241@amd> <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com> <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Thu, 7 Sep 2017 10:40:35 +0300
> Subject: [PATCH] mmc: block: Fix incorrectly initialized requests
>
> mmc_init_request() depends on card->bouncesz so it must be calculated
> before blk_init_allocated_queue() starts allocating requests.
>
> Reported-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> Fixes: 304419d8a7e92 ("mmc: core: Allocate per-request data using the block layer core")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index affa7370ba82..74c663b1c0a7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -242,6 +242,12 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>         if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>                 limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
>
> +       /*
> +        * mmc_init_request() depends on card->bouncesz so it must be calculated
> +        * before blk_init_allocated_queue() starts allocating requests.
> +        */
> +       card->bouncesz = mmc_queue_calc_bouncesz(host);
> +
>         mq->card = card;
>         mq->queue = blk_alloc_queue(GFP_KERNEL);
>         if (!mq->queue)
> @@ -265,7 +271,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       card->bouncesz = mmc_queue_calc_bouncesz(host);
>         if (card->bouncesz) {
>                 blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
>                 blk_queue_max_segments(mq->queue, card->bouncesz / 512);
> --
> 1.9.1
>

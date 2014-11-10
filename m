From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: core: reset sdio card properly on resume.
Date: Mon, 10 Nov 2014 14:29:19 +0100
Message-ID: <CAPDyKFrrOozTO5xR8RO=4L8xZ9hLGizH=2mxZE=5zvwMhhgD+w@mail.gmail.com>
References: <20141108000919.5629.55381.stgit@notabene.brown>
	<20141108001411.5629.55298.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141108001411.5629.55298.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-mmc@vger.kernel.org

On 8 November 2014 01:14, NeilBrown <neilb@suse.de> wrote:
> mmc_sdio_power_restore calls
>         mmc_send_if_cond(host, host->ocr_avail);
>
>         ret = mmc_send_io_op_cond(host, 0, NULL);
>
> between mmc_go_idle() and  mmc_sdio_init_card().
> mmc_sdio_resume needs to as well, else my libertas sdio wifi
> device doesn't resume properly from suspend.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/mmc/core/sdio.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index e636d9e99e4a..3f069a6f448f 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -981,8 +981,12 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
>                 sdio_reset(host);
>                 mmc_go_idle(host);
> -               err = mmc_sdio_init_card(host, host->card->ocr, host->card,
> -                                       mmc_card_keep_power(host));
> +               mmc_send_if_cond(host, host->ocr_avail);

/s /host->ocr_avail /host->card->ocr

I would expect that to work. I do realize that "host->ocr_avail" is
being used in the ->power_restore() callback, but I think that's wrong
as well. Could you maybe verify that changing to host->card->ocr works
in this path as well? That's would of course be a separate patch.

> +               err = mmc_send_io_op_cond(host, 0, NULL);
> +               if (!err)
> +                       err = mmc_sdio_init_card(host, host->card->ocr,
> +                                                host->card,
> +                                                mmc_card_keep_power(host));
>         } else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
>                 /* We may have switched to 1-bit mode during suspend */
>                 err = sdio_enable_4bit_bus(host->card);
>
>

Kind regards
Uffe

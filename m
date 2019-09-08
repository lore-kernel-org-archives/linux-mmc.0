From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: bcm2835: Terminate timeout work synchronously"
Date: Sun, 8 Sep 2019 12:32:21 +0200
Message-ID: <CAPDyKFpdZnQaH9NfTsmFk2pjREL_pv6netQjwubMzrkXAOg6hA@mail.gmail.com>
References: <1567928752-2557-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1567928752-2557-1-git-send-email-wahrenst@gmx.net>
Sender: stable-owner@vger.kernel.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Lukas Wunner <lukas@wunner.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 8 Sep 2019 at 09:46, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The commit 37fefadee8bb ("mmc: bcm2835: Terminate timeout work
> synchronously") causes lockups in case of hardware timeouts due the
> timeout work also calling cancel_delayed_work_sync() on its own.
> So revert it.
>
> Fixes: 37fefadee8bb ("mmc: bcm2835: Terminate timeout work synchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7e0d3a4..bb31e13 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -597,7 +597,7 @@ static void bcm2835_finish_request(struct bcm2835_host *host)
>         struct dma_chan *terminate_chan = NULL;
>         struct mmc_request *mrq;
>
> -       cancel_delayed_work_sync(&host->timeout_work);
> +       cancel_delayed_work(&host->timeout_work);
>
>         mrq = host->mrq;
>
> --
> 2.7.4
>

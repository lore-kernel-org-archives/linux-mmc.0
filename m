From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: spi: Fix card detection during probe
Date: Tue, 26 Feb 2019 09:18:06 +0100
Message-ID: <CAPDyKFpinj0-DbfzJ3ioUkjdUAg7cJQuZD-xjbfQXB+VV2fTpw@mail.gmail.com>
References: <20190210173109.12602-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190210173109.12602-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 10 Feb 2019 at 18:31, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> When using the mmc_spi driver with a card-detect pin, I noticed that the
> card was not detected immediately after probe, but only after it was
> unplugged and plugged back in (and the CD IRQ fired).
>
> The call tree looks something like this:
>
> mmc_spi_probe
>   mmc_add_host
>     mmc_start_host
>       _mmc_detect_change
>         mmc_schedule_delayed_work(&host->detect, 0)
>           mmc_rescan
>             host->bus_ops->detect(host)
>               mmc_detect
>                 _mmc_detect_card_removed
>                   host->ops->get_cd(host)
>                     mmc_gpio_get_cd -> -ENOSYS (ctx->cd_gpio not set)
>   mmc_gpiod_request_cd
>     ctx->cd_gpio =3D desc
>
> To fix this issue, call mmc_detect_change after the card-detect GPIO/IRQ
> is registered.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

This works well as fix and for stable! However, we should probably
clean up the code in ->probe() to avoid this thing altogether. Anyway,
I send a patch for that - on top.

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 10ba46b728e8..8ade14fb2148 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1450,6 +1450,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>                 mmc->caps &=3D ~MMC_CAP_NEEDS_POLL;
>                 mmc_gpiod_request_cd_irq(mmc);
>         }
> +       mmc_detect_change(mmc, 0);
>
>         /* Index 1 is write protect/read only */
>         status =3D mmc_gpiod_request_ro(mmc, NULL, 1, false, 0, NULL);
> --
> 2.20.1
>

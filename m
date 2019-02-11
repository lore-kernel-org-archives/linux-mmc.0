From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: spi: Fix card detection during probe
Date: Mon, 11 Feb 2019 09:27:47 +0100
Message-ID: <CACRpkdZZvvd+yTuvfrBuCzXj==Eni4oiC0zj2LP1Mh4wUgdn5Q@mail.gmail.com>
References: <20190210173109.12602-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190210173109.12602-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 10, 2019 at 6:31 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

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

Seems correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

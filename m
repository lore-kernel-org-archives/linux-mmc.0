From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 09/22] mmc: tmio: use mmc_can_gpio_cd() instead of
 checking TMIO_MMC_USE_GPIO_CD
Date: Fri, 12 Jan 2018 15:29:33 +0100
Message-ID: <CAPDyKFqbE7H9bB-iT8d4ZrnVbY3SF+zPWKb=Cp_LwdRwUL-YBg@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com> <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 24 November 2017 at 17:24, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is set
> by a legacy board (arch/sh/boards/mach-ecovec24).
>
> For DT platforms, the "cd-gpios" property is a legitimate way for that
> in case the IP-builtin card detection can not be used for some reason.
> mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
> the "cd-gpios" property is specified.
>
> To cater to both cases, mmc_can_gpio_cd() is a correct way to check
> which card detection logic is used.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

For the rest of the series, please re-post those changes.

Kind regards
Uffe

> ---
>
> Changes in v2: None
>
>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index efffb04..610f26f 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1232,7 +1232,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>         }
>         mmc->max_seg_size = mmc->max_req_size;
>
> -       _host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
> +       _host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
>                                   mmc->caps & MMC_CAP_NEEDS_POLL ||
>                                   !mmc_card_is_removable(mmc));
>
> --
> 2.7.4
>

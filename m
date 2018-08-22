From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: jz4740: Drop dependency on MACH_JZ4740/80
Date: Wed, 22 Aug 2018 11:48:43 +0200
Message-ID: <CAPDyKFqF0kQO1xgSV1s0QjG=JUwhvXwy8h8gOD=A4_RPf5GhGg@mail.gmail.com>
References: <20180821130320.1682-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821130320.1682-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: od@zcrc.me, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 August 2018 at 15:03, Paul Cercueil <paul@crapouillou.net> wrote:
> Depending on MACH_JZ4740 | MACH_JZ4780 prevent us from creating a generic
> kernel that works on more than one MIPS board. Instead, we just depend on
> MIPS being set.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c199c996..71d9bdc52422 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -761,7 +761,7 @@ config MMC_SH_MMCIF
>
>  config MMC_JZ4740
>         tristate "Ingenic JZ47xx SD/Multimedia Card Interface support"
> -       depends on MACH_JZ4740 || MACH_JZ4780
> +       depends on MIPS
>         help
>           This selects support for the SD/MMC controller on Ingenic
>           JZ4740, JZ4750, JZ4770 and JZ4780 SoCs.
> --
> 2.11.0
>

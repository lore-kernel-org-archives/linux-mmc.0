From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: davinci: remove extraneous __init annotation
Date: Mon, 18 Mar 2019 11:51:29 +0100
Message-ID: <CAPDyKFpod7t4T46Ag6SzLgzRPr3T_XDhrDfRGTuJ0Ru5_0MQ2Q@mail.gmail.com>
References: <20190307101024.594587-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307101024.594587-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 7 Mar 2019 at 11:10, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building with clang finds a mistaken __init tag:
>
> WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
> The function davinci_mmcsd_probe() references
> the function __init init_mmcsd_host().
> This is often because davinci_mmcsd_probe lacks a __init
> annotation or the annotation of init_mmcsd_host is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 49e0daf2ef5e..f37003df1e01 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1117,7 +1117,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
>  {
>  }
>  #endif
> -static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> +static void init_mmcsd_host(struct mmc_davinci_host *host)
>  {
>
>         mmc_davinci_reset_ctrl(host, 1);
> --
> 2.20.0
>

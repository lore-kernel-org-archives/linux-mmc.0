From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] mmc: davinci: remove extraneous __init annotation
Date: Thu, 7 Mar 2019 08:21:18 -0700
Message-ID: <20190307152118.GE20201@archlinux-ryzen>
References: <20190307101024.594587-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307101024.594587-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 07, 2019 at 11:10:11AM +0100, Arnd Bergmann wrote:
> Building with clang finds a mistaken __init tag:
> 
> WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
> The function davinci_mmcsd_probe() references
> the function __init init_mmcsd_host().
> This is often because davinci_mmcsd_probe lacks a __init
> annotation or the annotation of init_mmcsd_host is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

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
>  	mmc_davinci_reset_ctrl(host, 1);
> -- 
> 2.20.0
> 

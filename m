From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
Date: Tue, 12 Jun 2018 20:07:52 +0300
Message-ID: <CAHp75VdtdkqJW2svYPuBW4nZz2dRnZ4w5c_BBv=iTgZV2Lkj1A@mail.gmail.com>
References: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

+Cc: Geert

On Wed, Jun 6, 2018 at 9:43 PM, Corentin Labbe <clabbe@baylibre.com> wrote:
> This patch fix the following build failure on m68k:
> ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c199c996..77d6ba090436 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -666,7 +666,7 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +       depends on COMMON_CLK && (ARC || ARM || ARM64 || MIPS || COMPILE_TEST)
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 2.16.4
>



-- 
With Best Regards,
Andy Shevchenko

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: tmio: hide unused tmio_mmc_clk_disable/tmio_mmc_clk_enable
 functions
Date: Mon, 22 Jan 2018 01:29:36 +0900
Message-ID: <CAK7LNATW3g8sAPOmap=4V=-rJdTb8WEuwCUikO6KwP69BYveJg@mail.gmail.com>
References: <20180119145502.1114288-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119145502.1114288-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2018-01-19 23:54 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> When CONFIG_PM is disabled, we get a warning about the clock handling
> being unused:
>
> drivers/mmc/host/tmio_mmc_core.c:937:13: error: 'tmio_mmc_clk_disable' defined but not used [-Werror=unused-function]
>  static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
>              ^~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/tmio_mmc_core.c:929:12: error: 'tmio_mmc_clk_enable' defined but not used [-Werror=unused-function]
>  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
>             ^~~~~~~~~~~~~~~~~~~
>
> As the clock handling is now done elsewhere, this is only used when
> power management is enabled. We could make the functions as __maybe_unused,
> but since there is already an #ifdef section, it seems easier to move
> the helpers closer to their callers.
>
> Fixes: b21fc294387e ("mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Good catch, thanks!

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada

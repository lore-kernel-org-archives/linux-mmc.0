From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 03/14] mmc: meson-gx: clean up some constants
Date: Mon, 07 Aug 2017 14:06:20 -0700
Message-ID: <7ha83bozoz.fsf@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
        <20170804174353.16486-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37982 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdHGVG2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 17:06:28 -0400
Received: by mail-pg0-f43.google.com with SMTP id l64so6078800pge.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 14:06:27 -0700 (PDT)
In-Reply-To: <20170804174353.16486-4-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 4 Aug 2017 19:43:42 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Remove useless clock rate defines. These should not be defined but

To be more precise, they're also unused, so maybe s/useless/unused/ ?

> equested from the clock framework.

s/equested/requested/

> Also correct typo on the DELAY register
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Otherwise,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index d480a8052a06..8a74a048db88 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -45,9 +45,7 @@
>  #define   CLK_DIV_MAX 63
>  #define   CLK_SRC_MASK GENMASK(7, 6)
>  #define   CLK_SRC_XTAL 0   /* external crystal */
> -#define   CLK_SRC_XTAL_RATE 24000000
>  #define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
> -#define   CLK_SRC_PLL_RATE 1000000000
>  #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
>  #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
>  #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
> @@ -57,7 +55,7 @@
>  #define   CLK_PHASE_270 3
>  #define   CLK_ALWAYS_ON BIT(24)
>  
> -#define SD_EMMC_DElAY 0x4
> +#define SD_EMMC_DELAY 0x4
>  #define SD_EMMC_ADJUST 0x8
>  #define SD_EMMC_CALOUT 0x10
>  #define SD_EMMC_START 0x40

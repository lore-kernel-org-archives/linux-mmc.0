From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 06/12] mmc: meson-mx-sdio: Fix misuse of GENMASK macro
Date: Mon, 22 Jul 2019 09:23:16 +0200
Message-ID: <abf1a3b1-d221-6ad5-bdd1-98d7d1eefe83@baylibre.com>
References: <cover.1562734889.git.joe@perches.com>
 <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 10/07/2019 07:04, Joe Perches wrote:
> Arguments are supposed to be ordered high then low.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2d736e416775..ba9a63db73da 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -73,7 +73,7 @@
>  	#define MESON_MX_SDIO_IRQC_IF_CONFIG_MASK		GENMASK(7, 6)
>  	#define MESON_MX_SDIO_IRQC_FORCE_DATA_CLK		BIT(8)
>  	#define MESON_MX_SDIO_IRQC_FORCE_DATA_CMD		BIT(9)
> -	#define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK		GENMASK(10, 13)
> +	#define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK		GENMASK(13, 10)
>  	#define MESON_MX_SDIO_IRQC_SOFT_RESET			BIT(15)
>  	#define MESON_MX_SDIO_IRQC_FORCE_HALT			BIT(30)
>  	#define MESON_MX_SDIO_IRQC_HALT_HOLE			BIT(31)
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

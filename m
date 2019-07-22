From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 06/12] mmc: meson-mx-sdio: Fix misuse of GENMASK macro
Date: Mon, 22 Jul 2019 15:43:05 +0200
Message-ID: <CAPDyKFpmc3qkU4mXk7X0nGkOLnZ060e-n-en5T-Z7FXzcO5ymw@mail.gmail.com>
References: <cover.1562734889.git.joe@perches.com> <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 10 Jul 2019 at 07:04, Joe Perches <joe@perches.com> wrote:
>
> Arguments are supposed to be ordered high then low.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Applied for fixes by adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2d736e416775..ba9a63db73da 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -73,7 +73,7 @@
>         #define MESON_MX_SDIO_IRQC_IF_CONFIG_MASK               GENMASK(7, 6)
>         #define MESON_MX_SDIO_IRQC_FORCE_DATA_CLK               BIT(8)
>         #define MESON_MX_SDIO_IRQC_FORCE_DATA_CMD               BIT(9)
> -       #define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK          GENMASK(10, 13)
> +       #define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK          GENMASK(13, 10)
>         #define MESON_MX_SDIO_IRQC_SOFT_RESET                   BIT(15)
>         #define MESON_MX_SDIO_IRQC_FORCE_HALT                   BIT(30)
>         #define MESON_MX_SDIO_IRQC_HALT_HOLE                    BIT(31)
> --
> 2.15.0
>

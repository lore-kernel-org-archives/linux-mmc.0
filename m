From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 02/12] net: wireless: ti: wl1251 add device tree support
Date: Thu, 14 Nov 2019 15:12:48 +0100
Message-ID: <CAPDyKFomoH5U0XevwKcaHRjf1hEyyqZfv4K_DZhCB7kpuXda2g@mail.gmail.com>
References: <cover.1573122644.git.hns@goldelico.com> <c128cf34cf3858538eac8abffa02a2af8ce845b2.1573122644.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c128cf34cf3858538eac8abffa02a2af8ce845b2.1573122644.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 7 Nov 2019 at 11:31, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> We will have the wl1251 defined as a child node of the mmc interface
> and can read setup for gpios, interrupts and the ti,use-eeprom
> property from there instead of pdata to be provided by pdata-quirks.
>
> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> ---
>  drivers/net/wireless/ti/wl1251/sdio.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
> index 677f1146ccf0..c54a273713ed 100644
> --- a/drivers/net/wireless/ti/wl1251/sdio.c
> +++ b/drivers/net/wireless/ti/wl1251/sdio.c
> @@ -16,6 +16,9 @@
>  #include <linux/irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/gpio.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>
>
>  #include "wl1251.h"
>
> @@ -217,6 +220,7 @@ static int wl1251_sdio_probe(struct sdio_func *func,
>         struct ieee80211_hw *hw;
>         struct wl1251_sdio *wl_sdio;
>         const struct wl1251_platform_data *wl1251_board_data;
> +       struct device_node *np = func->dev.of_node;
>
>         hw = wl1251_alloc_hw();
>         if (IS_ERR(hw))
> @@ -248,6 +252,15 @@ static int wl1251_sdio_probe(struct sdio_func *func,
>                 wl->power_gpio = wl1251_board_data->power_gpio;
>                 wl->irq = wl1251_board_data->irq;
>                 wl->use_eeprom = wl1251_board_data->use_eeprom;
> +       } else if (np) {
> +               wl->use_eeprom =of_property_read_bool(np, "ti,wl1251-has-eeprom");
> +               wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);

This isn't needed as it seems. Perhaps remove or keep it as optional?

> +               wl->irq = of_irq_get(np, 0);
> +
> +               if (wl->power_gpio == -EPROBE_DEFER || wl->irq == -EPROBE_DEFER) {
> +                       ret = -EPROBE_DEFER;
> +                       goto disable;
> +               }
>         }
>
>         if (gpio_is_valid(wl->power_gpio)) {
> --

Kind regards
Uffe

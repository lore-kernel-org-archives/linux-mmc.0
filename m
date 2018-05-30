From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: meson-gx: add device reset
Date: Wed, 30 May 2018 09:27:42 +0200
Message-ID: <CAPDyKFo1ui3XyjXJt0JKrQZd52zEQfsY65LbK_exFqJ6jVDmCQ@mail.gmail.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com> <20180515095748.6794-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515095748.6794-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Jerome,

On 15 May 2018 at 11:57, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Trigger the reset line of the mmc controller while probing, if available.
> The reset should be optional for now, at least until all related DT nodes
> have the reset property.
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I got a regression boot report from kernelci. The bisect doesn't point
to a certain commit, but I found $subject patch a possible cause. Is
it something you can have a look at and see if it's a valid problem?
https://kernelci.org/boot/id/5b0d68a859b514726179a899/

Kind regards
Uffe

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 4f972b879fe6..9bca359f7936 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -35,6 +35,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/interrupt.h>
>  #include <linux/bitfield.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -1184,6 +1185,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto free_host;
>         }
>
> +       ret = device_reset_optional(&pdev->dev);
> +       if (ret) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "device reset failed: %d\n", ret);
> +
> +               return ret;
> +       }
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         host->regs = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(host->regs)) {
> --
> 2.14.3
>

From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: host: sdhci-s3c: Add support for pinctrl
Date: Wed, 21 Nov 2012 16:28:38 +0530
Message-ID: <CAJuYYwSt9pGuFz7iqWJvrmx0cVW+wgqhtJdnx0hnxdATPRGpbA@mail.gmail.com>
References: <1353076097-22498-1-git-send-email-t.figa@samsung.com>
	<1353076097-22498-3-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43382 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab2KUK6j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 05:58:39 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4944545iay.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Nov 2012 02:58:38 -0800 (PST)
In-Reply-To: <1353076097-22498-3-git-send-email-t.figa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, cjb@laptop.org, ben-linux@fluff.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, tomasz.figa@gmail.com

On 16 November 2012 19:58, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch adds support for pin configuration using pinctrl subsystem
> to the sdhci-s3c driver.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  .../devicetree/bindings/mmc/samsung-sdhci.txt        | 20 +++++++++++++-------
>  drivers/mmc/host/sdhci-s3c.c                         | 12 ++++++++++--
>  2 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> index 630a7d7..97e9e31 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> @@ -12,10 +12,6 @@ is used. The Samsung's SDHCI controller bindings extends this as listed below.
>  [A] The property "samsung,cd-pinmux-gpio" can be used as stated in the
>      "Optional Board Specific Properties" section below.
>
> -[B] If core card-detect bindings and "samsung,cd-pinmux-gpio" property
> -    is not specified, it is assumed that there is no card detection
> -    mechanism used.
> -
>  Required SoC Specific Properties:
>  - compatible: should be one of the following
>    - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
> @@ -24,14 +20,18 @@ Required SoC Specific Properties:
>      controller.
>
>  Required Board Specific Properties:
> -- gpios: Should specify the gpios used for clock, command and data lines. The
> -  gpio specifier format depends on the gpio controller.
> +- Samsung GPIO variant (will be completely replaced by pinctrl):
> +  - gpios: Should specify the gpios used for clock, command and data lines. The
> +    gpio specifier format depends on the gpio controller.
> +- Pinctrl variant (preferred if available):
> +  - pinctrl-0: Should specify pin control groups used for this controller.
> +  - pinctrl-names: Should contain only one value - "default".
>
>  Optional Board Specific Properties:
>  - samsung,cd-pinmux-gpio: Specifies the card detect line that is routed
>    through a pinmux to the card-detect pin of the card slot. This property
>    should be used only if none of the mmc core card-detect properties are
> -  used.
> +  used. Only for Samsung GPIO variant.
>
>  Example:
>         sdhci@12530000 {
> @@ -40,12 +40,18 @@ Example:
>                 interrupts = <0 75 0>;
>                 bus-width = <4>;
>                 cd-gpios = <&gpk2 2 2 3 3>;
> +
> +               /* Samsung GPIO variant */
>                 gpios = <&gpk2 0 2 0 3>,  /* clock line */
>                         <&gpk2 1 2 0 3>,  /* command line */
>                         <&gpk2 3 2 3 3>,  /* data line 0 */
>                         <&gpk2 4 2 3 3>,  /* data line 1 */
>                         <&gpk2 5 2 3 3>,  /* data line 2 */
>                         <&gpk2 6 2 3 3>;  /* data line 3 */
> +
> +               /* Pinctrl variant */
> +               pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
> +               pinctrl-names = "default";
>         };

nit: there could have been one example each for gpio and pinctrl
variant instead of putting both into one example node.

>
>         Note: This example shows both SoC specific and board specific properties
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 75f85fd..6161162 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include <linux/mmc/host.h>
>
> @@ -57,6 +58,7 @@ struct sdhci_s3c {
>         int                     ext_cd_irq;
>         int                     ext_cd_gpio;
>         int                     *gpios;
> +       struct pinctrl          *pctrl;
>
>         struct clk              *clk_io;
>         struct clk              *clk_bus[MAX_BUS_CLK];
> @@ -477,8 +479,9 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
>                 return -EINVAL;
>         }
>
> -       dev_info(dev, "assuming no card detect line available\n");
> -       pdata->cd_type = S3C_SDHCI_CD_NONE;
> +       /* assuming internal card detect that will be configured by pinctrl */
> +       pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
> +       goto setup_bus;
>
>   found_cd:
>         if (pdata->cd_type == S3C_SDHCI_CD_GPIO) {
> @@ -496,6 +499,9 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
>         }
>
>   setup_bus:
> +       if (!IS_ERR(ourhost->pctrl))
> +               return 0;
> +
>         /* get the gpios for command, clock and data lines */
>         for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
>                 gpio = of_get_gpio(node, cnt);
> @@ -574,6 +580,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>                 goto err_pdata_io_clk;
>         }
>
> +       sc->pctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +
>         if (pdev->dev.of_node) {
>                 ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
>                 if (ret)
> --
> 1.8.0

Acked-by: Thomas Abraham <thomas.abraham@linaro.org>

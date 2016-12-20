From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-cadence: add Socionext UniPhier specific
 compatible string
Date: Tue, 20 Dec 2016 11:50:01 +0100
Message-ID: <CAPDyKFom4s4kx+vgE3+9zvSG3Pso4Pcd+Zrc6fRdivyLzwHhsA@mail.gmail.com>
References: <1481681446-29832-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37721 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbcLTKuD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 05:50:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id t79so126315704wmt.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2016 02:50:03 -0800 (PST)
In-Reply-To: <1481681446-29832-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On 14 December 2016 at 03:10, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Add a Socionext SoC specific compatible (suggested by Rob Herring).
>
> No SoC specific data are associated with the compatible strings for
> now, but other SoC vendors may use this IP and want to differentiate
> IP variants in the future.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
> Changes in v2:
>   - Add "uniphier" to the compatible to make it more SoC-specific
>
>  Documentation/devicetree/bindings/mmc/sdhci-cadence.txt | 6 ++++--
>  drivers/mmc/host/sdhci-cadence.c                        | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> index 750374f..c0f37cb 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> @@ -1,7 +1,9 @@
>  * Cadence SD/SDIO/eMMC Host Controller
>
>  Required properties:
> -- compatible: should be "cdns,sd4hc".
> +- compatible: should be one of the following:
> +    "cdns,sd4hc"               - default of the IP
> +    "socionext,uniphier-sd4hc" - for Socionext UniPhier SoCs
>  - reg: offset and length of the register set for the device.
>  - interrupts: a single interrupt specifier.
>  - clocks: phandle to the input clock.
> @@ -19,7 +21,7 @@ if supported.  See mmc.txt for details.
>
>  Example:
>         emmc: sdhci@5a000000 {
> -               compatible = "cdns,sd4hc";
> +               compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
>                 reg = <0x5a000000 0x400>;
>                 interrupts = <0 78 4>;
>                 clocks = <&clk 4>;
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 1501cfd..4b0ecb9 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -262,6 +262,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sdhci_cdns_match[] = {
> +       { .compatible = "socionext,uniphier-sd4hc" },
>         { .compatible = "cdns,sd4hc" },
>         { /* sentinel */ }
>  };
> --
> 2.7.4
>

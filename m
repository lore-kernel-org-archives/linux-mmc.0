From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH RESEND V3 2/2] mmc: sdhci-brcmstb: Add driver for Broadcom
 BRCMSTB SoCs
Date: Fri, 4 Mar 2016 16:48:43 -0800
Message-ID: <CAJiQ=7D2A=6-e-2K8xePR5SeQENsUUVVLyPDSvVK=x_m5nfrAw@mail.gmail.com>
References: <1457114844-18841-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34027 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759049AbcCEAtE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 19:49:04 -0500
Received: by mail-ig0-f193.google.com with SMTP id sv7so804756igc.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2016 16:49:03 -0800 (PST)
In-Reply-To: <1457114844-18841-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On Fri, Mar 4, 2016 at 10:07 AM, Al Cooper <alcooperx@gmail.com> wrote:
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-brcmstb.txt      |  40 ++++++
>  MAINTAINERS                                        |   7 +
>  drivers/mmc/host/Kconfig                           |  11 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c                   | 154 +++++++++++++++++++++
>  5 files changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
>  create mode 100644 drivers/mmc/host/sdhci-brcmstb.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt b/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
> new file mode 100644
> index 0000000..f8dd6a9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
> @@ -0,0 +1,40 @@
> +* BROADCOM BRCMSTB/BMIPS SDHCI Controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci-brcmstb driver.
> +
> +Required properties:
> +- compatible: "brcm,sdhci-brcmstb"

For many of the other SoC drivers, such as drivers/irqchip/irq-bcm*,
we've used the compatible string and/or driver name to denote the
oldest SoC that is compatible with the driver.  This helps to indicate
that the driver is not compatible with previous versions of the core.
For instance, the driver you are submitting would be slightly broken
on the BCM7468/BCM7208 STB chips, and horrifically broken on BCM7630
(which admittedly isn't quite "brcmstb" but uses some of the same
drivers).  I assume you don't want to target those ancient parts.

When the hardware block changes frequently, we've gone as far as
creating a different compatible string for each variant.  For
Documentation/devicetree/bindings/net/brcm,bcmgenet.txt we encoded the
hardware generation number in the compatible string.

[snip]

> +static int sdhci_brcmstb_probe(struct platform_device *pdev)
> +{
> +       struct device_node *dn = pdev->dev.of_node;
> +       struct sdhci_host *host;
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct clk *clk;
> +       int res;
> +
> +       clk = of_clk_get_by_name(dn, "sw_sdio");
> +       if (IS_ERR(clk)) {
> +               dev_err(&pdev->dev, "Clock not found in Device Tree\n");
> +               clk = NULL;

Last time I worked on these chips, they defaulted to "all clocks
enabled" in the absence of a clk driver.

So, if this is not treated as a fatal condition, maybe it would be
better to downgrade it to dev_warn or dev_info.

> +       }
> +       res = clk_prepare_enable(clk);
> +       if (res)
> +               goto undo_clk_get;

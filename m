From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2, 1/4] mmc: sdhci-pltfm: add little-endian mode support for
 SDHCI platform
Date: Mon, 4 May 2015 12:42:59 +0200
Message-ID: <CAPDyKFpfOOLnGxtoE6DwyRbmD2x7nZkNdsrOw0uS2HSx--nrnQ@mail.gmail.com>
References: <1429005883-21089-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33503 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbbEDKnA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 06:43:00 -0400
Received: by qcvz3 with SMTP id z3so20212989qcv.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2015 03:42:59 -0700 (PDT)
In-Reply-To: <1429005883-21089-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 14 April 2015 at 12:04, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> This patch adds little-endian mode support for little-endian host
> controller. To indicate the little-endian mode, we could add
> 'little-endian' property in device tree node.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 12 ++++++-
>  drivers/mmc/host/sdhci-pltfm.h | 74 ++++++++++++++++++++++++++++++------------
>  2 files changed, 64 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a207f5a..7ef1dcb 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -121,6 +121,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     size_t priv_size)
>  {
>         struct sdhci_host *host;
> +       struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_pltfm_host *pltfm_host;
>         struct resource *iomem;
>         int ret;
>
> @@ -141,6 +143,14 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                 goto err;
>         }
>
> +       pltfm_host = sdhci_priv(host);
> +       pltfm_host->endian_mode = BIG_ENDIAN_MODE;
> +
> +#ifdef CONFIG_OF
> +       if (of_get_property(np, "little-endian", NULL))
> +               pltfm_host->endian_mode = LITTLE_ENDIAN_MODE;

This should be a generic mmc host property. Please have the DT parsing
to be done via mmc_of_parse().

I also I think the default should be LITTLE_ENDIAN_MODE, which is also
what of_device_is_big_endian() API is doing. I suggest you use that
API and assign a bool variable in the struct mmc_host to its return
value, from mmc_of_parse(). That variable may then be used by those
mmc host drivers that needs it.

Don't forget to update the mmc DT documentation.

[...]

Kind regards
Uffe

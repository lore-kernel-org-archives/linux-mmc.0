From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: add/remove some quirks according to
 vendor version
Date: Wed, 25 Nov 2015 17:34:06 +0100
Message-ID: <CAPDyKFrNYketwejMVeSXWFG30U5nFhg28tH3bB8wtR8tx7T2_w@mail.gmail.com>
References: <1448417137-6185-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35976 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbbKYQeH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 11:34:07 -0500
Received: by ykdr82 with SMTP id r82so61324374ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 08:34:06 -0800 (PST)
In-Reply-To: <1448417137-6185-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 25 November 2015 at 03:05, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> A previous patch had removed esdhc_of_platform_init() by mistake.
> static void esdhc_of_platform_init(struct sdhci_host *host)
> {
>         u32 vvn;
>
>         vvn = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
>         vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>         if (vvn == VENDOR_V_22)
>                 host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>
>         if (vvn > VENDOR_V_22)
>                 host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
> }
>
> This patch is used to fix it by add/remove some quirks according to
> verdor version in probe.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> Fixes: f4932cfd22f1 ("mmc: sdhci-of-esdhc: support both BE and LE host controller")

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 90e94a0..83b1226 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -584,6 +584,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
>         struct device_node *np;
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_esdhc *esdhc;
>         int ret;
>
>         np = pdev->dev.of_node;
> @@ -600,6 +602,14 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>
>         sdhci_get_of_property(pdev);
>
> +       pltfm_host = sdhci_priv(host);
> +       esdhc = pltfm_host->priv;
> +       if (esdhc->vendor_ver == VENDOR_V_22)
> +               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +
> +       if (esdhc->vendor_ver > VENDOR_V_22)
> +               host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
> +
>         if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
>             of_device_is_compatible(np, "fsl,p5020-esdhc") ||
>             of_device_is_compatible(np, "fsl,p4080-esdhc") ||
> --
> 2.1.0.27.g96db324
>

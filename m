From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2] mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb
Date: Tue, 5 Dec 2017 17:28:56 +0100
Message-ID: <CAPDyKFr7kn1P7QtJo_QRdVNuN_uyG7RUPc5rjGk7VaWS5vpHUA@mail.gmail.com>
References: <20171201070934.47380-1-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:46580 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbdLEQ26 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Dec 2017 11:28:58 -0500
Received: by mail-it0-f66.google.com with SMTP id t1so2881126ite.5
        for <linux-mmc@vger.kernel.org>; Tue, 05 Dec 2017 08:28:57 -0800 (PST)
In-Reply-To: <20171201070934.47380-1-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "yinbo.zhu" <yinbo.zhu@nxp.com>

On 1 December 2017 at 08:09, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>
> When system wakes up from sleep on ls1046ardb, the SD operation fails
> with mmc error messages since ESDHC_TB_EN bit couldn't be cleaned by
> eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
> rather than in probe.
>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next.

I don't know why you guys did send several version on top, the only
change I could find was the acked-by tag. Right?

Kind regards
Uffe

> ---
> Changes for v2:
>         - Added Acked-by of Yangbo and Adrian.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d74030f3bd12..4ffa6b173a21 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -589,10 +589,18 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
> +       u32 val;
> +
>         sdhci_reset(host, mask);
>
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +       if (mask & SDHCI_RESET_ALL) {
> +               val = sdhci_readl(host, ESDHC_TBCTL);
> +               val &= ~ESDHC_TB_EN;
> +               sdhci_writel(host, val, ESDHC_TBCTL);
> +       }
>  }
>
>  /* The SCFG, Supplemental Configuration Unit, provides SoC specific
> @@ -785,10 +793,6 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>         pltfm_host = sdhci_priv(host);
>         esdhc = sdhci_pltfm_priv(pltfm_host);
>
> -       val = sdhci_readl(host, ESDHC_TBCTL);
> -       val &= ~ESDHC_TB_EN;
> -       sdhci_writel(host, val, ESDHC_TBCTL);
> -
>         host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
>         esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
>                              SDHCI_VENDOR_VER_SHIFT;
> --
> 2.14.1
>

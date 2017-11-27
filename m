From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
Date: Mon, 27 Nov 2017 10:57:36 +0100
Message-ID: <CAPDyKFpDyXrXWjkwx+X+z4orOs0iy7fgF=Jox5qBoGNbLT_jgQ@mail.gmail.com>
References: <20171108090950.4900-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:38901 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdK0J5h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Nov 2017 04:57:37 -0500
Received: by mail-it0-f67.google.com with SMTP id n134so20541199itg.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Nov 2017 01:57:37 -0800 (PST)
In-Reply-To: <20171108090950.4900-1-yinbo.zhu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>

On 8 November 2017 at 10:09,  <yinbo.zhu@nxp.com> wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>
> The bit eSDHC_TBCTL[TB_EN] couldn't be reset by eSDHC_SYSCTL[RSTA] which is
> used to reset for all. The driver should make sure it's cleared before card
> initialization, otherwise the initialization would fail.
>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Change in v2:
>                 Replace ESDHC_TB_DIS with default register bit ESDHC_TB_EN
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d96a057a7db8..023c24bd0d94 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -783,6 +783,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>         pltfm_host = sdhci_priv(host);
>         esdhc = sdhci_pltfm_priv(pltfm_host);
>
> +       val = sdhci_readl(host, ESDHC_TBCTL);
> +       val &= ~ESDHC_TB_EN;
> +       sdhci_writel(host, val, ESDHC_TBCTL);
> +
>         host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
>         esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
>                              SDHCI_VENDOR_VER_SHIFT;
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

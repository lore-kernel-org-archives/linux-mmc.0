From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2] mmc: sdhci-brcmstb: Remove incorrect capability
Date: Mon, 29 Aug 2016 13:13:34 +0200
Message-ID: <CAPDyKFp=rX8J0K=6pQFv3Wm=UfUVCX5cPyJPqHKeYm3075OLSQ@mail.gmail.com>
References: <20160829091707.78436-1-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33628 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757166AbcH2LNh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 07:13:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id d196so15354325wmd.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2016 04:13:36 -0700 (PDT)
In-Reply-To: <20160829091707.78436-1-jaedon.shin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 29 August 2016 at 11:17, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Removes incorrect 64-bit ADMA capability on Broadcom MIPS based SoCs.
> The MIPS based BRCMSTB SDHCI host controllers are using ADMA only, but
> the several chipsets have a incorrect capability about ADMA 64-bit.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index cce10fe3e19e..683bfc2af512 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -98,6 +98,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>          * properties through mmc_of_parse().
>          */
>         host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +       if (IS_ENABLED(CONFIG_MIPS))

I thought we agreed on using a specific DT compatible string to
distinguish what to do here was better? No?

> +               host->caps &= ~SDHCI_CAN_64BIT;
>         host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>                         SDHCI_SUPPORT_DDR50);
> --
> 2.9.3
>

Kind regards
Uffe

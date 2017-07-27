From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: use io functions from sdhci.h
Date: Thu, 27 Jul 2017 16:48:11 +0200
Message-ID: <CAPDyKFqYqjLPUrJDGMueN3SXv1zAQS9Vb26MZjHdUpUqtDav7Q@mail.gmail.com>
References: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36322 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdG0OsN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:13 -0400
Received: by mail-qk0-f169.google.com with SMTP id d136so108087739qkg.3
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:12 -0700 (PDT)
In-Reply-To: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 17 July 2017 at 03:23, Jean-Francois Dagenais
<jeff.dagenais@gmail.com> wrote:
> This increases consistency of the code across the sdhci family.
>
> v2: rebased onto ulfh/mmc/next and tweaked headline accordingly.
>
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

Thanks applied for next, by dropping the version history from the change log.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b13c0a7d50e4..528a5d24c0bc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -216,13 +216,13 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>         u32 vendor;
>         struct sdhci_host *host = mmc_priv(mmc);
>
> -       vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +       vendor = sdhci_readl(host, SDHCI_ARASAN_VENDOR_REGISTER);
>         if (ios->enhanced_strobe)
>                 vendor |= VENDOR_ENHANCED_STROBE;
>         else
>                 vendor &= ~VENDOR_ENHANCED_STROBE;
>
> -       writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +       sdhci_writel(host, vendor, SDHCI_ARASAN_VENDOR_REGISTER);
>  }
>
>  static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> --
> 2.11.0
>

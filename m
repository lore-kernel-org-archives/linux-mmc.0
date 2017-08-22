From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: support ESDHC_CAPABILITIES_1 accessing
Date: Tue, 22 Aug 2017 13:14:42 +0200
Message-ID: <CAPDyKFrjwUu0jTwWXsoxUEojz+wkU3_sjaTuedQ56gnrdiffpA@mail.gmail.com>
References: <1502763423-371-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35741 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVLOo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:14:44 -0400
Received: by mail-qt0-f178.google.com with SMTP id x36so26418993qtx.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:14:43 -0700 (PDT)
In-Reply-To: <1502763423-371-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

On 15 August 2017 at 04:17, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> eSDHC is not a standard SD host controller. SDHCI_CAPABILITIES_1
> register address is 0x44 while it's 0x114 (ESDHC_CAPABILITIES_1)
> for eSDHC.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes for v2:
>         - Removed duplicate perenthesis.
>         - Added "Acked-by: Adrian Hunter".
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  3 +++
>  drivers/mmc/host/sdhci-of-esdhc.c | 23 +++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index e7893f2..dfa58f8 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -54,6 +54,9 @@
>  #define ESDHC_CLOCK_HCKEN              0x00000002
>  #define ESDHC_CLOCK_IPGEN              0x00000001
>
> +/* Host Controller Capabilities Register 2 */
> +#define ESDHC_CAPABILITIES_1           0x114
> +
>  /* Tuning Block Control Register */
>  #define ESDHC_TBCTL                    0x120
>  #define ESDHC_TB_EN                    0x00000004
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 44b016b..d96a057 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -86,6 +86,17 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>                 return ret;
>         }
>
> +       /*
> +        * DTS properties of mmc host are used to enable each speed mode
> +        * according to soc and board capability. So clean up
> +        * SDR50/SDR104/DDR50 support bits here.
> +        */
> +       if (spec_reg == SDHCI_CAPABILITIES_1) {
> +               ret = value & ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
> +                               SDHCI_SUPPORT_DDR50);
> +               return ret;
> +       }
> +
>         ret = value;
>         return ret;
>  }
> @@ -249,7 +260,11 @@ static u32 esdhc_be_readl(struct sdhci_host *host, int reg)
>         u32 ret;
>         u32 value;
>
> -       value = ioread32be(host->ioaddr + reg);
> +       if (reg == SDHCI_CAPABILITIES_1)
> +               value = ioread32be(host->ioaddr + ESDHC_CAPABILITIES_1);
> +       else
> +               value = ioread32be(host->ioaddr + reg);
> +
>         ret = esdhc_readl_fixup(host, reg, value);
>
>         return ret;
> @@ -260,7 +275,11 @@ static u32 esdhc_le_readl(struct sdhci_host *host, int reg)
>         u32 ret;
>         u32 value;
>
> -       value = ioread32(host->ioaddr + reg);
> +       if (reg == SDHCI_CAPABILITIES_1)
> +               value = ioread32(host->ioaddr + ESDHC_CAPABILITIES_1);
> +       else
> +               value = ioread32(host->ioaddr + reg);
> +
>         ret = esdhc_readl_fixup(host, reg, value);
>
>         return ret;
> --
> 2.1.0.27.g96db324
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5 1/4] mmc: sdhci-cadence: Fix writing PHY delay
Date: Thu, 30 Mar 2017 21:30:38 +0200
Message-ID: <CAPDyKFowsgD7GV0hTsK=P4hWQ4rBonY0_G=GFQMhJF16jVOuYA@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36399 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934581AbdC3Tak (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:30:40 -0400
Received: by mail-vk0-f49.google.com with SMTP id s68so67093605vke.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:30:39 -0700 (PDT)
In-Reply-To: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 21 March 2017 at 15:32, Piotr Sroka <piotrs@cadence.com> wrote:
> Add polling for ACK to be sure that data are written to PHY register.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes for v2:
> - fix indent
> ---
> Changes for v3:
> - none
> ---
> Changes for v4:
> - none
> ---
> Changes for v5:
> - use driver version from next branch, with applied enhanced strobe feature support.
> ---
>  drivers/mmc/host/sdhci-cadence.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 48f6419..83c3b55 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -68,11 +68,12 @@ struct sdhci_cdns_priv {
>         bool enhanced_strobe;
>  };
>
> -static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -                                    u8 addr, u8 data)
> +static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> +                                   u8 addr, u8 data)
>  {
>         void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>         u32 tmp;
> +       int ret;
>
>         tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
>               (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
> @@ -81,8 +82,14 @@ static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         tmp |= SDHCI_CDNS_HRS04_WR;
>         writel(tmp, reg);
>
> +       ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
> +       if (ret)
> +               return ret;
> +
>         tmp &= ~SDHCI_CDNS_HRS04_WR;
>         writel(tmp, reg);
> +
> +       return 0;
>  }
>
>  static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> --
> 2.2.2
>

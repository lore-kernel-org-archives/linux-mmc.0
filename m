From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v5 1/4] mmc: sdhci-cadence: Fix writing PHY delay
Date: Wed, 29 Mar 2017 16:03:00 +0300
Message-ID: <5c89e38f-daa2-1c70-084f-2046d1f4f986@intel.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22194 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755818AbdC2NIh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Mar 2017 09:08:37 -0400
In-Reply-To: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>

On 21/03/17 16:32, Piotr Sroka wrote:
> Add polling for ACK to be sure that data are written to PHY register.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
>  	bool enhanced_strobe;
>  };
>  
> -static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -				     u8 addr, u8 data)
> +static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> +				    u8 addr, u8 data)
>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
> +	int ret;
>  
>  	tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
>  	      (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
> @@ -81,8 +82,14 @@ static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  	tmp |= SDHCI_CDNS_HRS04_WR;
>  	writel(tmp, reg);
>  
> +	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
> +	if (ret)
> +		return ret;
> +
>  	tmp &= ~SDHCI_CDNS_HRS04_WR;
>  	writel(tmp, reg);
> +
> +	return 0;
>  }
>  
>  static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> 


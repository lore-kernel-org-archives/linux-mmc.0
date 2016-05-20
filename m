From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 5/5] mmc: sdhci-of-arasan: implement enhanced strobe
 callback
Date: Fri, 20 May 2016 14:44:34 +0300
Message-ID: <573EF8A2.5070305@intel.com>
References: <1463733285-770-1-git-send-email-shawn.lin@rock-chips.com>
 <1463733377-986-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22158 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586AbcETLsi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2016 07:48:38 -0400
In-Reply-To: <1463733377-986-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

On 20/05/16 11:36, Shawn Lin wrote:
> Currently sdhci-arasan 5.1 can support enhanced strobe function,
> and we now limit it just for "arasan,sdhci-5.1". Add
> mmc-hs400-enhanced-strobe in DT to enable the function if we're
> sure our controller can support it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b6f4c1d..533e2bc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -25,7 +25,9 @@
>  #include "sdhci-pltfm.h"
>  
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> +#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
>  
> +#define VENDOR_ENHANCED_STROBE		BIT(0)
>  #define CLK_CTRL_TIMEOUT_SHIFT		16
>  #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
>  #define CLK_CTRL_TIMEOUT_MIN_EXP	13
> @@ -79,6 +81,21 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  }
>  
> +static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					struct mmc_ios *ios)
> +{
> +	u32 vendor;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +	if (ios->enhanced_strobe)
> +		vendor |= VENDOR_ENHANCED_STROBE;
> +	else
> +		vendor &= ~VENDOR_ENHANCED_STROBE;
> +
> +	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +}
> +
>  static struct sdhci_ops sdhci_arasan_ops = {
>  	.set_clock = sdhci_arasan_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -245,6 +262,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "phy_power_on err.\n");
>  			goto err_phy_power;
>  		}
> +
> +		host->mmc_host_ops.hs400_enhanced_strobe =
> +					sdhci_arasan_hs400_enhanced_strobe;
>  	}
>  
>  	ret = sdhci_add_host(host);
> 


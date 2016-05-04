From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-arasan: fix set_clock when a phy is
 supported
Date: Wed, 4 May 2016 12:54:56 +0300
Message-ID: <5729C6F0.6000603@intel.com>
References: <1462326204-5090-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462326204-5090-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 04/05/16 04:43, Shawn Lin wrote:
> commit 61b914eb81f8 ("mmc: sdhci-of-arasan: add phy support for
> sdhci-of-arasan") introduce phy support for arasan. According to
> the vendor's databook, we should make sure the phy is in poweroff
> status before we configure the clk stuff. Otherwise it may cause
> some IO sample timing issues from the test. And we don't need this
> extra operation while running in low performance mode since phy
> doesn't trigger sampling block.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes in v3:
> - avoid use sleep function with the scope of spinlock because
> phy APIs call mutex.
> 
> Changes in v2:
> - Rename commit msg title to indicate it's a fix
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 2e482b1..b6f4c1d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -55,8 +55,32 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>  	return freq;
>  }
>  
> +static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	bool ctrl_phy = false;
> +
> +	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
> +		ctrl_phy = true;
> +
> +	if (ctrl_phy) {
> +		spin_unlock_irq(&host->lock);
> +		phy_power_off(sdhci_arasan->phy);
> +		spin_lock_irq(&host->lock);
> +	}
> +
> +	sdhci_set_clock(host, clock);
> +
> +	if (ctrl_phy) {
> +		spin_unlock_irq(&host->lock);
> +		phy_power_on(sdhci_arasan->phy);
> +		spin_lock_irq(&host->lock);
> +	}
> +}
> +
>  static struct sdhci_ops sdhci_arasan_ops = {
> -	.set_clock = sdhci_set_clock,
> +	.set_clock = sdhci_arasan_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> 

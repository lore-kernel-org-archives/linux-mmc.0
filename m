From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: tegra: properly disable card clock
Date: Thu, 3 Mar 2016 16:06:56 +0200
Message-ID: <56D84500.1030807@intel.com>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36237 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756644AbcCCOKd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Mar 2016 09:10:33 -0500
In-Reply-To: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On 29/02/16 22:56, Lucas Stach wrote:
> The new code to do the clock rate setting externally to the SDMMC
> module has a shortcut to not propagate changes with a 0 rate to
> the CAR by simply bailing out. This breaks proper cutting of the
> card clock. Fix it by directly calling the correct sdhci function.
> 
> Fixes: a8e326a911d3 "mmc: tegra: implement module external clock change"
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 212d51f..46a6bd1 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -194,7 +194,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  	unsigned long host_clk;
>  
>  	if (!clock)
> -		return;
> +		return sdhci_set_clock(host, clock);;
>  
>  	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
>  	clk_set_rate(pltfm_host->clk, host_clk);
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] mmc/sdhci-tegra: use generic sdhci_set_bus_width()
Date: Mon, 14 Aug 2017 15:03:04 +0300
Message-ID: <8b7a7e97-6b0c-e377-4cc0-2381b8cb7fae@intel.com>
References: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
 <3debee26f13754f08d36bc3647a83979708a67fa.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1531 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753219AbdHNMJf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 08:09:35 -0400
In-Reply-To: <3debee26f13754f08d36bc3647a83979708a67fa.1502310654.git.mirq-linux@rere.qmqm.pl>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On 09/08/17 23:36, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

There always needs to be a commit message. i.e.

"Now that sdhci_set_bus_width() supports 8-bit bus widths based on the
MMC_CAP_8_BIT_DATA capability flag, replace the tegra version with the
generic sdhci version."

Also subject should begin "mmc: sdhci-tegra: "...

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7f93079c7a3a..9a589b6a53dd 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -190,25 +190,6 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	tegra_host->ddr_signaling = false;
>  }
>  
> -static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
> -{
> -	u32 ctrl;
> -
> -	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -	if ((host->mmc->caps & MMC_CAP_8_BIT_DATA) &&
> -	    (bus_width == MMC_BUS_WIDTH_8)) {
> -		ctrl &= ~SDHCI_CTRL_4BITBUS;
> -		ctrl |= SDHCI_CTRL_8BITBUS;
> -	} else {
> -		ctrl &= ~SDHCI_CTRL_8BITBUS;
> -		if (bus_width == MMC_BUS_WIDTH_4)
> -			ctrl |= SDHCI_CTRL_4BITBUS;
> -		else
> -			ctrl &= ~SDHCI_CTRL_4BITBUS;
> -	}
> -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> -}
> -
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
>  	u32 val;
> @@ -323,7 +304,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> -	.set_bus_width = tegra_sdhci_set_bus_width,
> +	.set_bus_width = sdhci_set_bus_width,
>  	.reset      = tegra_sdhci_reset,
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> @@ -371,7 +352,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>  	.write_w    = tegra_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> -	.set_bus_width = tegra_sdhci_set_bus_width,
> +	.set_bus_width = sdhci_set_bus_width,
>  	.reset      = tegra_sdhci_reset,
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> 


From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v2 2/4] mmc: sdhci: get the timeout_clk from callback
 in Hz
Date: Tue, 28 Feb 2017 15:15:22 +0200
Message-ID: <7af4e826-8021-d67a-0673-acd3bb0d24a8@intel.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
 <1488184144-122285-3-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdB1N0q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Feb 2017 08:26:46 -0500
In-Reply-To: <1488184144-122285-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 27/02/17 10:29, Shawn Lin wrote:
> We expect all the variant host drivers to return the timeout
> clk rate in Hz unit so that it's more easy for us to work through
> all cases in one place.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6fdd7a7..9707f11 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3101,6 +3101,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	unsigned int override_timeout_clk;
>  	u32 max_clk;
>  	int ret;
> +	bool skip_div;
>  
>  	WARN_ON(host == NULL);
>  	if (host == NULL)
> @@ -3292,7 +3293,9 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		if (host->timeout_clk == 0) {
>  			if (host->ops->get_timeout_clock) {
>  				host->timeout_clk =
> -					host->ops->get_timeout_clock(host);
> +					DIV_ROUND_UP(host->ops->get_timeout_clock(host), 1000);
> +				if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
> +					skip_div = true;
>  			} else {
>  				pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
>  					mmc_hostname(mmc));
> @@ -3301,7 +3304,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  			}
>  		}
>  
> -		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
> +		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT && !skip_div)
>  			host->timeout_clk *= 1000;

Just move this above "if (host->timeout_clk == 0) {" and you don't need
skip_div.

Also you will have to roll all these patches together or you are breaking
bisectability.


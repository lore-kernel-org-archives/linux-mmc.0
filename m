From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-cadence: fix the return value of
 sdhci_cdns_get_timeout_clock
Date: Tue, 28 Feb 2017 15:16:33 +0200
Message-ID: <2252487a-de69-62ea-03df-0d8cc925a579@intel.com>
References: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
 <1488184144-122285-5-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59808 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbdB1Ne2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Feb 2017 08:34:28 -0500
In-Reply-To: <1488184144-122285-5-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 27/02/17 10:29, Shawn Lin wrote:
> Return the timeout clock rate in Hz for sdhci core.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-cadence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 316cfec..bb3951a 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -103,9 +103,10 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  {
>  	/*
>  	 * Cadence's spec says the Timeout Clock Frequency is the same as the
> -	 * Base Clock Frequency.  Divide it by 1000 to return a value in kHz.
> +	 * Base Clock Frequency. Return a value in Hz per the requirement of
> +	 * .get_timeout_clock callback.
>  	 */
> -	return host->max_clk / 1000;
> +	return DIV_ROUND_UP(DIV_ROUND_UP(host->max_clk, 1000), 1000);

Isn't it just host->max_clk now.

>  }
>  
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> 


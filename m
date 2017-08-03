From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-msm: add static to local functions
Date: Thu, 3 Aug 2017 13:31:50 +0300
Message-ID: <9cd06301-68c1-ce6f-c156-52a4f86ba7dd@intel.com>
References: <1501502446-13931-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26090 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbdHCKiM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Aug 2017 06:38:12 -0400
In-Reply-To: <1501502446-13931-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 31/07/17 15:00, Masahiro Yamada wrote:
> Detected by sparse.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-msm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9d601dc0d646..f35db061ee4c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -611,7 +611,7 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
>   * HS400 - divided clock (free running MCLK/2)
>   * All other modes - default (free running MCLK)
>   */
> -void sdhci_msm_hc_select_mode(struct sdhci_host *host)
> +static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
>  {
>  	struct mmc_ios ios = host->mmc->ios;
>  
> @@ -1049,7 +1049,7 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
>   * instead directly control the GCC clock as per
>   * HW recommendation.
>   **/
> -void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
> +static void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	u16 clk;
>  	/*
> 


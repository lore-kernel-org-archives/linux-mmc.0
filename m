From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH -next 1/2] mmc: sdhci-xenon: Fix the work flow in
 xenon_remove().
Date: Fri, 28 Apr 2017 10:45:11 +0300
Message-ID: <cc1a2b96-a9cb-f6d0-298d-1e598213454b@intel.com>
References: <cover.1493275841.git.huziji@marvell.com>
 <e05202317167dc118edd6e2404b3eebc03de57bb.1493275842.git.huziji@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28053 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753066AbdD1Hu6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 28 Apr 2017 03:50:58 -0400
In-Reply-To: <e05202317167dc118edd6e2404b3eebc03de57bb.1493275842.git.huziji@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hu Ziji <huziji@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, dougj@marvell.com, jszhang@marvell.com, nadavh@marvell.com, ygao@marvell.com, xigu@marvell.com, liuw@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, zjwu@marvell.com

On 28/04/17 05:34, Hu Ziji wrote:
> sdhci_remove_host() might execute SOFT_RESET_ALL.
> Inside xenon_remove(), Xenon SDHC should be enabled during
> sdhci_remove_host().
> 
> Move xenon_sdhc_unprepare after sdhci_remove_host() such that Xenon
> SDHC is disabled after sdhci_remove_host() completes.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Reported-by: Jisheng Zhang <jszhang@marvell.com>
> Tested-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 3b82a0b..786c3ed 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -514,10 +514,10 @@ static int xenon_remove(struct platform_device *pdev)
>  
>  	xenon_clean_phy(host);
>  
> -	xenon_sdhc_unprepare(host);
> -
>  	sdhci_remove_host(host, 0);
>  
> +	xenon_sdhc_unprepare(host);
> +
>  	clk_disable_unprepare(pltfm_host->clk);
>  
>  	sdhci_pltfm_free(pdev);
> 


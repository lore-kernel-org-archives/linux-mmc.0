From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH -next] mmc: sdhci-of-arasan: Fix non static symbol warning
Date: Mon, 26 Sep 2016 09:45:40 +0300
Message-ID: <c916cd6a-2929-91fc-2433-78f8638ff071@intel.com>
References: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752313AbcIZGuY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Sep 2016 02:50:24 -0400
In-Reply-To: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, ulf.hansson@linaro.org
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On 25/09/16 18:44, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/mmc/host/sdhci-of-arasan.c:253:6: warning:
>  symbol 'sdhci_arasan_reset' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index da8e40a..e263671 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -250,7 +250,7 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
>  }
>  
> -void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> +static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>  {
>  	u8 ctrl;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> 
> 
> 
> 


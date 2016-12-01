From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: add spin_unlock_irq() before calling
 clk_round_rate
Date: Thu, 1 Dec 2016 08:58:17 +0200
Message-ID: <f702333c-70ea-714d-b5e8-23e53189ef68@intel.com>
References: <20161130060542.18225-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34986 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbcLAHDT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 02:03:19 -0500
In-Reply-To: <20161130060542.18225-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

On 30/11/16 08:05, Jaehoon Chung wrote:
> Before calling clk_round_rate(), put the spin_unlock_irq() in
> sdhci_s3c_consider_clock() function.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 784c5a8..de219ca 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -121,7 +121,9 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>  	 * speed possible with selected clock source and skip the division.
>  	 */
>  	if (ourhost->no_divider) {
> +		spin_unlock_irq(&ourhost->host->lock);
>  		rate = clk_round_rate(clksrc, wanted);
> +		spin_lock_irq(&ourhost->host->lock);
>  		return wanted - rate;
>  	}
>  
> 


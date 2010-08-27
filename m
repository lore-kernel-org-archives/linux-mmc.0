From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] S3C: SDHCI: Modify timeout clock calculation.
Date: Fri, 27 Aug 2010 20:36:03 +0100
Message-ID: <20100827193603.GE23079@void.printf.net>
References: <1267772563-14846-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1267772563-14846-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

This wasn't picked up -- any comments from the list?

On Fri, Mar 05, 2010 at 12:32:43PM +0530, Thomas Abraham wrote:
> In sdhci_s3c_set_clock function of S3C SDHCI controller driver, when a new
> clock source is selected, the timeout clock is recalculated. This patch 
> modifies the calculation of the timeout clock based on the 
> SDHCI_TIMEOUT_CLK_UNIT capability which is determined from the 
> SDHCI_CAPABILITIES register.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 50997d2..ab4641c 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -181,6 +181,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	if (ourhost->cur_clk != best_src) {
>  		struct clk *clk = ourhost->clk_bus[best_src];
> +		unsigned int caps;
>  
>  		/* turn clock off to card before changing clock source */
>  		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
> @@ -188,7 +189,10 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>  		ourhost->cur_clk = best_src;
>  		host->max_clk = clk_get_rate(clk);
>  		host->timeout_clk = sdhci_s3c_get_timeout_clk(host);
> -
> +		caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
> +		if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> +			host->timeout_clk *= 1000;
> +
>  		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
>  		ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
>  		ctrl |= best_src << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
> -- 
> 1.6.6.rc2

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

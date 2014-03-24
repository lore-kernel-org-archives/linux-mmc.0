From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/7] mmc: dw_mmc: exynos: don't use if clock isn't available
Date: Mon, 24 Mar 2014 13:19:40 +0900
Message-ID: <532FB25C.6000700@samsung.com>
References: <001c01cf450e$51ba0d40$f52e27c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <001c01cf450e$51ba0d40$f52e27c0$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi, Seungwon.

On 03/21/2014 11:03 PM, Seungwon Jeon wrote:
> Adds checking whether the clock is valid.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index a67e784..89aa019 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -117,7 +117,12 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>  static int dw_mci_exynos_setup_clock(struct dw_mci *host)
>  {
>  	struct dw_mci_exynos_priv_data *priv = host->priv;
> -	unsigned long rate = clk_get_rate(host->ciu_clk);
> +	unsigned long rate;
> +
> +	if (IS_ERR(host->ciu_clk))
> +		rate = host->bus_hz;
> +	else
> +		rate = clk_get_rate(host->ciu_clk);
>  
>  	host->bus_hz = rate / (priv->ciu_div + 1);
how about this?
host->bus_hz /= (priv->ciu_div + 1);

host->bus_hz is already set to "host->bus_hz" or "clk_get_rate()" into dw_mmc.c.

Best Regards,
Jaehoon Chung
>  	return 0;
> @@ -196,8 +201,11 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  		mci_writel(host, CLKSEL, priv->sdr_timing);
>  	}
>  
> -	/* Don't care if wanted clock is zero */
> -	if (!wanted)
> +	/*
> +	 * Don't care if wanted clock is zero or
> +	 * ciu clock is unavailable
> +	 */
> +	if (!wanted || IS_ERR(host->ciu_clk))
>  		return;
>  
>  	/* Guaranteed minimum frequency for cclkin */
> 

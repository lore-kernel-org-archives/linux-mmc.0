From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/7] mmc: dw_mmc: exynos: don't use if clock isn't
 available
Date: Mon, 14 Apr 2014 16:30:45 +0900
Message-ID: <534B8EA5.8070906@samsung.com>
References: <000201cf48e6$e05f8cb0$a11ea610$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55672 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaDNHaq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 03:30:46 -0400
In-reply-to: <000201cf48e6$e05f8cb0$a11ea610$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 03/26/2014 08:31 PM, Seungwon Jeon wrote:
> Add checking whether the clock is valid.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index a67e784..a2d06c5 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -117,9 +117,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>  static int dw_mci_exynos_setup_clock(struct dw_mci *host)
>  {
>  	struct dw_mci_exynos_priv_data *priv = host->priv;
> -	unsigned long rate = clk_get_rate(host->ciu_clk);
>  
> -	host->bus_hz = rate / (priv->ciu_div + 1);
> +	host->bus_hz /= (priv->ciu_div + 1);
> +
>  	return 0;
>  }
>  
> @@ -196,8 +196,11 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
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


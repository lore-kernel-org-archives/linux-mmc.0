From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v2 07/14] mmc: sdhci-st: simplify optional reset handling
Date: Wed, 15 Mar 2017 13:20:19 +0000
Message-ID: <ab5782be-4a3e-f9bd-9c85-a26edf8a1bbb@st.com>
References: <20170315113141.20238-1-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315113141.20238-1-p.zabel@pengutronix.de>
Content-Language: en-US
Content-ID: <D8FBF56ACFE91F409AE35313936651B4@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Philipp

On 03/15/2017 12:31 PM, Philipp Zabel wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-st.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index ed92ce729dde1..5a782b9bae381 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -371,11 +371,10 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	if (IS_ERR(icnclk))
>  		icnclk = NULL;
>
> -	rstc = devm_reset_control_get(&pdev->dev, NULL);
> +	rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
>  	if (IS_ERR(rstc))
> -		rstc = NULL;
> -	else
> -		reset_control_deassert(rstc);
> +		return PTR_ERR(rstc);
> +	reset_control_deassert(rstc);
>
>  	host = sdhci_pltfm_init(pdev, &sdhci_st_pdata, sizeof(*pdata));
>  	if (IS_ERR(host)) {
> @@ -435,8 +434,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  err_of:
>  	sdhci_pltfm_free(pdev);
>  err_pltfm_init:
> -	if (rstc)
> -		reset_control_assert(rstc);
> +	reset_control_assert(rstc);
>
>  	return ret;
>  }
> @@ -453,8 +451,7 @@ static int sdhci_st_remove(struct platform_device *pdev)
>
>  	clk_disable_unprepare(pdata->icnclk);
>
> -	if (rstc)
> -		reset_control_assert(rstc);
> +	reset_control_assert(rstc);
>
>  	return ret;
>  }
> @@ -470,8 +467,7 @@ static int sdhci_st_suspend(struct device *dev)
>  	if (ret)
>  		goto out;
>
> -	if (pdata->rstc)
> -		reset_control_assert(pdata->rstc);
> +	reset_control_assert(pdata->rstc);
>
>  	clk_disable_unprepare(pdata->icnclk);
>  	clk_disable_unprepare(pltfm_host->clk);
> @@ -489,8 +485,7 @@ static int sdhci_st_resume(struct device *dev)
>  	clk_prepare_enable(pltfm_host->clk);
>  	clk_prepare_enable(pdata->icnclk);
>
> -	if (pdata->rstc)
> -		reset_control_deassert(pdata->rstc);
> +	reset_control_deassert(pdata->rstc);
>
>  	st_mmcss_cconfig(np, host);
>
>

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks

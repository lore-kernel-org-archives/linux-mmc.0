From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 20 Oct 2016 16:08:36 +0300
Message-ID: <e203153c-da0a-d450-3471-9d0dabf0a2ed@linaro.org>
References: <20161018101624.27946-1-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161018101624.27946-1-pramod.gurav@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>, ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, riteshh@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Pramod,

Thanks for the patch!

On 10/18/2016 01:16 PM, Pramod Gurav wrote:
> Provides runtime PM callbacks to enable and disable clock resources
> when idle. Also support system PM callbacks to be called during system
> suspend and resume.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> ---
>
> Tested on DB410C.
>

[..]

> +static int sdhci_msm_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(msm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "clk_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +	ret = clk_prepare_enable(msm_host->pclk);
> +	if (ret) {
> +		dev_err(dev, "clk_enable failed: %d\n", ret);

Nit: Maybe mention in the prints which clock failed - core or peripheral.

> +		clk_disable_unprepare(msm_host->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +					pm_runtime_force_resume)

Nit: Please align with the parenthesis.

> +	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume,
> +				NULL)

Ditto.

Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

BR,
Georgi

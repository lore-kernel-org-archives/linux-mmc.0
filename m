From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/7] mmc: sdhci-msm: Adapt the driver to use OPPs to set
 clocks/performance state
Date: Fri, 16 Mar 2018 10:11:32 +0530
Message-ID: <20180316044132.GS15832@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-7-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-7-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 16-03-18, 09:38, Rajendra Nayak wrote:
> @@ -1540,6 +1571,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> +	dev_pm_opp_of_remove_table(&pdev->dev);

You can't do this if there is no OPP table. Probably you should just
make it part of the below if block.

> +	if (msm_host->opp_table)
> +		dev_pm_opp_put_clkname(msm_host->opp_table);
>  clk_disable:
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);
> @@ -1564,6 +1598,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> +	dev_pm_opp_of_remove_table(&pdev->dev);

And this too.

> +	if (msm_host->opp_table)
> +		dev_pm_opp_put_clkname(msm_host->opp_table);
>  
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

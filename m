From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/5] mmc: msm_sdcc: Switch to using managed resources
Date: Tue, 16 Sep 2014 23:11:49 +0100
Message-ID: <5418B5A5.9000400@linaro.org>
References: <1410866146-15144-1-git-send-email-pramod.gurav@smartplayin.com> <1410866146-15144-2-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410866146-15144-2-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>, pramod.gurav.etc@gmail.com
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Pramod,
Thankyou for the patches.

You should be aware that this driver is due to be *Removed* very soon.

Basically msm_sdcc is a hacked version of mmci driver.
 From v3.17 mmci driver added support for qualcomm specific 
customization to pl180.
So msm platform should be able to use pl180 mmci driver, rather than 
using msm_sdcc.

Thanks,
srini


On 16/09/14 12:15, Pramod Gurav wrote:
> This change makes changes to use managed version of ioremap, clk_get,
> request_irq etc for clean unloading of modules. This does away with
> lables to release these resources.
>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> CC: linux-arm-msm@vger.kernel.org
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>   drivers/mmc/host/msm_sdcc.c |   43 +++++++++++++++++--------------------------
>   1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 9405ecd..2b8ac9c 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -1224,7 +1224,7 @@ msmsdcc_probe(struct platform_device *pdev)
>
>   	host->cmdpoll = 1;
>
> -	host->base = ioremap(memres->start, PAGE_SIZE);
> +	host->base = devm_ioremap(&pdev->dev, memres->start, PAGE_SIZE);
>   	if (!host->base) {
>   		ret = -ENOMEM;
>   		goto host_free;
> @@ -1244,33 +1244,33 @@ msmsdcc_probe(struct platform_device *pdev)
>   	if (host->dmares) {
>   		ret = msmsdcc_init_dma(host);
>   		if (ret)
> -			goto ioremap_free;
> +			goto tasklet_kill;
>   	} else {
>   		host->dma.channel = -1;
>   	}
>
>   	/* Get our clocks */
> -	host->pclk = clk_get(&pdev->dev, "sdc_pclk");
> +	host->pclk = devm_clk_get(&pdev->dev, "sdc_pclk");
>   	if (IS_ERR(host->pclk)) {
>   		ret = PTR_ERR(host->pclk);
>   		goto dma_free;
>   	}
>
> -	host->clk = clk_get(&pdev->dev, "sdc_clk");
> +	host->clk = devm_clk_get(&pdev->dev, "sdc_clk");
>   	if (IS_ERR(host->clk)) {
>   		ret = PTR_ERR(host->clk);
> -		goto pclk_put;
> +		goto dma_free;
>   	}
>
>   	ret = clk_set_rate(host->clk, msmsdcc_fmin);
>   	if (ret) {
>   		pr_err("%s: Clock rate set failed (%d)\n", __func__, ret);
> -		goto clk_put;
> +		goto dma_free;
>   	}
>
>   	ret = clk_prepare(host->pclk);
>   	if (ret)
> -		goto clk_put;
> +		goto dma_free;
>
>   	ret = clk_prepare(host->clk);
>   	if (ret)
> @@ -1322,7 +1322,7 @@ msmsdcc_probe(struct platform_device *pdev)
>   			(stat_irqres->flags & IRQF_TRIGGER_MASK);
>
>   		host->stat_irq = stat_irqres->start;
> -		ret = request_irq(host->stat_irq,
> +		ret = devm_request_irq(&pdev->dev, host->stat_irq,
>   				  msmsdcc_platform_status_irq,
>   				  irqflags,
>   				  DRIVER_NAME " (slot)",
> @@ -1350,15 +1350,15 @@ msmsdcc_probe(struct platform_device *pdev)
>   		host->eject = !host->oldstat;
>   	}
>
> -	ret = request_irq(cmd_irqres->start, msmsdcc_irq, IRQF_SHARED,
> -			  DRIVER_NAME " (cmd)", host);
> +	ret = devm_request_irq(&pdev->dev, cmd_irqres->start, msmsdcc_irq,
> +			       IRQF_SHARED, DRIVER_NAME " (cmd)", host);
>   	if (ret)
> -		goto stat_irq_free;
> +		goto clk_disable;
>
> -	ret = request_irq(cmd_irqres->start, msmsdcc_pio_irq, IRQF_SHARED,
> -			  DRIVER_NAME " (pio)", host);
> +	ret = devm_request_irq(&pdev->dev, cmd_irqres->start, msmsdcc_pio_irq,
> +			       IRQF_SHARED, DRIVER_NAME " (pio)", host);
>   	if (ret)
> -		goto cmd_irq_free;
> +		goto clk_disable;
>
>   	mmc_set_drvdata(pdev, mmc);
>   	mmc_add_host(mmc);
> @@ -1387,28 +1387,19 @@ msmsdcc_probe(struct platform_device *pdev)
>   		pr_info("%s: Polling status mode enabled\n", mmc_hostname(mmc));
>
>   	return 0;
> - cmd_irq_free:
> -	free_irq(cmd_irqres->start, host);
> - stat_irq_free:
> -	if (host->stat_irq)
> -		free_irq(host->stat_irq, host);
> +
>    clk_disable:
>   	msmsdcc_disable_clocks(host, 0);
>    clk_unprepare:
>   	clk_unprepare(host->clk);
>    clk_unprepare_p:
>   	clk_unprepare(host->pclk);
> - clk_put:
> -	clk_put(host->clk);
> - pclk_put:
> -	clk_put(host->pclk);
> -dma_free:
> + dma_free:
>   	if (host->dmares)
>   		dma_free_coherent(NULL, sizeof(struct msmsdcc_nc_dmadata),
>   					host->dma.nc, host->dma.nc_busaddr);
> -ioremap_free:
> + tasklet_kill:
>   	tasklet_kill(&host->dma_tlet);
> -	iounmap(host->base);
>    host_free:
>   	mmc_free_host(mmc);
>    out:
>

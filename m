From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Wed, 19 Sep 2012 02:14:55 -0400
Message-ID: <m3fw6eilnk.fsf@pullcord.laptop.org>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
	<1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
	(Chander Kashyap's message of "Fri, 14 Sep 2012 14:38:51 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon, Girish,

On Fri, Sep 14 2012, Chander Kashyap wrote:
> Perform clock disable/enable in runtime suspend/resume.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 3f4518d..ffffd51 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -513,7 +513,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  		goto err_no_busclks;
>  	}
>  
> +#ifndef CONFIG_PM_RUNTIME
>  	clk_enable(sc->clk_bus[sc->cur_clk]);
> +#endif
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
> @@ -620,10 +622,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	    gpio_is_valid(pdata->ext_cd_gpio))
>  		sdhci_s3c_setup_card_detect_gpio(sc);
>  
> +	clk_disable(sc->clk_io);
>  	return 0;
>  
>   err_req_regs:
> +#ifndef CONFIG_PM_RUNTIME
>  	clk_disable(sc->clk_bus[sc->cur_clk]);
> +#endif
>  	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		if (sc->clk_bus[ptr]) {
>  			clk_put(sc->clk_bus[ptr]);
> @@ -656,12 +661,15 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  	if (gpio_is_valid(sc->ext_cd_gpio))
>  		gpio_free(sc->ext_cd_gpio);
>  
> +	clk_enable(sc->clk_io);
>  	sdhci_remove_host(host, 1);
>  
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> +#ifndef CONFIG_PM_RUNTIME
>  	clk_disable(sc->clk_bus[sc->cur_clk]);
> +#endif
>  	for (ptr = 0; ptr < 3; ptr++) {
>  		if (sc->clk_bus[ptr]) {
>  			clk_put(sc->clk_bus[ptr]);
> @@ -696,15 +704,28 @@ static int sdhci_s3c_resume(struct device *dev)
>  static int sdhci_s3c_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	struct clk *busclk = ourhost->clk_io;
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);
>  
> -	return sdhci_runtime_suspend_host(host);
> +	clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
> +	clk_disable(busclk);
> +	return ret;
>  }
>  
>  static int sdhci_s3c_runtime_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	struct clk *busclk = ourhost->clk_io;
> +	int ret;
>  
> -	return sdhci_runtime_resume_host(host);
> +	clk_enable(busclk);
> +	clk_enable(ourhost->clk_bus[ourhost->cur_clk]);
> +	ret = sdhci_runtime_resume_host(host);
> +	return ret;
>  }
>  #endif

Could I get an ACK on this patch from one of you, please?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

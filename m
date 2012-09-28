From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-spear: Add clk_{un}prepare() support
Date: Fri, 28 Sep 2012 06:59:13 -0400
Message-ID: <87wqzetnum.fsf@octavius.laptop.org>
References: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
	<cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
	<a5ffa125606bf00e558145364281e9ea8551ff77.1348828070.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38560 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab2I1K7T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Sep 2012 06:59:19 -0400
In-Reply-To: <a5ffa125606bf00e558145364281e9ea8551ff77.1348828070.git.viresh.kumar@linaro.org>
	(Viresh Kumar's message of "Fri, 28 Sep 2012 15:58:23 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de

Hi,

On Fri, Sep 28 2012, Viresh Kumar wrote:
> clk_{un}prepare is mandatory for platforms using common clock framework. Since
> this driver is used by SPEAr platform, which supports common clock framework,
> add clk_{un}prepare() support for it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/mmc/host/sdhci-spear.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index ecad282..6be89c0 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -140,7 +140,7 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	ret = clk_enable(sdhci->clk);
> +	ret = clk_prepare_enable(sdhci->clk);
>  	if (ret) {
>  		dev_dbg(&pdev->dev, "Error enabling clock\n");
>  		goto put_clk;
> @@ -260,7 +260,7 @@ set_drvdata:
>  free_host:
>  	sdhci_free_host(host);
>  disable_clk:
> -	clk_disable(sdhci->clk);
> +	clk_disable_unprepare(sdhci->clk);
>  put_clk:
>  	clk_put(sdhci->clk);
>  err:
> @@ -282,7 +282,7 @@ static int __devexit sdhci_remove(struct platform_device *pdev)
>  
>  	sdhci_remove_host(host, dead);
>  	sdhci_free_host(host);
> -	clk_disable(sdhci->clk);
> +	clk_disable_unprepare(sdhci->clk);
>  	clk_put(sdhci->clk);
>  
>  	return 0;
> @@ -297,7 +297,7 @@ static int sdhci_suspend(struct device *dev)
>  
>  	ret = sdhci_suspend_host(host);
>  	if (!ret)
> -		clk_disable(sdhci->clk);
> +		clk_disable_unprepare(sdhci->clk);
>  
>  	return ret;
>  }
> @@ -308,7 +308,7 @@ static int sdhci_resume(struct device *dev)
>  	struct spear_sdhci *sdhci = dev_get_platdata(dev);
>  	int ret;
>  
> -	ret = clk_enable(sdhci->clk);
> +	ret = clk_prepare_enable(sdhci->clk);
>  	if (ret) {
>  		dev_dbg(dev, "Resume: Error enabling clock\n");
>  		return ret;

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

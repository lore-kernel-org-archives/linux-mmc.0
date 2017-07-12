From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Wed, 12 Jul 2017 08:45:13 +0800
Message-ID: <6cee0ebb-fd00-0a4d-041f-ec1a303be335@rock-chips.com>
References: <1499810209-30505-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:52589 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756233AbdGLApK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 20:45:10 -0400
In-Reply-To: <1499810209-30505-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, Hu Ziji <huziji@marvell.com>

Hi Zhoujie,

On 2017/7/12 5:56, Zhoujie Wu wrote:
> Add Xenon specific system-level suspend and resume support.
> Especially during resume, re-configure Xenon specific registers
> since registers setting will be lost in suspend if Xenon is power off.
> 

Still you need a 'From: Hu Ziji <huziji@marvell.com>'  segment ahead to
reflect the authorship by using:

git commit --author="Hu Ziji <huziji@marvell.com>"

And please remove his mail from CC since his mail address
is no longer used. BTW, I submited a patch to fix the warning
for sdhci-xenon and the get_maintainer script still shows me that
he maintains this driver. So would you like to take over the
role to maintain this driver or you just like to orphan it?

> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> Tested-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Hu Ziji has left marvell, submit the patch for him.
>   drivers/mmc/host/sdhci-xenon.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index bc1781b..9f399c4 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -519,6 +519,46 @@ static int xenon_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
> +static int xenon_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int ret;
> +
> +	ret = sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	return ret;
> +}
> +
> +static int xenon_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If SoCs power off the entire Xenon, registers setting will
> +	 * be lost.
> +	 * Re-configure Xenon specific register to enable current SDHC
> +	 */
> +	ret = xenon_sdhc_prepare(host);
> +	if (ret)
> +		return ret;
> +
> +	return sdhci_resume_host(host);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
> +
>   static const struct of_device_id sdhci_xenon_dt_ids[] = {
>   	{ .compatible = "marvell,armada-ap806-sdhci",},
>   	{ .compatible = "marvell,armada-cp110-sdhci",},
> @@ -531,7 +571,7 @@ static int xenon_remove(struct platform_device *pdev)
>   	.driver	= {
>   		.name	= "xenon-sdhci",
>   		.of_match_table = sdhci_xenon_dt_ids,
> -		.pm = &sdhci_pltfm_pmops,
> +		.pm = &xenon_pmops,
>   	},
>   	.probe	= xenon_probe,
>   	.remove	= xenon_remove,
> 


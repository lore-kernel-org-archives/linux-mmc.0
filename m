From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 4/8] mmc: sdhci-pxav3: enable proper resuming on Armada 38x SoC
Date: Tue, 06 Oct 2015 16:51:15 +0200
Message-ID: <877fn09hjw.fsf@free-electrons.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-5-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53041 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbJFO6Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 10:58:25 -0400
In-Reply-To: <1444094562-31165-5-git-send-email-mw@semihalf.com> (Marcin
	Wojtas's message of "Tue, 6 Oct 2015 03:22:38 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com

Hi Marcin,
 
 On mar., oct. 06 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> When resuming from suspend on Armada 38x SoC MBus windows have to be
> re-configured and for that purpose mv_conf_mbus_windows function needed
> rework. MBus windows register base address obtaining was moved to
> armada_38x_quirks function in order to be kept in pxa global structure,
> because it is used during a resume.
>
> This commit fixes resuming from suspend by calling MBus windows
> configuration routine and therefore enabling proper DMA operation.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index f5edf9d..3f71894 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -63,6 +63,7 @@ struct sdhci_pxa {
>  	struct clk *clk_io;
>  	u8	power_mode;
>  	void __iomem *sdio3_conf_reg;
> +	void __iomem *mbus_win_regs;
>  };


>  
> @@ -135,6 +120,14 @@ static int armada_38x_quirks(struct platform_device *pdev,
>  	struct sdhci_pxa *pxa = pltfm_host->priv;
>  	struct resource *res;
>  
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbus");
> +	pxa->mbus_win_regs = devm_ioremap_resource(&pdev->dev, res);

[...]

> @@ -520,6 +514,13 @@ static int sdhci_pxav3_resume(struct device *dev)
>  {
>  	int ret;
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_pxa *pxa = pltfm_host->priv;
> +	struct device_node *np = dev->of_node;
> +
> +	if (of_device_is_compatible(np, "marvell,armada-380-sdhci"))
> +		ret = mv_conf_mbus_windows(dev, pxa->mbus_win_regs,
> +					   mv_mbus_dram_info());

I would find it cleaner to not rely on the device tree outise the probe
function. What about just testing pxa->mbus_win_regs ? As it is set only
if we need it, it should be a good test.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs-mmc: enable regulator for mmc slot
Date: Tue, 03 Jul 2012 18:56:58 -0400
Message-ID: <87txxo78sl.fsf@octavius.laptop.org>
References: <1340699937-8163-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56253 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932955Ab2GCW5D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 18:57:03 -0400
In-Reply-To: <1340699937-8163-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Tue, 26 Jun 2012 16:38:57 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Jun 26 2012, Shawn Guo wrote:
> If bootloader or platform initialization code does not enable the
> power supply to mmc slot, we need to do it in mmc driver.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/mxs-mmc.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 34a9026..1a29668 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -707,6 +707,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	struct pinctrl *pinctrl;
>  	int ret = 0, irq_err, irq_dma;
>  	dma_cap_mask_t mask;
> +	struct regulator *reg_vmmc;
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> @@ -747,6 +748,16 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	host->mmc = mmc;
>  	host->sdio_irq_en = 0;
>  
> +	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> +	if (!IS_ERR(reg_vmmc)) {
> +		ret = regulator_enable(reg_vmmc);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to enable vmmc regulator: %d\n", ret);
> +			goto out_mmc_free;
> +		}
> +	}
> +
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>  	if (IS_ERR(pinctrl)) {
>  		ret = PTR_ERR(pinctrl);

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

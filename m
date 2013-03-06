From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 2/3] mmc: omap_hsmmc: Skip platform_get_resource_byname()
 for dt case
Date: Wed, 6 Mar 2013 19:12:29 +0530
Message-ID: <513747C5.6080507@ti.com>
References: <1362518004-7083-1-git-send-email-mporter@ti.com> <1362518004-7083-3-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362518004-7083-3-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>, Chris Ball <cjb@laptop.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 06 March 2013 02:43 AM, Matt Porter wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> MMC driver probe will abort for DT case because of failed
> platform_get_resource_byname() lookup. Fix it by skipping resource
> byname lookup for device tree build.
>
> Issue is hidden because hwmod popullates the IO resources which
> helps to succeed platform_get_resource_byname() and probe.
>

Hi Matt,
Could you please drop this patch from the current series,
since this patch causes regression on omap3,4 platform
which are not yet dma dt adapted.
It is best to send this patch along with Jon Hunter dma dt series,
which adds dt dma support and mmc dma data. DMA dt series is needed
any way before hwmod cleanup can happen.


> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>   drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e79b12d..8ae1225 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1896,21 +1896,23 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>
>   	omap_hsmmc_conf_bus_power(host);
>
> -	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -	if (!res) {
> -		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> -	}
> -	tx_req = res->start;
> +	if (!pdev->dev.of_node) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +			ret = -ENXIO;
> +			goto err_irq;
> +		}
> +		tx_req = res->start;
>
> -	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -	if (!res) {
> -		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +			ret = -ENXIO;
> +			goto err_irq;
> +		}
> +		rx_req = res->start;
>   	}
> -	rx_req = res->start;
>
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>

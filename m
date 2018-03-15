From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 04/11] mmc: sdhci-omap: Invoke sdhci_get_of_property to
 read sdhci dt properties
Date: Thu, 15 Mar 2018 16:27:19 +0200
Message-ID: <e7c61727-0ff5-edb5-b3eb-679f07afbce6@intel.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-5-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-5-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Invoke sdhci_get_of_property defined in sdhci-pltfm.c to read
> sdhci specific properties from dt node.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index fbc20a4fbb23..314dbe4d7412 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -893,6 +893,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->ioaddr += offset;
>  
>  	mmc = host->mmc;
> +	sdhci_get_of_property(pdev);
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
>  		goto err_pltfm_free;
> 

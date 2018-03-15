From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 02/11] mmc: sdhci-omap: Remove setting ADMA capability
 in driver
Date: Thu, 15 Mar 2018 16:18:49 +0200
Message-ID: <a867eebf-2c32-4a0f-713a-766d81d52c4c@intel.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-3-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-3-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> sdhci can directly get ADMA capability from MMCHS_CAPA register.
> Remove explicitly setting ADMA here as some instances might not have
> ADMA enabled. (sdhci_read_caps() is also removed from here since
> sdhci_setup_host() invokes it).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 3cce30584d2f..0c40b13fb67d 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -923,9 +923,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
>  	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
>  
> -	sdhci_read_caps(host);
> -	host->caps |= SDHCI_CAN_DO_ADMA2;
> -
>  	ret = sdhci_setup_host(host);
>  	if (ret)
>  		goto err_put_sync;
> 

From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: support more DT properties
Date: Tue, 18 Feb 2014 20:06:36 +0530
Message-ID: <53036FF4.2000906@ti.com>
References: <1392636993-15864-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1392636993-15864-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday 17 February 2014 05:06 PM, Daniel Mack wrote:
> This should probably be done implicitly through mmc_of_parse(), but that
> doesn't play well along with the multi-slot model the hsmmc driver
> features. Hence, for now, do it manually. The properties are already
> documented in Documentation/devicetree/bindings/mmc/mmc.txt.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

looks good to me
Acked-by: Balaji T K <balajitk@ti.com>

> ---
>   drivers/mmc/host/omap_hsmmc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 2815de6..a5a38cc 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1765,6 +1765,12 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>   	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
>   		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
>
> +	if (of_find_property(np, "keep-power-in-suspend", NULL))
> +		pdata->slots[0].pm_caps |= MMC_PM_KEEP_POWER;
> +
> +	if (of_find_property(np, "enable-sdio-wakeup", NULL))
> +		pdata->slots[0].pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +
>   	return pdata;
>   }
>   #else
>


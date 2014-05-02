From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v10 4/5] mmc: omap_hsmmc: switch default/idle pinctrl
 states in runtime hooks
Date: Fri, 2 May 2014 20:08:55 +0530
Message-ID: <5363ADFF.5020306@ti.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com> <1398670860-30695-5-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1398670860-30695-5-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday 28 April 2014 01:10 PM, Andreas Fenkart wrote:
> These are predefined states of the driver model. When not present,
> as if not set in the device tree, they simple become no-ops.
> So it is always safe to call them.
> This is not the simplest implementation, on AM335x at least, we could
> witch to idle at any point in the suspend hook, only the default state
> needs to be set before writing to the irq registers or an IRQ might get
> lost.
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 76fe3bd..9cc0d21 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1992,7 +1992,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   	dma_cap_mask_t mask;
>   	unsigned tx_req, rx_req;
> -	struct pinctrl *pinctrl;
>   	const struct omap_mmc_of_data *data;
>
>   	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
> @@ -2215,11 +2214,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>   	}
>
>   	omap_hsmmc_disable_irq(host);
> -
> -	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -	if (IS_ERR(pinctrl))
> -		dev_warn(&pdev->dev,
> -			"pins are not configured from the driver\n");
> +	pinctrl_pm_select_default_state(host->dev);

This can be removed, since device core layer sets pin mux to "default" state
before probe.



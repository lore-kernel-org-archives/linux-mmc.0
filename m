From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH] mmc: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 07:55:40 +0200
Message-ID: <20170719055540.zwo3igm5rozcawp5@rfolt0960.corp.atmel.com>
References: <20170718214339.7774-36-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-36-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Steven J. Hill" <Steven.Hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 18, 2017 at 04:43:16PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> Cc: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Cc: "Steven J. Hill" <Steven.Hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/mmc/core/core.c      | 8 ++++----
>  drivers/mmc/host/atmel-mci.c | 4 ++--

Acked-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

>  drivers/mmc/host/cavium.c    | 6 ++----
>  3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 26431267a3e2..6b4117615ad6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1137,11 +1137,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>  	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
>  	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>  	if (!voltage_ranges) {
> -		pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
> +		pr_debug("%pOF: voltage-ranges unspecified\n", np);
>  		return 0;
>  	}
>  	if (!num_ranges) {
> -		pr_err("%s: voltage-ranges empty\n", np->full_name);
> +		pr_err("%pOF: voltage-ranges empty\n", np);
>  		return -EINVAL;
>  	}
> 
> @@ -1153,8 +1153,8 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>  				be32_to_cpu(voltage_ranges[j]),
>  				be32_to_cpu(voltage_ranges[j + 1]));
>  		if (!ocr_mask) {
> -			pr_err("%s: voltage-range #%d is invalid\n",
> -				np->full_name, i);
> +			pr_err("%pOF: voltage-range #%d is invalid\n",
> +				np, i);
>  			return -EINVAL;
>  		}
>  		*mask |= ocr_mask;
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 97de2d32ba84..b7c1cd384306 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -665,8 +665,8 @@ atmci_of_init(struct platform_device *pdev)
> 
>  	for_each_child_of_node(np, cnp) {
>  		if (of_property_read_u32(cnp, "reg", &slot_id)) {
> -			dev_warn(&pdev->dev, "reg property is missing for %s\n",
> -				 cnp->full_name);
> +			dev_warn(&pdev->dev, "reg property is missing for %pOF\n",
> +				 cnp);
>  			continue;
>  		}
> 
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 3686d77c717b..27fb625cbcf3 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -957,14 +957,12 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
> 
>  	ret = of_property_read_u32(node, "reg", &id);
>  	if (ret) {
> -		dev_err(dev, "Missing or invalid reg property on %s\n",
> -			of_node_full_name(node));
> +		dev_err(dev, "Missing or invalid reg property on %pOF\n", node);
>  		return ret;
>  	}
> 
>  	if (id >= CAVIUM_MAX_MMC || slot->host->slot[id]) {
> -		dev_err(dev, "Invalid reg property on %s\n",
> -			of_node_full_name(node));
> +		dev_err(dev, "Invalid reg property on %pOF\n", node);
>  		return -EINVAL;
>  	}
> 
> --
> 2.11.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

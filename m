From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] mmc: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 15:00:13 -0700
Message-ID: <f997ecad-7e8f-b807-494a-7c458cd8ff90@caviumnetworks.com>
References: <20170718214339.7774-36-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-36-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 07/18/2017 02:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Jan Glauber <jglauber@cavium.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: "Steven J. Hill" <Steven.Hill@cavium.com>
> Cc: linux-mmc@vger.kernel.org

For the Cavium bits, I haven't tested them, but they look fine, so ...

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   drivers/mmc/core/core.c      | 8 ++++----
>   drivers/mmc/host/atmel-mci.c | 4 ++--
>   drivers/mmc/host/cavium.c    | 6 ++----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 26431267a3e2..6b4117615ad6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1137,11 +1137,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>   	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
>   	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>   	if (!voltage_ranges) {
> -		pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
> +		pr_debug("%pOF: voltage-ranges unspecified\n", np);
>   		return 0;
>   	}
>   	if (!num_ranges) {
> -		pr_err("%s: voltage-ranges empty\n", np->full_name);
> +		pr_err("%pOF: voltage-ranges empty\n", np);
>   		return -EINVAL;
>   	}
> 
> @@ -1153,8 +1153,8 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>   				be32_to_cpu(voltage_ranges[j]),
>   				be32_to_cpu(voltage_ranges[j + 1]));
>   		if (!ocr_mask) {
> -			pr_err("%s: voltage-range #%d is invalid\n",
> -				np->full_name, i);
> +			pr_err("%pOF: voltage-range #%d is invalid\n",
> +				np, i);
>   			return -EINVAL;
>   		}
>   		*mask |= ocr_mask;
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 97de2d32ba84..b7c1cd384306 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -665,8 +665,8 @@ atmci_of_init(struct platform_device *pdev)
> 
>   	for_each_child_of_node(np, cnp) {
>   		if (of_property_read_u32(cnp, "reg", &slot_id)) {
> -			dev_warn(&pdev->dev, "reg property is missing for %s\n",
> -				 cnp->full_name);
> +			dev_warn(&pdev->dev, "reg property is missing for %pOF\n",
> +				 cnp);
>   			continue;
>   		}
> 
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 3686d77c717b..27fb625cbcf3 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -957,14 +957,12 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
> 
>   	ret = of_property_read_u32(node, "reg", &id);
>   	if (ret) {
> -		dev_err(dev, "Missing or invalid reg property on %s\n",
> -			of_node_full_name(node));
> +		dev_err(dev, "Missing or invalid reg property on %pOF\n", node);
>   		return ret;
>   	}
> 
>   	if (id >= CAVIUM_MAX_MMC || slot->host->slot[id]) {
> -		dev_err(dev, "Invalid reg property on %s\n",
> -			of_node_full_name(node));
> +		dev_err(dev, "Invalid reg property on %pOF\n", node);
>   		return -EINVAL;
>   	}
> 
> --
> 2.11.0
> 

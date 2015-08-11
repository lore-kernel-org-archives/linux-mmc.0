From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add the support for sdhci-5.1
Date: Tue, 11 Aug 2015 09:21:51 +0800
Message-ID: <55C94E2F.5000907@rock-chips.com>
References: <1439255696-3263-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439255696-3263-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: lintao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Zhou Wang <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Govindraj Raja <govindraj.raja-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar
List-Id: linux-mmc@vger.kernel.org

On 2015/8/11 9:14, Shawn Lin wrote:
> This patch adds the quirks and compatible string in sdhci-of-arasan.c
> to support sdhci-arasan5.1 version of controller.
>

Sorry for wrong send-email ops, pls ignore this patch :(

> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>
>   Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 +-
>   drivers/mmc/host/sdhci-of-arasan.c                     | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 7e94903..da541c3 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -9,7 +9,7 @@ Device Tree Bindings for the Arasan SDHCI Controller
>
>   Required Properties:
>     - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> -                'arasan,sdhci-4.9a'
> +                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>     - reg: From mmc bindings: Register location and length.
>     - clocks: From clock bindings: Handles to clock inputs.
>     - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index ef5a7d2..c9012f5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -175,6 +175,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>   		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>   		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> +					   "arasan,sdhci-5.1")) {
> +		host->quirks |= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>   	}
>
>   	sdhci_get_of_property(pdev);
> @@ -217,6 +220,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>
>   static const struct of_device_id sdhci_arasan_of_match[] = {
>   	{ .compatible = "arasan,sdhci-8.9a" },
> +	{ .compatible = "arasan,sdhci-5.1" },
>   	{ .compatible = "arasan,sdhci-4.9a" },
>   	{ }
>   };
>


-- 
Shawn Lin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

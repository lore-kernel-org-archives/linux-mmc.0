From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 1/2] Documentation: mmc: sdhci-of-arasan: add description of power domain
Date: Sat, 17 Sep 2016 11:01:51 +0200
Message-ID: <1516490.mHlkLq5CeM@phil>
References: <20160917023250.1159-1-xzy.xu@rock-chips.com> <20160917023250.1159-2-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160917023250.1159-2-xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Samstag, 17. September 2016, 10:32:49 CEST schrieb Ziyuan Xu:
> Add power domain as a optional property for sdhci-of-arasan, which can
> be turned off in the so-called unused condition, such as suspend and
> remove. Aim to lower power requirements.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

@Ulf: I guess you'll take this binding change through the mmc tree and I'll 
pick up the devicetree change.


Heiko

> ---
> 
> Changes in v3:
> - fix a typo
> - add Rob's ack-tag
> 
> Changes in v2:
> - fix a typo
> - add an example code for power-domain
> 
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt index
> 3404afa..eb84d29 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -1,12 +1,14 @@
>  Device Tree Bindings for the Arasan SDHCI Controller
> 
> -  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4]
> bindings. +  The bindings follow the mmc[1], clock[2], interrupt[3], phy[4]
> and power +  domain[5] bindings.
>    Only deviations are documented here.
> 
>    [1] Documentation/devicetree/bindings/mmc/mmc.txt
>    [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
> +  [5] Documentation/devicetree/bindings/power/power_domain.txt
> 
>  Required Properties:
>    - compatible: Compatibility string.  One of:
> @@ -36,6 +38,8 @@ Optional Properties:
>    - #clock-cells: If specified this should be the value <0>.  With this
> property in place we will export a clock representing the Card Clock.  This
> clock is expected to be consumed by our PHY.  You must also specify +  -
> power-domains: A phandle and PM domain as specifier defined by bindings +  
>  of the power controller specified by phandle.
> 
>  Example:
>  	sdhci@e0100000 {
> @@ -71,5 +75,6 @@ Example:
>  		phys = <&emmc_phy>;
>  		phy-names = "phy_arasan";
>  		#clock-cells = <0>;
> +		power-domains = <&power RK3399_PD_EMMC>;
>  		status = "disabled";
>  	};


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

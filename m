From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: mmc: sdhci-of-arasan: add description
 of power domain
Date: Sat, 27 Aug 2016 22:50:33 +0800
Message-ID: <40f46bd6-22d2-f008-602a-47200340f733@rock-chips.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-2-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160827134103.28160-2-xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2016/8/27 21:41, Ziyuan Xu wrote:
> Add power domain as a optional property for sdhci-of-arasan, which can
> be truned off in the so-called unused condition, such as suspend and
> remove. Aim to lower power requirements.
>
> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> ---
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 3404afa..3f5189c 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -1,12 +1,14 @@
>  Device Tree Bindings for the Arasan SDHCI Controller
>
> -  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4] bindings.
> +  The bindings follow the mmc[1], clock[2], interrupt[3], phy[4] and power
> +  domain[5] bindings.
>    Only deviations are documented here.
>
>    [1] Documentation/devicetree/bindings/mmc/mmc.txt
>    [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>    [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
> +  [5] Documentation/devicetree/bindings/power/power_domain.txt
>
>  Required Properties:
>    - compatible: Compatibility string.  One of:
> @@ -36,6 +38,8 @@ Optional Properties:
>    - #clock-cells: If specified this should be the value <0>.  With this property
>      in place we will export a clock representing the Card Clock.  This clock
>      is expected to be consumed by our PHY.  You must also specify
> +  - power-domains: A phandle of and PM domain as specifier defined by bindings

	A phandle of what?

> +    of the power controller specified by phandle.
>
>  Example:
>  	sdhci@e0100000 {

It would be nice to add the example code.

>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

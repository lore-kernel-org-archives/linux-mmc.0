From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 5/7] dt-bindings: ti-omap-hsmmc: Document new
 compatible for sdhci omap
Date: Wed, 9 Aug 2017 15:12:23 -0700
Message-ID: <20170809221222.GK3934@atomide.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-6-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170807160142.12134-6-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170807 09:03]:
> Document the new compatible string "ti,dra7-sdhci" to be used for
> MMC controllers in DRA7 and DRA72 SoCs.

I wonder if this should really be documented for sdhci
instead of ti-omap-hsmmc.txt?

I agree it's better to use sdhci compatible and keep the
hsmmc compatible around as the sdhci is still missing features
for runtime PM and context save and restore etc.

Regards,

Tony


> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 0e026c151c1c..db80fdfd05d7 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -13,6 +13,7 @@ Required properties:
>   Should be "ti,omap3-pre-es3-hsmmc" for OMAP3 controllers pre ES3.0
>   Should be "ti,omap4-hsmmc", for OMAP4 controllers
>   Should be "ti,am33xx-hsmmc", for AM335x controllers
> + Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
>  - ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
>  
>  Optional properties:
> -- 
> 2.11.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

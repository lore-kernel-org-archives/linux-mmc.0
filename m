From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [v3 1/2] mmc: DT: sdhci-brcmstb: Bindings document for common
 sdhci-brcmstb
Date: Fri, 2 Sep 2016 09:55:45 -0500
Message-ID: <20160902145545.GA14098@rob-hp-laptop>
References: <20160830063010.10171-1-jaedon.shin@gmail.com>
 <20160830063010.10171-2-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160830063010.10171-2-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 30, 2016 at 03:30:09PM +0900, Jaedon Shin wrote:
> - Renames the DT binding document to common for ARM and MIPS based SoCs
> - Adds a compatible string "brcm,bcm7445-sdhci" that is representation
>   for the Broadcom BCM7445 and family. It is initial and typical 28nm
>   generation ARM based SoC.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt}        | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt} (81%)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
> similarity index 81%
> rename from Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
> rename to Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
> index 82847174c37d..555229367935 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
> @@ -8,14 +8,16 @@ on Device Tree properties to enable them for SoC/Board combinations
>  that support them.
>  
>  Required properties:
> -- compatible: "brcm,bcm7425-sdhci"
> +- compatible: should be one of the following
> +  - "brcm,bcm7425-sdhci"
> +  - "brcm,bcm7445-sdhci"
>  
>  Refer to clocks/clock-bindings.txt for generic clock consumer properties.
>  
>  Example:
>  
>  	sdhci@f03e0100 {
> -		compatible = "brcm,bcm7425-sdhci";
> +		compatible = "brcm,bcm7445-sdhci";
>  		reg = <0xf03e0000 0x100>;
>  		interrupts = <0x0 0x26 0x0>;
>  		sdhci,auto-cmd12;
> @@ -27,7 +29,7 @@ Example:
>  	sdhci@f03e0300 {
>  		non-removable;
>  		bus-width = <0x8>;
> -		compatible = "brcm,bcm7425-sdhci";
> +		compatible = "brcm,bcm7445-sdhci";

These changes to the example seem pointless. Drop them.

>  		reg = <0xf03e0200 0x100>;
>  		interrupts = <0x0 0x27 0x0>;
>  		sdhci,auto-cmd12;
> -- 
> 2.9.3
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

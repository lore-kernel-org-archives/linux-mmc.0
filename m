From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/7] IBM Akebono: Add a SDHCI platform driver
Date: Fri, 21 Feb 2014 15:14:30 +0100
Message-ID: <1773685.WfxOP0FuHM@wuerfel>
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au> <1392964293-13687-2-git-send-email-alistair@popple.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392964293-13687-2-git-send-email-alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alistair Popple <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Friday 21 February 2014 17:31:27 Alistair Popple wrote:

>  
> +config MMC_SDHCI_OF_476GTR
> +	tristate "SDHCI OF support for the IBM PPC476GTR SoC"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on PPC_OF
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  found on the PPC476GTR SoC.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.

Your driver doesn't actually do anything beyond what is in the common
sdhci-pltfm.c infrastructure. IMHO you really shoulnd't need a SoC
specific abstraction for it at all and instead add a generic
platform driver registration into sdhci-pltfm.c. I'd suggest
you use "generic-sdhci" (similar to what we do for usb-ohci and usb-ehci
now) as the compatible string and change your device tree to claim
compatibility with that and your soc-specific string.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

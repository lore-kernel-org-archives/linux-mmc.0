From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [v4 1/2] mmc: DT: sdhci-brcmstb: Bindings document for common
 sdhci-brcmstb
Date: Fri, 16 Sep 2016 14:42:04 -0500
Message-ID: <20160916194204.GA13822@rob-hp-laptop>
References: <20160909020840.2718-1-jaedon.shin@gmail.com>
 <20160909020840.2718-2-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160909020840.2718-2-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 09, 2016 at 11:08:39AM +0900, Jaedon Shin wrote:
> Changes to the DT binding document to separate the BCM7425 and the
> BCM7445.
> 
> A compatible string "brcm,bcm7425-sdhci" was representing the BCM7425
> SDHCI host controller with all BRCMSTB SoCs including the BCM7445. Now
> it should be separated because vary a bit in initialize each host
> controller.
> 
> - Renames the DT binding document to common name.
> - Adds a compatible string "brcm,bcm7445-sdhci" that is representing the
>   BCM7445 with thereafter 28nm generation ARM based SoCs.
> - Updates example nodes to represent the BCM7445.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt}        | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt} (81%)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

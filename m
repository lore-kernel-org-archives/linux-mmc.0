From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 5/7] dt-bindings: ti-omap-hsmmc: Document new
 compatible for sdhci omap
Date: Thu, 17 Aug 2017 11:13:47 +0530
Message-ID: <2cdf9bbe-b98b-8811-7587-268b7ef4ac66@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-6-kishon@ti.com> <20170809221222.GK3934@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170809221222.GK3934-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Thursday 10 August 2017 03:42 AM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170807 09:03]:
>> Document the new compatible string "ti,dra7-sdhci" to be used for
>> MMC controllers in DRA7 and DRA72 SoCs.
> 
> I wonder if this should really be documented for sdhci
> instead of ti-omap-hsmmc.txt?

hmm.. yeah, having a separate binding document for sdhci would make the binding
really clean and we also don't have to carry legacy binding code. But we'll be
never able to remove omap-hsmmc driver then and end up maintaining 2 drivers
for the same controller.
> 
> I agree it's better to use sdhci compatible and keep the
> hsmmc compatible around as the sdhci is still missing features
> for runtime PM and context save and restore etc.

yeah, once we have all the features in omap_hsmmc added in sdhci-omap, we can
add the omap-hsmmc compatible to sdhci-omap and remove omap-hsmmc driver.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

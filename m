From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add card-detection properties to core binding.
Date: Fri, 24 Aug 2012 13:44:51 +0800
Message-ID: <20120824054449.GP24242@S2101-09.ap.freescale.net>
References: <87pq6k46jg.fsf@octavius.laptop.org>
 <5033B0F0.7050506@gmail.com>
 <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
 <20120822055151.GT24242@S2101-09.ap.freescale.net>
 <877gsr5iz1.fsf@octavius.laptop.org>
 <CAJuYYwQz00ZzB5MxRG66XEPZApAtS6bwJAafmw3b=7DD7u+Crg@mail.gmail.com>
 <87y5l7421h.fsf@octavius.laptop.org>
 <CAJuYYwQLUs5qb8NqtPf3=ytNHJ_VdnN8Z4yWwyk2+OTftdWFXw@mail.gmail.com>
 <87393f3rkj.fsf@octavius.laptop.org>
 <874nnu245s.fsf_-_@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab2HXFoW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Aug 2012 01:44:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2795592pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Aug 2012 22:44:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <874nnu245s.fsf_-_@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>

On Wed, Aug 22, 2012 at 02:05:35PM -0400, Chris Ball wrote:
> Signed-off-by: Chris Ball <cjb@laptop.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Will move sdhci-esdhc-imx driver to this soon.

Regards,
Shawn

> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 8a6811f..8e2e0ba 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -9,12 +9,17 @@ Interpreted by the OF core:
>  Required properties:
>  - bus-width: Number of data lines, can be <1>, <4>, or <8>
>  
> +Card detection:
> +If no property below is supplied, standard SDHCI card detect is used.
> +Only one of the properties in this section should be supplied:
> +  - broken-cd: There is no card detection available; polling must be used.
> +  - cd-gpios: Specify GPIOs for card detection, see gpio binding
> +  - non-removable: non-removable slot (like eMMC); assume always present.
> +
>  Optional properties:
> -- cd-gpios: Specify GPIOs for card detection, see gpio binding
>  - wp-gpios: Specify GPIOs for write protection, see gpio binding
>  - cd-inverted: when present, polarity on the cd gpio line is inverted
>  - wp-inverted: when present, polarity on the wp gpio line is inverted
> -- non-removable: non-removable slot (like eMMC)
>  - max-frequency: maximum operating clock frequency
>  
>  Example:
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

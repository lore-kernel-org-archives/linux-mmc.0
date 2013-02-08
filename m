From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] mmc: dt: bus-width can be an optional property
Date: Fri, 08 Feb 2013 23:02:58 +0000
Message-ID: <20130208230259.05F933E2C27@localhost>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org> <1358766149-9534-7-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51381 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947094Ab3BHXDD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Feb 2013 18:03:03 -0500
Received: by mail-wg0-f54.google.com with SMTP id fm10so3255876wgb.33
        for <linux-mmc@vger.kernel.org>; Fri, 08 Feb 2013 15:03:02 -0800 (PST)
In-Reply-To: <1358766149-9534-7-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org

On Mon, 21 Jan 2013 19:02:29 +0800, Shawn Guo <shawn.guo@linaro.org> wrote:
> None of mmc drivers implements bus-width as a required device tree
> property.  Instead, some drivers like atmel-mci, dw_mmc, sdhci-s3c
> implement it as an optional one, and will force bus width to be 1
> when the property is absent.  Let's change the common binding to
> reflect what the drivers are usually doing.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: devicetree-discuss@lists.ozlabs.org

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index a591c67..cef217d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -6,9 +6,6 @@ Interpreted by the OF core:
>  - reg: Registers location and length.
>  - interrupts: Interrupts used by the MMC controller.
>  
> -Required properties:
> -- bus-width: Number of data lines, can be <1>, <4>, or <8>
> -
>  Card detection:
>  If no property below is supplied, standard SDHCI card detect is used.
>  Only one of the properties in this section should be supplied:
> @@ -17,6 +14,8 @@ Only one of the properties in this section should be supplied:
>    - non-removable: non-removable slot (like eMMC); assume always present.
>  
>  Optional properties:
> +- bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
> +  will be <1> if the property is absent.
>  - wp-gpios: Specify GPIOs for write protection, see gpio binding
>  - cd-inverted: when present, polarity on the cd gpio line is inverted
>  - wp-inverted: when present, polarity on the wp gpio line is inverted
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

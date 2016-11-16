From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCHv2 10/10] Documentation: synopsys-dw-mshc: remove the
 unused properties
Date: Wed, 16 Nov 2016 17:21:04 +0800
Message-ID: <5722392c-78ed-62bf-785a-7f1c467e3313@rock-chips.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-11-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:44307 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752360AbcKPJVP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 04:21:15 -0500
In-Reply-To: <20161115101232.3854-11-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, robh+dt@kernel.org

ÔÚ 2016/11/15 18:12, Jaehoon Chung Ð´µÀ:
> "support-highspeed" was the obsoleted property.
> And "broken-cd" is not synopsys specific property.
> It can be referred to mmc.txt binding Documentation.
>

Ahh, I forgot to remove broken-cd from doc of dwmmc
when removing it from code.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 1279a22..7fd17c3 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -75,11 +75,6 @@ Optional properties:
>  * card-detect-delay: Delay in milli-seconds before detecting card after card
>    insert event. The default value is 0.
>
> -* supports-highspeed (DEPRECATED): Enables support for high speed cards (up to 50MHz)
> -			   (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
> -
> -* broken-cd: as documented in mmc core bindings.
> -
>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>    specified we'll defer probe until we can find this regulator.
>
>


-- 
Best Regards
Shawn Lin


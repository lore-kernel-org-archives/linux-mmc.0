From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC v2 1/2] sdhci: Add device tree property broken-highspeed
Date: Thu, 13 Oct 2016 11:27:23 +0900
Message-ID: <3a259c3a-6b5e-2464-8402-488b13f03730@samsung.com>
References: <1476297656-7019-1-git-send-email-zach.brown@ni.com>
 <CGME20161012184209epcas1p17eb49c81943bd40560d9284a274b127b@epcas1p1.samsung.com>
 <1476297656-7019-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1476297656-7019-2-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>, ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10/13/2016 03:40 AM, Zach Brown wrote:
> Certain board configurations can make highspeed malfuction due to timing
> issues. In these cases a way is needed to force the controller and card
> into standard speed even if they otherwise appear to be capable of
> highspeed.

I'm not sure "broken-hishspeed" property is relevant to only sdhci driver? otherwise on card side..?
Subject looks like only sdhci driver..And your RFC patch should be supported only SDHCI driver.
But your [patch 1/2] can cause the confusing in future..because there are just comment as "controller".

Then developer who refer to mmc.txt will add the property "broken-highspeed".
I'm not sure what is correct way..but to prevent confusing..you mentioned only "sdhci" driver or supporting other controller.

Best Regards,
Jaehoon Chung

> 
> The broken-highspeed property will let the sdhci driver know that
> highspeed will not work.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 8a37782..a2b298c 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -52,6 +52,8 @@ Optional properties:
>  - no-sdio: controller is limited to send sdio cmd during initialization
>  - no-sd: controller is limited to send sd cmd during initialization
>  - no-mmc: controller is limited to send mmc cmd during initialization
> +- broken-highspeed: Highspeed is broken, even if the controller and card
> +  themselves claim they support highspeed.
>  
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> 

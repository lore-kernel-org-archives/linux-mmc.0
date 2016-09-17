From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] Documentation: mmc: sdhci-of-arasan: add
 description of power domain
Date: Sat, 17 Sep 2016 10:49:56 +0200
Message-ID: <CAPDyKFrgdsppLg9RkCsSh4nhjUiJR6D4u+E8qnzfbtNxhwLOmw@mail.gmail.com>
References: <20160917023250.1159-1-xzy.xu@rock-chips.com> <20160917023250.1159-2-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36748 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755262AbcIQIt7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Sep 2016 04:49:59 -0400
Received: by mail-wm0-f49.google.com with SMTP id b187so71815632wme.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Sep 2016 01:49:58 -0700 (PDT)
In-Reply-To: <20160917023250.1159-2-xzy.xu@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, zhangqing <zhangqing@rock-chips.com>

On 17 September 2016 at 04:32, Ziyuan Xu <xzy.xu@rock-chips.com> wrote:
> Add power domain as a optional property for sdhci-of-arasan, which can
> be turned off in the so-called unused condition, such as suspend and
> remove. Aim to lower power requirements.

I assume runtime suspend make sense as well?

Moreover, perhaps you could share a little information here about what
needs to be done at the driver level which controls the mmc IP. More
precisely, what do you need to do at runtime_suspend, suspend,
runtime_resume, and resume?

Kind regards
Uffe

>
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> Changes in v3:
> - fix a typo
> - add Rob's ack-tag
>
> Changes in v2:
> - fix a typo
> - add an example code for power-domain
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 3404afa..eb84d29 100644
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
> +  - power-domains: A phandle and PM domain as specifier defined by bindings
> +    of the power controller specified by phandle.
>
>  Example:
>         sdhci@e0100000 {
> @@ -71,5 +75,6 @@ Example:
>                 phys = <&emmc_phy>;
>                 phy-names = "phy_arasan";
>                 #clock-cells = <0>;
> +               power-domains = <&power RK3399_PD_EMMC>;
>                 status = "disabled";
>         };
> --
> 2.9.2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

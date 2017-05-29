From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH 1/2] Documentation: rockchip-dw-mshc: add
 description for rk3328
Date: Mon, 29 May 2017 16:42:06 +0200
Message-ID: <CAPDyKFr-oAf05ejoLTLeooSZY7QiGKVjSkVm80DAxpJQKSTdxA@mail.gmail.com>
References: <1495586089-215607-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34628 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdE2OmH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2017 10:42:07 -0400
Received: by mail-qk0-f169.google.com with SMTP id d14so9371063qkb.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 May 2017 07:42:07 -0700 (PDT)
In-Reply-To: <1495586089-215607-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 24 May 2017 at 02:34, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Add "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc" for
> dwmmc on rk3328 platform.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Patch2 is for Heiko/arm_soc.

Kind regards
Uffe

> ---
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> index 520d61d..18e33cb 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -15,6 +15,7 @@ Required Properties:
>         - "rockchip,rk3288-dw-mshc": for Rockchip RK3288
>         - "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
>         - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
> +       - "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
>         - "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
>         - "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
>
> --
> 1.9.1
>
>

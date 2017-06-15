From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 2/6] Documentation: rockchip-dw-mshc: add description for rk3228
Date: Thu, 15 Jun 2017 09:51:59 +0200
Message-ID: <2961285.cLXt8uGUMN@diego>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com> <1497510980-23207-3-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:32798 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdFOHwG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Jun 2017 03:52:06 -0400
In-Reply-To: <1497510980-23207-3-git-send-email-frank.wang@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com

Hi Frank,

Am Donnerstag, 15. Juni 2017, 15:16:16 CEST schrieb Frank Wang:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Add "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc" for
> dwmmc on rk322x platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt index
> 520d61d..ce30dff 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -15,6 +15,7 @@ Required Properties:
>  	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
>  	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip
> RV1108 - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip
> RK3036 +	- "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for
> Rockchip RK322X - "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for
> Rockchip RK3368 - "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for
> Rockchip RK3399

you might want to rebase this patch on top of Ulfs next branch [0],
as there is also the support for the rk3328 in there now.

Otherwise looks good to me, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>



[0] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/log/?h=next


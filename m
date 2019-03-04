From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] ls1021aqds: enable esdhc controller
Date: Mon, 4 Mar 2019 09:21:33 +0800
Message-ID: <20190304012131.GS26041@dragon>
References: <20190226084121.41499-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226084121.41499-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Y.b. Lu" <yangbo.lu@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 26, 2019 at 08:40:22AM +0000, Yinbo Zhu wrote:
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
> 
> This patch is to enable esdhc controller in ls1021aqds
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Changed the subject prefix to 'ARM: dts: ls1021a-qds: ...' and applied
the patch.

Shawn

> ---
> Change in v2:
> 		Add patch code after &enet2 to keep them sort alphabetically.
> 
>  arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index dac61e7..ae26f8b 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -160,6 +160,10 @@
>  	status = "okay";
>  };
>  
> +&esdhc {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

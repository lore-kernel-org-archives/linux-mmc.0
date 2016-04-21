From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new clocking
 model
Date: Thu, 21 Apr 2016 18:08:16 -0500
Message-ID: <1461280096.32510.213.camel@buserror.net>
References: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from host.buserror.net ([209.198.135.123]:48454 "EHLO
	host.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbcDUXIW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 19:08:22 -0400
In-Reply-To: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, scott.wood@nxp.com

On Wed, 2016-04-20 at 18:20 +0800, Yangbo Lu wrote:
> Provide clocks property instead of clock-frequency for QorIQ eSDHC
> dts node to adapt to the new clocking model, so that the driver
> could get clock value by the common clk API and the u-boot could
> remove the clock fixup.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> index 20835ae..ddbe562 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
> @@ -36,5 +36,5 @@ sdhc: sdhc@114000 {
>  	compatible = "fsl,esdhc";
>  	reg = <0x114000 0x1000>;
>  	interrupts = <48 2 0 0>;
> -	clock-frequency = <0>;
> +	clocks = <&clockgen 4 1>;
>  };

Binding update?

-Scott


From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/4] arm: at91: dt: sam9x5 add mci support
Date: Thu, 22 Mar 2012 15:52:13 +0100
Message-ID: <4F6B3C9D.60300@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com> <1332352994-20983-4-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:25291 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab2CVOwW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 10:52:22 -0400
In-Reply-To: <1332352994-20983-4-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>

On 03/21/2012 07:03 PM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91sam9x5.dtsi |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index c111001..5846f99 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -191,6 +191,20 @@
>  				interrupts = <27 4>;
>  				status = "disabled";
>  			};
> +
> +			mmc0: mmc@f0008000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xf0008000 0x600>;
> +				interrupts = <12 4>;
> +				status = "disabled";
> +			};
> +
> +			mmc1: mmc@f000c000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xf000c000 0x600>;
> +				interrupts = <26 4>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		nand0: nand@40000000 {


-- 
Nicolas Ferre

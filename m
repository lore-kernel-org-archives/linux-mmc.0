From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] at91: mmc: fix missing pinctrl in dt
Date: Thu, 19 Sep 2013 15:21:12 +0200
Message-ID: <523AFA48.80606@atmel.com>
References: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz> <1379411857-18516-2-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:50339 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab3ISNVT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2013 09:21:19 -0400
In-Reply-To: <1379411857-18516-2-git-send-email-jiri.prchal@aksignal.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-mmc@vger.kernel.org, ludovic.desroches@atmel.com, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On 17/09/2013 11:57, Jiri Prchal :
> This patch adds pinctrl to soc dtsi file.
>
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>


Jiri,

I will rework your patch by splitting the two lines. This will allow us 
to be consistent with other AT91 SoC/boards Device Tree descriptions.

+		pinctrl-names = "default";

This one is going in the SoC file, like you did.

+		pinctrl-0 = <&pinctrl_mmc0_slot0_clk_cmd_dat0>;

This one is under the responsibility of the board itself. The reason 
behind this is that the dat0 line can be multiplexed on another pin.

So, if you need a particular pinctrl configuration on the board side, 
please send another patch for this addition.

Thanks bye,


> ---
>   arch/arm/boot/dts/at91sam9x5.dtsi |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index cf78ac0..c5d26b0 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -556,6 +556,8 @@
>   				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
>   				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
>   				dma-names = "rxtx";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_mmc0_slot0_clk_cmd_dat0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   				status = "disabled";
>


-- 
Nicolas Ferre

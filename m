From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Documentation: dt: update ti,am33xx-hsmmc swakeup
 workaround
Date: Tue, 7 Jul 2015 23:33:39 -0700
Message-ID: <20150708063339.GH10644@atomide.com>
References: <1436291591-31271-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33746 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbbGHGdn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Jul 2015 02:33:43 -0400
Content-Disposition: inline
In-Reply-To: <1436291591-31271-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

* Andreas Fenkart <afenkart@gmail.com> [150707 10:55]:
> Before 5b83b2234be6733cf the driver was hard coding the wakeup irq to
> be active low. The generic pm wakeirq does not override the active
> high/low parameter, hence it must be specified correctly in the
> device tree.
> Mind that SDIO IRQ is active low as defined in the SDIO specification
> 
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 76bf087..74166a0 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -102,7 +102,7 @@ not every application needs SDIO irq, e.g. MMC cards.
>  		pinctrl-1 = <&mmc1_idle>;
>  		pinctrl-2 = <&mmc1_sleep>;
>  		...
> -		interrupts-extended = <&intc 64 &gpio2 28 0>;
> +		interrupts-extended = <&intc 64 &gpio2 28 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	mmc1_idle : pinmux_cirq_pin {

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>

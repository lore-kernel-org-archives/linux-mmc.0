From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Documentation: dt: update ti,am33xx-hsmmc swakeup workaround
Date: Tue, 21 Jul 2015 13:11:50 +0200
Message-ID: <CAPDyKFqhcGgR3DW2u5mWMNe=0gu-BJYY+F_4wJMjW-P3EzHyKg@mail.gmail.com>
References: <1436291591-31271-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36315 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbbGULLv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 07:11:51 -0400
Received: by qgy5 with SMTP id 5so85606382qgy.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 04:11:50 -0700 (PDT)
In-Reply-To: <1436291591-31271-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 7 July 2015 at 19:53, Andreas Fenkart <afenkart@gmail.com> wrote:
> Before 5b83b2234be6733cf the driver was hard coding the wakeup irq to
> be active low. The generic pm wakeirq does not override the active
> high/low parameter, hence it must be specified correctly in the
> device tree.
> Mind that SDIO IRQ is active low as defined in the SDIO specification
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 76bf087..74166a0 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -102,7 +102,7 @@ not every application needs SDIO irq, e.g. MMC cards.
>                 pinctrl-1 = <&mmc1_idle>;
>                 pinctrl-2 = <&mmc1_sleep>;
>                 ...
> -               interrupts-extended = <&intc 64 &gpio2 28 0>;
> +               interrupts-extended = <&intc 64 &gpio2 28 GPIO_ACTIVE_LOW>;
>         };
>
>         mmc1_idle : pinmux_cirq_pin {
> --
> 2.1.4
>

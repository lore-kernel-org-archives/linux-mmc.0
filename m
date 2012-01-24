From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/31] ARM: amba: realview: get rid of private platform
	amba_device initializer
Date: Tue, 24 Jan 2012 21:45:31 +0000
Message-ID: <20120124214531.GB8517@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk> <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk> <20120124160044.GM19798@mudshark.cambridge.arm.com> <20120124162328.GA8517@n2100.arm.linux.org.uk> <20120124172600.GO19798@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50949 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab2AXVqH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 16:46:07 -0500
Content-Disposition: inline
In-Reply-To: <20120124172600.GO19798@mudshark.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>

On Tue, Jan 24, 2012 at 05:26:00PM +0000, Will Deacon wrote:
> Right. I took a quick look at the TRM for the PB1176, and I think we do have
> an interrupt for GPIO0, it's just on the other GIC. This patch should do the
> trick, but I'm not sure what I can do to tickle the GPIO stuff anyway:
> 
> 
> diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
> index 5c3c625..708f841 100644
> --- a/arch/arm/mach-realview/include/mach/irqs-pb1176.h
> +++ b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
> @@ -40,6 +40,7 @@
>  #define IRQ_DC1176_L2CC                (IRQ_DC1176_GIC_START + 13)
>  #define IRQ_DC1176_RTC         (IRQ_DC1176_GIC_START + 14)
>  #define IRQ_DC1176_CLCD                (IRQ_DC1176_GIC_START + 15)     /* CLCD controller */
> +#define IRQ_DC1176_GPIO0       (IRQ_DC1176_GIC_START + 16)
>  #define IRQ_DC1176_SSP         (IRQ_DC1176_GIC_START + 17)     /* SSP port */
>  #define IRQ_DC1176_UART0       (IRQ_DC1176_GIC_START + 18)     /* UART 0 on development chip */
>  #define IRQ_DC1176_UART1       (IRQ_DC1176_GIC_START + 19)     /* UART 1 on development chip */
> @@ -73,7 +74,6 @@
>  #define IRQ_PB1176_DMAC                (IRQ_PB1176_GIC_START + 24)     /* DMA controller */
>  #define IRQ_PB1176_RTC         (IRQ_PB1176_GIC_START + 25)     /* Real Time Clock */
>  
> -#define IRQ_PB1176_GPIO0       -1
>  #define IRQ_PB1176_SCTL                -1
>  
>  #define NR_GIC_PB1176          2
> diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
> index 1b6e60c..b1d7caf 100644
> --- a/arch/arm/mach-realview/realview_pb1176.c
> +++ b/arch/arm/mach-realview/realview_pb1176.c
> @@ -143,7 +143,7 @@ static struct pl022_ssp_controller ssp0_plat_data = {
>  #define PB1176_CLCD_IRQ        { IRQ_DC1176_CLCD }
>  #define SCTL_IRQ       { }
>  #define PB1176_WATCHDOG_IRQ    { IRQ_DC1176_WATCHDOG }
> -#define PB1176_GPIO0_IRQ       { IRQ_PB1176_GPIO0 }
> +#define PB1176_GPIO0_IRQ       { IRQ_DC1176_GPIO0 }
>  #define GPIO1_IRQ      { IRQ_PB1176_GPIO1 }
>  #define PB1176_RTC_IRQ { IRQ_DC1176_RTC }
>  #define SCI_IRQ                { IRQ_PB1176_SCI }

I guess we should believe the TRM on this - can you put this in the patch
system please?

Thanks.

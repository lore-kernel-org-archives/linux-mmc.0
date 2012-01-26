From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/31] ARM: amba: realview: get rid of private platform
	amba_device initializer
Date: Thu, 26 Jan 2012 17:25:27 +0000
Message-ID: <20120126172527.GA12731@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk> <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk> <20120124160044.GM19798@mudshark.cambridge.arm.com> <20120124162328.GA8517@n2100.arm.linux.org.uk> <20120124172600.GO19798@mudshark.cambridge.arm.com> <20120124214531.GB8517@n2100.arm.linux.org.uk> <20120125095800.GC21709@mudshark.cambridge.arm.com> <20120125102202.GU16726@n2100.arm.linux.org.uk> <20120125103906.GE21709@mudshark.cambridge.arm.com> <20120125110647.GV16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120125110647.GV16726@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 25, 2012 at 11:06:47AM +0000, Russell King - ARM Linux wrote:
> Right, so with the stack of amba patches on top, it looks like this,
> which to me looks sane.  I haven't build-tested it though.

Will,

Did you see this?  Any comment?

Thanks.

> 
> diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
> index 5c3c625..708f841 100644
> --- a/arch/arm/mach-realview/include/mach/irqs-pb1176.h
> +++ b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
> @@ -40,6 +40,7 @@
>  #define IRQ_DC1176_L2CC		(IRQ_DC1176_GIC_START + 13)
>  #define IRQ_DC1176_RTC		(IRQ_DC1176_GIC_START + 14)
>  #define IRQ_DC1176_CLCD		(IRQ_DC1176_GIC_START + 15)	/* CLCD controller */
> +#define IRQ_DC1176_GPIO0	(IRQ_DC1176_GIC_START + 16)
>  #define IRQ_DC1176_SSP		(IRQ_DC1176_GIC_START + 17)	/* SSP port */
>  #define IRQ_DC1176_UART0	(IRQ_DC1176_GIC_START + 18)	/* UART 0 on development chip */
>  #define IRQ_DC1176_UART1	(IRQ_DC1176_GIC_START + 19)	/* UART 1 on development chip */
> @@ -73,7 +74,6 @@
>  #define IRQ_PB1176_DMAC		(IRQ_PB1176_GIC_START + 24)	/* DMA controller */
>  #define IRQ_PB1176_RTC		(IRQ_PB1176_GIC_START + 25)	/* Real Time Clock */
>  
> -#define IRQ_PB1176_GPIO0	-1
>  #define IRQ_PB1176_SCTL		-1
>  
>  #define NR_GIC_PB1176		2
> diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
> index 1b6e60c..b1d7caf 100644
> --- a/arch/arm/mach-realview/realview_pb1176.c
> +++ b/arch/arm/mach-realview/realview_pb1176.c
> @@ -143,7 +143,7 @@ static struct pl022_ssp_controller ssp0_plat_data = {
>  #define PB1176_CLCD_IRQ	{ IRQ_DC1176_CLCD }
>  #define SCTL_IRQ	{ }
>  #define PB1176_WATCHDOG_IRQ	{ IRQ_DC1176_WATCHDOG }
> -#define PB1176_GPIO0_IRQ	{ IRQ_PB1176_GPIO0 }
> +#define PB1176_GPIO0_IRQ	{ IRQ_DC1176_GPIO0 }
>  #define GPIO1_IRQ	{ IRQ_PB1176_GPIO1 }
>  #define PB1176_RTC_IRQ	{ IRQ_DC1176_RTC }
>  #define SCI_IRQ		{ IRQ_PB1176_SCI }
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

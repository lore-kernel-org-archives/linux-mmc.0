From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
Date: Tue, 24 Jan 2012 17:26:00 +0000
Message-ID: <20120124172600.GO19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
 <20120124160044.GM19798@mudshark.cambridge.arm.com>
 <20120124162328.GA8517@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120124162328.GA8517@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 24, 2012 at 04:23:28PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 24, 2012 at 04:00:44PM +0000, Will Deacon wrote:
> > but then I see a warning during boot:
> > 
> > [    1.669654] ------------[ cut here ]------------
> > [    1.684021] WARNING: at drivers/amba/bus.c:514 amba_device_add+0x1b4/0x1d0()
> > [    1.705585] Modules linked in:
> > [    1.715195] [<c0013a00>] (unwind_backtrace+0x0/0xfc) from [<c03d1350>] (dump_stack+0x20/0x24)
> > [    1.741288] [<c03d1350>] (dump_stack+0x20/0x24) from [<c001f9b8>] (warn_slowpath_common+0x5c/0x74)
> > [    1.768689] [<c001f9b8>] (warn_slowpath_common+0x5c/0x74) from [<c001f9fc>] (warn_slowpath_null+0x2c/0x34)
> > [    1.798165] [<c001f9fc>] (warn_slowpath_null+0x2c/0x34) from [<c023dcd4>] (amba_device_add+0x1b4/0x1d0)
> > [    1.826857] [<c023dcd4>] (amba_device_add+0x1b4/0x1d0) from [<c023dd84>] (amba_device_register+0x94/0xc4)
> > [    1.856106] [<c023dd84>] (amba_device_register+0x94/0xc4) from [<c0551934>] (realview_pb1176_init+0x74/0xac)
> > [    1.886120] [<c0551934>] (realview_pb1176_init+0x74/0xac) from [<c054d60c>] (customize_machine+0x24/0x30)
> > [    1.915340] [<c054d60c>] (customize_machine+0x24/0x30) from [<c000879c>] (do_one_initcall+0x48/0x1a0)
> > [    1.943505] [<c000879c>] (do_one_initcall+0x48/0x1a0) from [<c054b870>] (kernel_init+0x80/0x128)
> > [    1.970378] [<c054b870>] (kernel_init+0x80/0x128) from [<c000ea78>] (kernel_thread_exit+0x0/0x8)
> > [    1.997192] ---[ end trace 1b75b31a2719ed1e ]---
> > 
> > I suspect that comes from PB1176_GPIO0_IRQ being -1.
> 
> It seems you've also tested the code which detects -1 IRQs too, which
> is good.  PB1176 needs that GPIO0_IRQ fixing, but I suspect passing
> zero may not be entirely a good thing for it as request_irq(0,...)
> probably succeeds there.  I think that needs fixing before this warning
> can go away.

Yup, I actually tested this simply by checking out your devel-3.3 branch, so
the whole series has been tested on the boards that I've mentioned.

> In the mean time, it's just a warning, and its saying there's something
> wrong there which needs fixing but without anything currently broken.
> So it's working as designed.

Right. I took a quick look at the TRM for the PB1176, and I think we do have
an interrupt for GPIO0, it's just on the other GIC. This patch should do the
trick, but I'm not sure what I can do to tickle the GPIO stuff anyway:


diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
index 5c3c625..708f841 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
@@ -40,6 +40,7 @@
 #define IRQ_DC1176_L2CC                (IRQ_DC1176_GIC_START + 13)
 #define IRQ_DC1176_RTC         (IRQ_DC1176_GIC_START + 14)
 #define IRQ_DC1176_CLCD                (IRQ_DC1176_GIC_START + 15)     /* CLCD controller */
+#define IRQ_DC1176_GPIO0       (IRQ_DC1176_GIC_START + 16)
 #define IRQ_DC1176_SSP         (IRQ_DC1176_GIC_START + 17)     /* SSP port */
 #define IRQ_DC1176_UART0       (IRQ_DC1176_GIC_START + 18)     /* UART 0 on development chip */
 #define IRQ_DC1176_UART1       (IRQ_DC1176_GIC_START + 19)     /* UART 1 on development chip */
@@ -73,7 +74,6 @@
 #define IRQ_PB1176_DMAC                (IRQ_PB1176_GIC_START + 24)     /* DMA controller */
 #define IRQ_PB1176_RTC         (IRQ_PB1176_GIC_START + 25)     /* Real Time Clock */
 
-#define IRQ_PB1176_GPIO0       -1
 #define IRQ_PB1176_SCTL                -1
 
 #define NR_GIC_PB1176          2
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 1b6e60c..b1d7caf 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -143,7 +143,7 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define PB1176_CLCD_IRQ        { IRQ_DC1176_CLCD }
 #define SCTL_IRQ       { }
 #define PB1176_WATCHDOG_IRQ    { IRQ_DC1176_WATCHDOG }
-#define PB1176_GPIO0_IRQ       { IRQ_PB1176_GPIO0 }
+#define PB1176_GPIO0_IRQ       { IRQ_DC1176_GPIO0 }
 #define GPIO1_IRQ      { IRQ_PB1176_GPIO1 }
 #define PB1176_RTC_IRQ { IRQ_DC1176_RTC }
 #define SCI_IRQ                { IRQ_PB1176_SCI }


Will

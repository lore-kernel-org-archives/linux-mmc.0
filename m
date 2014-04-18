From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 resend 1/3] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Fri, 18 Apr 2014 09:46:30 -0700
Message-ID: <20140418164630.GE5354@atomide.com>
References: <1395404448-30030-1-git-send-email-afenkart@gmail.com>
 <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <532C6489.4050307@ti.com>
 <532FFB43.5020408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <532FFB43.5020408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Balaji T K <balajitk@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Sorry for the delay, just noticed this one.

* Dmitry Lifshitz <lifshitz@compulab.co.il> [140324 02:34]:
> Hi,
> 
> I've tested the branch omap_hsmmc_sdio_irq_devm_cleanup on custom OMAP5
> based board.
> We have mwifiex connected to MMC3.
> 
> I used two approaches:
> 
> * Using dat1 line as GPIO with dynamic remuxing
> * Using separate GPIO connected to dat1 with static mux settings
> 
> Both works just fine. Thanks Andreas for a great solution.
> 
> I have just one issue - how to define GPIO IRQ using DT in OMAP5 case.
> As a temporary hack for testing I used a fixed GPIO number and gpio_to_irq()
> call in omap_hsmmc_configure_wake_irq().
> 
> OMAP5 MMC3 has the following DT entry (omap5.dtsi):
> 
>                 mmc3: mmc@480ad000 {
>                         compatible = "ti,omap4-hsmmc";
>                         reg = <0x480ad000 0x400>;
>                         interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "mmc3";
>                         ti,needs-special-reset;
>                         dmas = <&sdma 77>, <&sdma 78>;
>                         dma-names = "tx", "rx";
>                 };
> 
> What should be by board MMC3 setup?

You need to use the interrupts-extended property in omap5.dtsi
for the MMC interrupt. And if using the wake-up interrupts
for your board, you need to sepcify interrupts-extended in your
board file again to add the second wake-up interrupt.

If using the async wake-up path, the wake-up interrupt is the
OMAP5_CORE_IOPAD() or OMAP5_WKUP_IOPAD() pinctrl register offset
for that pin. If remuxing to GPIO for the wake-up, the wake-up
interrupt is the standard gpio interrupt property.

Then you also need this patch to avoid warnings during boot:

http://lkml.org/lkml/2014/4/10/620

After the above gets merged, we can apply the serial wake-up
patch too:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/213873.html

That shows you some examples on how to specify the wake-up
interrupt.

Regards,

Tony

From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 1/6] arm: davinci: Fix low level gpio irq handlers'
 argument
Date: Mon, 11 Jul 2011 17:28:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
 <1310303679-17936-2-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51044 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756841Ab1GKMti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2011 08:49:38 -0400
In-Reply-To: <1310303679-17936-2-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>
Cc: Thomas Gleixner <tglx@linutronix.de>

Hi Ido,

On Sun, Jul 10, 2011 at 18:44:34, Ido Yariv wrote:
> Commit 7416401 ("arm: davinci: Fix fallout from generic irq chip
> conversion") introduced a bug, causing low level interrupt handlers to
> get a bogus irq number as an argument. The gpio irq handler falsely
> assumes that the handler data is the irq base number and that is no
> longer true.
> 
> Fix this by converting gpio_irq_handler's bank_irq argument to the
> corresponding irq base number.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/mach-davinci/gpio.c |   32 ++++++++++++++++++++++++++++----
>  1 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
> index e722139..ff43e2a 100644
> --- a/arch/arm/mach-davinci/gpio.c
> +++ b/arch/arm/mach-davinci/gpio.c
> @@ -249,16 +249,40 @@ static struct irq_chip gpio_irqchip = {
>  	.flags		= IRQCHIP_SET_TYPE_MASKED,
>  };
>  
> +static inline int bankirq_to_irqbase(unsigned int bank_irq)
> +{
> +	int gpio;
> +	int index;
> +
> +	/* Each irq bank consists of up to 16 irqs */
> +	gpio = 16 * (bank_irq - davinci_soc_info.gpio_irq);
> +
> +	/* Each controller controls 32 GPIOs */
> +	index = gpio / 32;
> +
> +	if (unlikely(!davinci_soc_info.gpio_ctlrs))
> +		return -EINVAL;
> +
> +	if (unlikely(index >= davinci_soc_info.gpio_ctlrs_num))
> +		return -EINVAL;
> +
> +	return davinci_soc_info.gpio_ctlrs[index].irq_base;
> +}
> +
>  static void
> -gpio_irq_handler(unsigned irq, struct irq_desc *desc)
> +gpio_irq_handler(unsigned bank_irq, struct irq_desc *desc)
>  {
>  	struct davinci_gpio_regs __iomem *g;
>  	u32 mask = 0xffff;
> +	int irqbase = bankirq_to_irqbase(bank_irq);
> +
> +	if (unlikely(irqbase < 0))
> +		return;
>  
>  	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
>  
>  	/* we only care about one bank */
> -	if (irq & 1)
> +	if (bank_irq & 1)
>  		mask <<= 16;
>  
>  	/* temporarily mask (level sensitive) parent IRQ */
> @@ -274,11 +298,11 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>  		if (!status)
>  			break;
>  		__raw_writel(status, &g->intstat);
> -		if (irq & 1)
> +		if (bank_irq & 1)
>  			status >>= 16;
>  
>  		/* now demux them to the right lowlevel handler */
> -		n = (int)irq_get_handler_data(irq);
> +		n = irqbase;
>  		while (status) {
>  			res = ffs(status);
>  			n += res;

Thanks for the bug fix.

How about setting the handler data for bank IRQ in
davinci_gpio_irq_setup() to &chips[bank]?

chips[bank].regs should give you the register base address
(g) and chips[bank].irq_base should give you 'n'.

Also please drop the rename of irq to bank_irq as it is not
central to the bug fix.

If you spin in soon enough, we may make it to v3.0

Thanks,
Sekhar

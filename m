From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3 1/6] arm: davinci: Fix low level gpio irq handlers'
 argument
Date: Tue, 12 Jul 2011 14:52:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DA7AEF2@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
 <1310418191-27009-1-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60338 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab1GLJWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 05:22:35 -0400
In-Reply-To: <1310418191-27009-1-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>
Cc: Thomas Gleixner <tglx@linutronix.de>

Hi Ido,

On Tue, Jul 12, 2011 at 02:33:11, Ido Yariv wrote:
> Commit 7416401 ("arm: davinci: Fix fallout from generic irq chip
> conversion") introduced a bug, causing low level interrupt handlers to
> get a bogus irq number as an argument. The gpio irq handler falsely
> assumes that the handler data is the irq base number and that is no
> longer true.
> 
> Set the irq handler data to be a pointer to the corresponding gpio
> controller. The chained irq handler can then use it to extract both the
> irq base number and the gpio registers structure.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/mach-davinci/gpio.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
> index e722139..7d64a07 100644
> --- a/arch/arm/mach-davinci/gpio.c
> +++ b/arch/arm/mach-davinci/gpio.c
> @@ -254,8 +254,10 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>  {
>  	struct davinci_gpio_regs __iomem *g;
>  	u32 mask = 0xffff;
> +	struct davinci_gpio_controller *ctl;

Lets call the variable "d" to be consistent with the rest of the file.

>  
> -	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
> +	ctl = (struct davinci_gpio_controller *)irq_desc_get_handler_data(desc);
> +	g = (struct davinci_gpio_regs __iomem *)ctl->regs;
>  
>  	/* we only care about one bank */
>  	if (irq & 1)
> @@ -278,7 +280,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>  			status >>= 16;
>  
>  		/* now demux them to the right lowlevel handler */
> -		n = (int)irq_get_handler_data(irq);
> +		n = ctl->irq_base;

I realized that this breaks for odd banks as the status is
right shifted by 16. The GPIO you are using must have been
in even bank?

>  		while (status) {
>  			res = ffs(status);
>  			n += res;
> @@ -424,7 +426,13 @@ static int __init davinci_gpio_irq_setup(void)
>  
>  		/* set up all irqs in this bank */
>  		irq_set_chained_handler(bank_irq, gpio_irq_handler);
> -		irq_set_handler_data(bank_irq, (__force void *)g);
> +
> +		/*
> +		 * Each chip handles 32 gpios, and each irq bank consists of 16
> +		 * gpio irqs. Pass the irq bank's corresponding controller to
> +		 * the chained irq handler.
> +		 */
> +		irq_set_handler_data(bank_irq, &chips[bank * 16 / 32]);

This can simply be:

		irq_set_handler_data(bank_irq, &chips[gpio / 32]);

In the interest of time, I did these fixes and pushed the
patch to "fixes" branch of git://gitorious.org/linux-davinci/linux-davinci.git

Can you please test it out and let me know if it works.

Updated patch also attached.

Thanks,
Sekhar

8<---------------------
From: Ido Yariv <ido@wizery.com>
Subject: arm: davinci: Fix low level gpio irq handlers' argument

Commit 7416401 ("arm: davinci: Fix fallout from generic irq chip
conversion") introduced a bug, causing low level interrupt handlers to
get a bogus irq number as an argument. The gpio irq handler falsely
assumes that the handler data is the irq base number and that is no
longer true.

Set the irq handler data to be a pointer to the corresponding gpio
controller. The chained irq handler can then use it to extract both the
irq base number and the gpio registers structure.

Signed-off-by: Ido Yariv <ido@wizery.com>
CC: Thomas Gleixner <tglx@linutronix.de>
[nsekhar@ti.com: renamed "ctl" to "d", simplified indexing logic for chips and
took care of odd bank handling in irq handler]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/gpio.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index e722139..cafbe13 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -254,8 +254,10 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
+	struct davinci_gpio_controller *d;
 
-	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
+	d = (struct davinci_gpio_controller *)irq_desc_get_handler_data(desc);
+	g = (struct davinci_gpio_regs __iomem *)d->regs;
 
 	/* we only care about one bank */
 	if (irq & 1)
@@ -274,11 +276,14 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		if (!status)
 			break;
 		__raw_writel(status, &g->intstat);
-		if (irq & 1)
-			status >>= 16;
 
 		/* now demux them to the right lowlevel handler */
-		n = (int)irq_get_handler_data(irq);
+		n = d->irq_base;
+		if (irq & 1) {
+			n += 16;
+			status >>= 16;
+		}
+
 		while (status) {
 			res = ffs(status);
 			n += res;
@@ -424,7 +429,13 @@ static int __init davinci_gpio_irq_setup(void)
 
 		/* set up all irqs in this bank */
 		irq_set_chained_handler(bank_irq, gpio_irq_handler);
-		irq_set_handler_data(bank_irq, (__force void *)g);
+
+		/*
+		 * Each chip handles 32 gpios, and each irq bank consists of 16
+		 * gpio irqs. Pass the irq bank's corresponding controller to
+		 * the chained irq handler.
+		 */
+		irq_set_handler_data(bank_irq, &chips[gpio / 32]);
 
 		for (i = 0; i < 16 && gpio < ngpio; i++, irq++, gpio++) {
 			irq_set_chip(irq, &gpio_irqchip);


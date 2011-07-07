From: Ido Yariv <ido@wizery.com>
Subject: [PATCH 1/5] arm: davinci: Fix low level gpio irq handlers' argument
Date: Fri,  8 Jul 2011 00:33:06 +0300
Message-ID: <1310074390-4277-2-git-send-email-ido@wizery.com>
References: <1310074390-4277-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab1GGVdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 17:33:25 -0400
Received: by wwe5 with SMTP id 5so1362105wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 14:33:24 -0700 (PDT)
In-Reply-To: <1310074390-4277-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>, Thomas Gleixner <tglx@linutronix.de>

Commit 7416401 ("arm: davinci: Fix fallout from generic irq chip
conversion") introduced a bug, causing low level interrupt handlers to
get a bogus irq number as an argument. The gpio irq handler falsely
assumes that the handler data is the irq base number and that is no
longer true.

Fix this by converting gpio_irq_handler's bank_irq argument to the
corresponding irq base number.

Signed-off-by: Ido Yariv <ido@wizery.com>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-davinci/gpio.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index e722139..db6355a 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -249,8 +249,16 @@ static struct irq_chip gpio_irqchip = {
 	.flags		= IRQCHIP_SET_TYPE_MASKED,
 };
 
+static unsigned int first_irq_in_bankirq(unsigned int bank_irq)
+{
+	struct davinci_soc_info *soc_info = &davinci_soc_info;
+
+	/* Each irq bank consists of up to 16 irqs */
+	return gpio_to_irq(0) + (16 * (bank_irq - soc_info->gpio_irq));
+}
+
 static void
-gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+gpio_irq_handler(unsigned bank_irq, struct irq_desc *desc)
 {
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
@@ -258,7 +266,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
 
 	/* we only care about one bank */
-	if (irq & 1)
+	if (bank_irq & 1)
 		mask <<= 16;
 
 	/* temporarily mask (level sensitive) parent IRQ */
@@ -274,11 +282,11 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		if (!status)
 			break;
 		__raw_writel(status, &g->intstat);
-		if (irq & 1)
+		if (bank_irq & 1)
 			status >>= 16;
 
 		/* now demux them to the right lowlevel handler */
-		n = (int)irq_get_handler_data(irq);
+		n = first_irq_in_bankirq(bank_irq);
 		while (status) {
 			res = ffs(status);
 			n += res;
-- 
1.7.4.1


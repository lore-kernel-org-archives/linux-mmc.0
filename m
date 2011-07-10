From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 1/6] arm: davinci: Fix low level gpio irq handlers' argument
Date: Sun, 10 Jul 2011 16:14:34 +0300
Message-ID: <1310303679-17936-2-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62339 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1GJNOx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:14:53 -0400
Received: by wyg8 with SMTP id 8so2098815wyg.19
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:14:52 -0700 (PDT)
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
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
 arch/arm/mach-davinci/gpio.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index e722139..ff43e2a 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -249,16 +249,40 @@ static struct irq_chip gpio_irqchip = {
 	.flags		= IRQCHIP_SET_TYPE_MASKED,
 };
 
+static inline int bankirq_to_irqbase(unsigned int bank_irq)
+{
+	int gpio;
+	int index;
+
+	/* Each irq bank consists of up to 16 irqs */
+	gpio = 16 * (bank_irq - davinci_soc_info.gpio_irq);
+
+	/* Each controller controls 32 GPIOs */
+	index = gpio / 32;
+
+	if (unlikely(!davinci_soc_info.gpio_ctlrs))
+		return -EINVAL;
+
+	if (unlikely(index >= davinci_soc_info.gpio_ctlrs_num))
+		return -EINVAL;
+
+	return davinci_soc_info.gpio_ctlrs[index].irq_base;
+}
+
 static void
-gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+gpio_irq_handler(unsigned bank_irq, struct irq_desc *desc)
 {
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
+	int irqbase = bankirq_to_irqbase(bank_irq);
+
+	if (unlikely(irqbase < 0))
+		return;
 
 	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
 
 	/* we only care about one bank */
-	if (irq & 1)
+	if (bank_irq & 1)
 		mask <<= 16;
 
 	/* temporarily mask (level sensitive) parent IRQ */
@@ -274,11 +298,11 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		if (!status)
 			break;
 		__raw_writel(status, &g->intstat);
-		if (irq & 1)
+		if (bank_irq & 1)
 			status >>= 16;
 
 		/* now demux them to the right lowlevel handler */
-		n = (int)irq_get_handler_data(irq);
+		n = irqbase;
 		while (status) {
 			res = ffs(status);
 			n += res;
-- 
1.7.4.1


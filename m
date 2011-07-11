From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v3 1/6] arm: davinci: Fix low level gpio irq handlers' argument
Date: Tue, 12 Jul 2011 00:03:11 +0300
Message-ID: <1310418191-27009-1-git-send-email-ido@wizery.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38572 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab1GKVDz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2011 17:03:55 -0400
Received: by wyg8 with SMTP id 8so2857246wyg.19
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 14:03:54 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>, Thomas Gleixner <tglx@linutronix.de>

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
---
 arch/arm/mach-davinci/gpio.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index e722139..7d64a07 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -254,8 +254,10 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
+	struct davinci_gpio_controller *ctl;
 
-	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
+	ctl = (struct davinci_gpio_controller *)irq_desc_get_handler_data(desc);
+	g = (struct davinci_gpio_regs __iomem *)ctl->regs;
 
 	/* we only care about one bank */
 	if (irq & 1)
@@ -278,7 +280,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			status >>= 16;
 
 		/* now demux them to the right lowlevel handler */
-		n = (int)irq_get_handler_data(irq);
+		n = ctl->irq_base;
 		while (status) {
 			res = ffs(status);
 			n += res;
@@ -424,7 +426,13 @@ static int __init davinci_gpio_irq_setup(void)
 
 		/* set up all irqs in this bank */
 		irq_set_chained_handler(bank_irq, gpio_irq_handler);
-		irq_set_handler_data(bank_irq, (__force void *)g);
+
+		/*
+		 * Each chip handles 32 gpios, and each irq bank consists of 16
+		 * gpio irqs. Pass the irq bank's corresponding controller to
+		 * the chained irq handler.
+		 */
+		irq_set_handler_data(bank_irq, &chips[bank * 16 / 32]);
 
 		for (i = 0; i < 16 && gpio < ngpio; i++, irq++, gpio++) {
 			irq_set_chip(irq, &gpio_irqchip);
-- 
1.7.4.1


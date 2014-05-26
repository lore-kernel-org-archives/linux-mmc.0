From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/11] pinctrl: sunxi: Properly handle level
 triggered gpio interrupts
Date: Mon, 26 May 2014 09:47:59 +0200
Message-ID: <1401090486-4414-5-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBTHDROOAKGQESMQGSTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401090486-4414-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

For level triggered gpio interrupts we need to use handle_fasteoi_irq,
like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
interrupt handlers a chance to actuall clear the source of the interrupt
(which may involve sleeping waitnig for i2c / spi / mmc transfers), before
acknowledging the interrupt.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 71 +++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index d1675c9..083691e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -31,6 +31,12 @@
 #include "../core.h"
 #include "pinctrl-sunxi.h"
 
+static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type);
+static void sunxi_pinctrl_irq_mask_ack(struct irq_data *d);
+static void sunxi_pinctrl_irq_mask(struct irq_data *d);
+static void sunxi_pinctrl_irq_unmask(struct irq_data *d);
+static void sunxi_pinctrl_irq_ack(struct irq_data *d);
+
 static struct sunxi_pinctrl_group *
 sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
 {
@@ -535,11 +541,31 @@ static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return irq_find_mapping(pctl->domain, desc->irqnum);
 }
 
+static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
+	.irq_mask	= sunxi_pinctrl_irq_mask,
+	.irq_mask_ack	= sunxi_pinctrl_irq_mask_ack,
+	.irq_unmask	= sunxi_pinctrl_irq_unmask,
+	.irq_ack	= sunxi_pinctrl_irq_ack,
+	.irq_set_type	= sunxi_pinctrl_irq_set_type,
+	.name		= "sunxi-pio",
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static struct irq_chip sunxi_pinctrl_level_irq_chip = {
+	.irq_mask	= sunxi_pinctrl_irq_mask,
+	.irq_mask_ack	= sunxi_pinctrl_irq_mask_ack,
+	.irq_unmask	= sunxi_pinctrl_irq_unmask,
+	.irq_eoi	= sunxi_pinctrl_irq_ack,
+	.irq_set_type	= sunxi_pinctrl_irq_set_type,
+	.name		= "sunxi-pio",
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED |
+			  IRQCHIP_EOI_IF_HANDLED,
+};
 
-static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
-				      unsigned int type)
+static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
 	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
 	struct sunxi_desc_function *func;
@@ -567,6 +593,14 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 		return -EINVAL;
 	}
 
+	if (type & IRQ_TYPE_LEVEL_MASK) {
+		d->chip = &sunxi_pinctrl_level_irq_chip;
+		desc->handle_irq = handle_fasteoi_irq;
+	} else {
+		d->chip = &sunxi_pinctrl_edge_irq_chip;
+		desc->handle_irq = handle_edge_irq;
+	}
+
 	spin_lock_irqsave(&pctl->lock, flags);
 
 	regval = readl(pctl->membase + reg);
@@ -640,14 +674,20 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
-static struct irq_chip sunxi_pinctrl_irq_chip = {
-	.irq_mask	= sunxi_pinctrl_irq_mask,
-	.irq_mask_ack	= sunxi_pinctrl_irq_mask_ack,
-	.irq_unmask	= sunxi_pinctrl_irq_unmask,
-	.irq_set_type	= sunxi_pinctrl_irq_set_type,
-	.name		= "sunxi-pio",
-	.flags		= IRQCHIP_SKIP_SET_WAKE,
-};
+static void sunxi_pinctrl_irq_ack(struct irq_data *d)
+{
+	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	u32 status_reg = sunxi_irq_status_reg(d->hwirq);
+	u8 status_idx = sunxi_irq_status_offset(d->hwirq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	/* Clear the IRQ */
+	writel(1 << status_idx, pctl->membase + status_reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+}
 
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
@@ -655,9 +695,6 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 	struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
 	const unsigned long reg = readl(pctl->membase + IRQ_STATUS_REG);
 
-	/* Clear all interrupts */
-	writel(reg, pctl->membase + IRQ_STATUS_REG);
-
 	if (reg) {
 		int irqoffset;
 
@@ -892,11 +929,15 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	for (i = 0; i < SUNXI_IRQ_NUMBER; i++) {
 		int irqno = irq_create_mapping(pctl->domain, i);
 
-		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_irq_chip,
-					 handle_simple_irq);
+		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_edge_irq_chip,
+					 handle_edge_irq);
 		irq_set_chip_data(irqno, pctl);
 	};
 
+	/* Mask and clear all IRQs before registering a handler */
+	writel(0, pctl->membase + IRQ_CTRL_REG);
+	writel(0xffffffff, pctl->membase + IRQ_STATUS_REG);
+
 	irq_set_chained_handler(pctl->irq, sunxi_pinctrl_irq_handler);
 	irq_set_handler_data(pctl->irq, pctl);
 
-- 
1.9.3

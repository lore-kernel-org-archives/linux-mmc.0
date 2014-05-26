From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/11] pinctrl: sunxi: Define enable / disable
 irq callbacks for level triggered irqs
Date: Mon, 26 May 2014 09:48:00 +0200
Message-ID: <1401090486-4414-6-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBT7DROOAKGQEIVEOZIA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Some drivers use disable_irq / enable_irq and do the work clearing the source
in another thread instead of using a threaded interrupt handler.

The irqchip used not having irq_disable and irq_enable callbacks in this case,
will lead to unnecessary spurious interrupts:

On a disable_irq in a chip without a handller for this, the irq core will
remember the disable, but not actually call into the irqchip. With a level
triggered interrupt (where the source has not been cleared) this will lead
to an immediate retrigger, at which point the irq-core will mask the irq.
So having an irq_disable callback in the irqchip will save us the interrupt
firing a 2nd time for nothing.

Drivers using disable / enable_irq like this, will call enable_irq when
they finally have cleared the interrupt source, without an enable_irq callback,
this will turn into an unmask, at which point the irq will trigger immediately
because when it was originally acked the level was still high, so the ack was
a nop.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 083691e..66a36cf 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -36,6 +36,7 @@ static void sunxi_pinctrl_irq_mask_ack(struct irq_data *d);
 static void sunxi_pinctrl_irq_mask(struct irq_data *d);
 static void sunxi_pinctrl_irq_unmask(struct irq_data *d);
 static void sunxi_pinctrl_irq_ack(struct irq_data *d);
+static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d);
 
 static struct sunxi_pinctrl_group *
 sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
@@ -556,6 +557,10 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 	.irq_mask_ack	= sunxi_pinctrl_irq_mask_ack,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
 	.irq_eoi	= sunxi_pinctrl_irq_ack,
+	/* Define irq_enable / disable to avoid spurious irqs for drivers
+	 * using these to suppress irqs while they clear the irq source */
+	.irq_enable	= sunxi_pinctrl_irq_ack_unmask,
+	.irq_disable	= sunxi_pinctrl_irq_mask,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
 	.name		= "sunxi-pio",
 	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED |
@@ -689,6 +694,28 @@ static void sunxi_pinctrl_irq_ack(struct irq_data *d)
 	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
+static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d)
+{
+	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	u32 ctrl_reg = sunxi_irq_ctrl_reg(d->hwirq);
+	u8 ctrl_idx = sunxi_irq_ctrl_offset(d->hwirq);
+	u32 status_reg = sunxi_irq_status_reg(d->hwirq);
+	u8 status_idx = sunxi_irq_status_offset(d->hwirq);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	/* Clear the IRQ */
+	writel(1 << status_idx, pctl->membase + status_reg);
+
+	/* Unmask the IRQ */
+	val = readl(pctl->membase + ctrl_reg);
+	writel(val | (1 << ctrl_idx), pctl->membase + ctrl_reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+}
+
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
-- 
1.9.3

From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
Date: Fri, 2 Sep 2011 10:36:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109021027360.2723@ionos>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com> <1312498820-2275-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59315 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419Ab1IBIhD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2011 04:37:03 -0400
In-Reply-To: <1312498820-2275-2-git-send-email-swarren@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, ccross@android.com, olof@lixom.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On Thu, 4 Aug 2011, Stephen Warren wrote:

> Many IRQs are associated with GPIO pins. When the pin is used as an IRQ,
> it can't be used as anything else; it should be requested. Enhance the
> core interrupt code to call gpio_request() and gpio_direction_input() for
> any IRQ that is also a GPIO. This prevents duplication of these calls in
> each driver that uses an IRQ.

This is very much the wrong approach. If you think it through then the
irq setup code might end up with tons of other subsystem specific
setup thingies, e.g. PCI .....

The right thing to do is to add a irq_configure() function pointer to
the irq chip and provide a common function for gpios in gpiolib, which
is then used by the particular GPIO irq chip implementation.

Thanks,

	tglx
---
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5951730..33ba4b8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -265,6 +265,7 @@ static inline void irqd_clr_chained_irq_inprogress(struct irq_data *d)
  * struct irq_chip - hardware interrupt chip descriptor
  *
  * @name:		name for /proc/interrupts
+ * @irq_configure:	configure an interrupt (optional)
  * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
  * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
  * @irq_enable:		enable the interrupt (defaults to chip->unmask if NULL)
@@ -289,9 +290,14 @@ static inline void irqd_clr_chained_irq_inprogress(struct irq_data *d)
  * @flags:		chip specific flags
  *
  * @release:		release function solely used by UML
+ *
+ * If @irq_configure is provided, it's called from setup_irq prior to
+ * enabling the interrupt. irq_configure should return 0 on success or
+ * an appropriate error code.
  */
 struct irq_chip {
 	const char	*name;
+	int		(*irq_configure)(struct irq_data *data);
 	unsigned int	(*irq_startup)(struct irq_data *data);
 	void		(*irq_shutdown)(struct irq_data *data);
 	void		(*irq_enable)(struct irq_data *data);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9b956fa..d5e6a58 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -999,6 +999,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!shared) {
 		init_waitqueue_head(&desc->wait_for_threads);
 
+		/* Configure the interrupt */
+		if (desc->chip->irq_configure) {
+			ret = desc->chip->irq_configure(&desc->irq_data);
+			if (ret)
+				goto out_mask;
+		}
+
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc, irq,


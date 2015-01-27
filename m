From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on both-edges
Date: Tue, 27 Jan 2015 14:15:26 +0800
Message-ID: <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, bin.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Yingjoe Chen <yingjoe.chen@mediatek.com>

MTK EINT does not support generating interrupt on both edges.
Emulate this by changing edge polarity while enable irq,
set types and interrupt handling. This follows an example of
drivers/gpio/gpio-mxc.c.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  3 ++
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  3 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 76 +++++++++++++++++++++++++--
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index b6ee2b2..1296d6d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -325,6 +325,9 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 		.sens      = 0x140,
 		.sens_set  = 0x180,
 		.sens_clr  = 0x1c0,
+		.soft      = 0x200,
+		.soft_set  = 0x240,
+		.soft_clr  = 0x280,
 		.pol       = 0x300,
 		.pol_set   = 0x340,
 		.pol_clr   = 0x380,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index 444d88d..717000e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -278,6 +278,9 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 		.sens      = 0x140,
 		.sens_set  = 0x180,
 		.sens_clr  = 0x1c0,
+		.soft      = 0x200,
+		.soft_set  = 0x240,
+		.soft_clr  = 0x280,
 		.pol       = 0x300,
 		.pol_set   = 0x340,
 		.pol_clr   = 0x380,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 109a882..820ce9e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -792,6 +792,32 @@ static unsigned int mtk_eint_get_mask(struct mtk_pinctrl *pctl,
 	return !!(readl(reg) & bit);
 }
 
+static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
+{
+	int start_level, curr_level;
+	unsigned int reg_offset;
+	const struct mtk_eint_offsets *eint_offsets = &(pctl->devdata->eint_offsets);
+	u32 mask = 1 << (hwirq & 0x1f);
+	u32 port = (hwirq >> 5) & eint_offsets->port_mask;
+	void __iomem *reg = pctl->eint_reg_base + (port << 2);
+	const struct mtk_desc_pin *pin;
+
+	pin = mtk_find_pin_by_eint_num(pctl, hwirq);
+	curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
+	do {
+		start_level = curr_level;
+		if (start_level)
+			reg_offset = eint_offsets->pol_clr;
+		else
+			reg_offset = eint_offsets->pol_set;
+		writel(mask, reg + reg_offset);
+
+		curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
+	} while (start_level != curr_level);
+
+	return start_level;
+}
+
 static void mtk_eint_mask(struct irq_data *d)
 {
 	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
@@ -814,6 +840,9 @@ static void mtk_eint_unmask(struct irq_data *d)
 			eint_offsets->mask_clr);
 
 	writel(mask, reg);
+
+	if (pctl->eint_dual_edges[d->hwirq])
+		mtk_eint_flip_edge(pctl, d->hwirq);
 }
 
 static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
@@ -893,13 +922,17 @@ static int mtk_eint_set_type(struct irq_data *d,
 	void __iomem *reg;
 
 	if (((type & IRQ_TYPE_EDGE_BOTH) && (type & IRQ_TYPE_LEVEL_MASK)) ||
-		((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) ||
 		((type & IRQ_TYPE_LEVEL_MASK) == IRQ_TYPE_LEVEL_MASK)) {
 		dev_err(pctl->dev, "Can't configure IRQ%d (EINT%lu) for type 0x%X\n",
 			d->irq, d->hwirq, type);
 		return -EINVAL;
 	}
 
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		pctl->eint_dual_edges[d->hwirq] = 1;
+	else
+		pctl->eint_dual_edges[d->hwirq] = 0;
+
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
 		reg = mtk_eint_get_offset(pctl, d->hwirq,
 			eint_offsets->pol_clr);
@@ -920,6 +953,9 @@ static int mtk_eint_set_type(struct irq_data *d,
 		writel(mask, reg);
 	}
 
+	if (pctl->eint_dual_edges[d->hwirq])
+		mtk_eint_flip_edge(pctl, d->hwirq);
+
 	return 0;
 }
 
@@ -986,6 +1022,8 @@ static void mtk_eint_irq_handler(unsigned irq, struct irq_desc *desc)
 	const struct mtk_eint_offsets *eint_offsets =
 		&pctl->devdata->eint_offsets;
 	void __iomem *reg =  mtk_eint_get_offset(pctl, 0, eint_offsets->stat);
+	int dual_edges, start_level, curr_level;
+	const struct mtk_desc_pin *pin;
 
 	chained_irq_enter(chip, desc);
 	for (eint_num = 0; eint_num < pctl->devdata->ap_num; eint_num += 32) {
@@ -997,8 +1035,31 @@ static void mtk_eint_irq_handler(unsigned irq, struct irq_desc *desc)
 			virq = irq_find_mapping(pctl->domain, index);
 			status &= ~BIT(offset);
 
+			dual_edges = pctl->eint_dual_edges[index];
+			if (dual_edges) {
+				/* Clear soft-irq in case we raised it
+				   last time */
+				writel(BIT(offset), reg - eint_offsets->stat +
+					eint_offsets->soft_clr);
+
+				pin = mtk_find_pin_by_eint_num(pctl, index);
+				start_level = mtk_gpio_get(pctl->chip,
+							   pin->pin.number);
+			}
+
 			generic_handle_irq(virq);
 
+			if (dual_edges) {
+				curr_level = mtk_eint_flip_edge(pctl, index);
+
+				/* If level changed, we might lost one edge
+				   interrupt, raised it through soft-irq */
+				if (start_level != curr_level)
+					writel(BIT(offset), reg -
+						eint_offsets->stat +
+						eint_offsets->soft_set);
+			}
+
 			if (index < pctl->devdata->db_cnt)
 				mtk_eint_debounce_process(pctl , index);
 		}
@@ -1142,11 +1203,18 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		goto chip_error;
 	}
 
+	pctl->eint_dual_edges = devm_kzalloc(&pdev->dev,
+			sizeof(int) * pctl->devdata->ap_num, GFP_KERNEL);
+	if (!pctl->eint_dual_edges) {
+		ret = -ENOMEM;
+		goto chip_error;
+	}
+
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		dev_err(&pdev->dev, "couldn't parse and map irq\n");
 		ret = -EINVAL;
-		goto chip_error;
+		goto free_edges;
 	}
 
 	pctl->domain = irq_domain_add_linear(np,
@@ -1154,7 +1222,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto chip_error;
+		goto free_edges;
 	}
 
 	mtk_eint_init(pctl);
@@ -1172,6 +1240,8 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	set_irq_flags(irq, IRQF_VALID);
 	return 0;
 
+free_edges:
+	kfree(pctl->eint_dual_edges);
 chip_error:
 	gpiochip_remove(pctl->chip);
 pctrl_error:
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 740e6d2..375771d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -131,6 +131,9 @@ struct mtk_eint_offsets {
 	unsigned int  sens;
 	unsigned int  sens_set;
 	unsigned int  sens_clr;
+	unsigned int  soft;
+	unsigned int  soft_set;
+	unsigned int  soft_clr;
 	unsigned int  pol;
 	unsigned int  pol_set;
 	unsigned int  pol_clr;
@@ -217,6 +220,7 @@ struct mtk_pinctrl {
 	const struct mtk_pinctrl_devdata  *devdata;
 	void __iomem		*eint_reg_base;
 	struct irq_domain	*domain;
+	int			*eint_dual_edges;
 };
 
 int mtk_pctrl_init(struct platform_device *pdev,
-- 
1.8.1.1.dirty

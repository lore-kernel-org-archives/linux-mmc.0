Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264996;
	b=s9d6UmEn81hdmmKEdKQeU745LwWAZyV9RK8oviGGf3G1uB4RHpHpZwodn+VOu+DwX/Eg
	 rTqGB653vg2yqfX9tDy50g+DHmDsq7QCT8GclSuqw+xUAVbEwKlf5VkjcBrXezwqOA++k
	 NCfdmbnxJQAB8/uQytiNnxIwS2D5oQDBVDxEyBXMH8W0h84nV25ohetkiP/CJHq+RsfEL
	 Mwfo7LLVpzxNISV05mrKpX6Qiev4caEr6t9LxgA/f1HngzAyyyOudtSVsjZO5D25VrXR9
	 m22sCV32493d0N2iCOVAPJv0FhvQYZ4UO2RTOM8gYq3A6hS5JAlEj8iu0TP4nz2VVbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264996;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zOX7OfksvCJW7aXHc+epitR97QdrfrTvDreIp6AalsQ=;
	b=eZO14RoQwMdENKwuiEGwprPq1Ztg8ptlOqFlsDQCwX9be9JN+piXb7OrX96l+WYBXpPX
	 RO2aET0pCWmUAL1R04LRUyE0XYgzQJTGR8dOzduNU+cnDzIyKx+ZRIbocvDPLilDvB661
	 hqogtZPO1Kx3EQNUIWqZAprlQoDXg7cw/iOiv6g2AqKIaiEHUfLiVKWHzT2B1wEEYnDZW
	 irTPhtnYiEu6+g73b6HjJDv3IwLtv4uvKJ7YH3Lxp7P7rQ6vrdbQ/BlmK9F5+9qFs1EkA
	 15YIqLYVHQUkQ7oTCzWs14cvK1XIpSfUwRzcGegnUhgMeiy/aGFAGdFWKo3u04R8/1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQFBNi2h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD67606A682;
	Sat, 21 Nov 2026 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQFBNi2h
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264995;
	b=Grb7nTXMxXYGJH7DeDHE6w6ueYrvpwbKwC0m/xEWo2Zpa1juGJhPl+GWBbCuLwB2kWcJ
	 0Cud/uUQFxApkmN2NBoZUvwyJ49g5coRxLaEqJdszKwPrthQdeE3y/1ZICvkgBKDZ3q8S
	 OIlQRbHeYlxp6voFNJ34KFgg0q4XelAxVTEKPkIKS10qlQQC2pmQqkp/5ahHFiReaBea+
	 mfpqekvoj1a7deqeQfBX9DHstiVK/elYNBlir9AhOh3rXNmI16pYf0I6AE7S33z3nztnp
	 eFX/OBmCiigOCf/+ppcLm6IDjHZ6gZqUctMIflpXlJ2o9S6LsvCqvBxzU6z5+ayB4SA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264995;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zOX7OfksvCJW7aXHc+epitR97QdrfrTvDreIp6AalsQ=;
	b=YSMqn5UDVZ7CMhhLhm61sergwGoULjGqlvZ0HvcLS8JwPo7+askRbmJgx4PmNHyDi7oW
	 N+RACDcjGgwuW+yq7wlUtRPcxgfmxj5u/rTgCN77tKcXoqwZHCv+pLyHwGayexd+NEGdq
	 qPlrLYAX1WQ5LglsdDDGLTec1lAHwQvzMN8XbmIaB7HHeKRaRhhkJlncsUkhK9uedo7z6
	 E+O1AcL1FRYCx5385V7wGWfgO1Yu17DiN63MD0xJNN22yG7OCwOprl4V36VTe/bCd/t9x
	 SBrn8UPSwFiSr/yddeE9q11kwxB1TCEr+Rz9W88NG2wksNYa6rSq2TylWiwzqIA8EUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BA55A1F000D0;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264995;
	bh=zOX7OfksvCJW7aXHc+epitR97QdrfrTvDreIp6AalsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cQFBNi2h5eT7JmgjIG6P0P3LorTewAjhOCE45MmfycJDKccveowftnVHuwZn66h2h
	 X/cVHtAIRhGPgkd6boa8rnL74latkEVtQvPmsLAhS4nDn3cGoZzG7v8S8KEWoQibO9
	 LiW6WypBOloMdGj3CA/t9fIrDAdQTL6YBLrHFj0nLPk9Bsmq+RFewXAgyWpSJit6tg
	 kZhZ9QMIW9LMmkcIyYZvSYxu/ku6O0doJ6ITzGqJ6GJT15afqfvTXV82T4tIzTuJE6
	 q+tJ0j+gjNfPaT5Cq/JuHyHgxFUo8OCzrEnYfNFmqp9VZ4MoiXE4aT7vP0iUJ7F/v/
	 iXNmTaitHkodw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4CA834BC42;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:14 +0900
Subject: [PATCH RFC v2 04/13] irqchip: add SiRF AT550 interrupt controller
 driver
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-at550-rfc-v1-v2-4-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
In-Reply-To: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=5147;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=fsy/FdnfYNxsHS45hH6WFa5gS948TTAsT1G/V7A52d0=;
 b=buGa74iKto7dVQ+Qzrs3C2OXWNn3zN+2ffchM7lPTRctwumHJcgFXrFkis8O3Hu3ez001lhHR
 WkXWUGrMX+8AFtPcSD/nP8iRJMZDlDcIrF9dNixfKkeHg+nY0NiDuUm
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add an irqchip driver for the SiRF AT550 interrupt controller using
IRQCHIP_DECLARE and a linear IRQ domain.

Validate the chip ID register before touching mask/level registers, mask
both 32-source banks during setup, route sources to IRQ while leaving
DSP mask registers untouched, set IRQ_LEVEL on mapped descriptors, and
bound the dispatch loop.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                 |   1 +
 drivers/irqchip/Kconfig     |   5 ++
 drivers/irqchip/Makefile    |   2 +
 drivers/irqchip/irq-at550.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e052d9dde..354466e29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25852,6 +25852,7 @@ M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
 S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
+F:	drivers/irqchip/irq-at550.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 136bab41f..abf704110 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -852,4 +852,9 @@ config IRQCHIP_XILINX_SMMU_CSR
 	  ZynqMP-class platforms where a vendor CSR block mediates SMMU
 	  interrupts.
 
+config AT550_IRQ
+	bool
+	depends on ARM
+	select IRQ_DOMAIN
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 16a5fd126..0aa36c7b8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -136,3 +136,5 @@ obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SOPHGO_SG2042_MSI)		+= irq-sg2042-msi.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
 obj-$(CONFIG_IRQCHIP_XILINX_SMMU_CSR)	+= irq-xilinx-smmu-csr.o
+
+obj-$(CONFIG_AT550_IRQ) += irq-at550.o
diff --git a/drivers/irqchip/irq-at550.c b/drivers/irqchip/irq-at550.c
new file mode 100644
index 000000000..c9205ff12
--- /dev/null
+++ b/drivers/irqchip/irq-at550.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* SiRF AT550 interrupt controller. */
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <asm/exception.h>
+
+#define AT550_IRQ_COUNT	64
+#define AT550_MASK	0x18
+#define AT550_LEVEL	0x20
+#define AT550_CHIP_ID	0x34
+#define AT550_IRQ_ID	0x38
+
+static void __iomem *at550_intc;
+static struct irq_domain *at550_domain;
+
+static void at550_irq_mask(struct irq_data *data)
+{
+	void __iomem *reg = at550_intc + AT550_MASK + (data->hwirq / 32) * 4;
+
+	writel(readl(reg) & ~BIT(data->hwirq % 32), reg);
+}
+
+static void at550_irq_unmask(struct irq_data *data)
+{
+	void __iomem *reg = at550_intc + AT550_MASK + (data->hwirq / 32) * 4;
+
+	writel(readl(reg) | BIT(data->hwirq % 32), reg);
+}
+
+static struct irq_chip at550_chip = {
+	.name = "at550-intc",
+	.irq_mask = at550_irq_mask,
+	.irq_unmask = at550_irq_unmask,
+};
+
+static int at550_irq_map(struct irq_domain *domain, unsigned int irq,
+			irq_hw_number_t hwirq)
+{
+	if (hwirq >= AT550_IRQ_COUNT)
+		return -EINVAL;
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	irq_set_chip_and_handler(irq, &at550_chip, handle_level_irq);
+	irq_set_noprobe(irq);
+	return 0;
+}
+
+static const struct irq_domain_ops at550_domain_ops = {
+	.map = at550_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void __exception_irq_entry at550_handle_irq(struct pt_regs *regs)
+{
+	unsigned int count, hwirq;
+
+	for (count = 0; count < AT550_IRQ_COUNT; count++) {
+		hwirq = readl(at550_intc + AT550_IRQ_ID) & 0xff;
+		if (hwirq == 0xff)
+			return;
+		if (hwirq >= AT550_IRQ_COUNT) {
+			pr_err_ratelimited("at550-intc: invalid source %u\n", hwirq);
+			return;
+		}
+		if (generic_handle_domain_irq(at550_domain, hwirq))
+			return;
+	}
+}
+
+static int __init at550_irq_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int ret;
+
+	if (parent || at550_intc)
+		return -EINVAL;
+	at550_intc = of_iomap(node, 0);
+	if (!at550_intc)
+		return -ENOMEM;
+	if ((readl(at550_intc + AT550_CHIP_ID) & 0xffff) != 0x1230) {
+		ret = -ENODEV;
+		goto unmap;
+	}
+	/* A set mask bit enables a source; clear level bits route it to IRQ. */
+	writel(0, at550_intc + AT550_MASK);
+	writel(0, at550_intc + AT550_MASK + 4);
+	writel(0, at550_intc + AT550_LEVEL);
+	writel(0, at550_intc + AT550_LEVEL + 4);
+	at550_domain = irq_domain_create_linear(of_fwnode_handle(node), AT550_IRQ_COUNT,
+					   &at550_domain_ops, NULL);
+	if (!at550_domain) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+	ret = set_handle_irq(at550_handle_irq);
+	if (ret)
+		goto remove_domain;
+	irq_set_default_domain(at550_domain);
+	return 0;
+
+remove_domain:
+	irq_domain_remove(at550_domain);
+	at550_domain = NULL;
+unmap:
+	iounmap(at550_intc);
+	at550_intc = NULL;
+	return ret;
+}
+IRQCHIP_DECLARE(at550, "sirf,at550-intc", at550_irq_init);

-- 
2.56.0



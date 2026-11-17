Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794920822;
	b=HwcEeQOTqi7vvPfUdE1IyiC2n8fAyK+26WS+iS6MaC7HbMEeuy6kOmAyFgwjI9fH5CVH
	 +BjXbID/vBZ6aUgT+ZO4LoNotXdA7YCBUhXeEuNPgsJnumuVs4G2ivhk5Ld1aX2Rhzrg7
	 XSg7tjyQuHaDU3hFtQElxVUB9140wHF8q1bPh9hjVb4B9g6RTxCN2ZSqOu3D3w4PhglZJ
	 OJ0lVBL9xODziuNUfdGFu1Jh260fWNv0xv4wqj4/QZjMIXJtfuZ2o9J0BR5fI/yCAsfL1
	 jkwBup5tR74LqMxg/bFu4hiLq7tJqrIlpq+xfQehUu+7xf71tMXXzmiPaRa2vXDVw0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920822;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=14s9/XhWZ4H00XZEj8YbcuRVSxhBvNdnPj1htsr8Sl8=;
	b=kSXGzCUv2lYiKEtLPHSGMa+X/u/B9o0Txji5gc1jB10ZThgDhZagL6pZjSGdyAOE2WCc
	 imIRxpMoSmLoCRvBy/rDRV9uGUa9alH9tj1OzsO4AEZT2Tz+SNWN3qjGIvt2vHfMi/fz2
	 F96c7+tCkFanardwbKVOOZPgfz1nreYpvZemN+d6zuMxq9xLEH4Ud7e5AVHry2ZTyqJLK
	 putcJoBX8Lky6HbpfW0oj4ltJJ9q3Zl5q6cQX4H03x+hozdcGWSGoEbuBgmfer68sr19c
	 UEwq81qrVWmbo8C4DMOXXrWVK0WCM5YHkwp1LUbGr+w5L83BlhY3i3FmUp5l2/j9lyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpAEPO0j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501A60A2602;
	Tue, 17 Nov 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpAEPO0j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794920821;
	b=g2ykkNrnxfck8s6gbpUChwUlSxpMuaR8XZINGfc5svJSObV64vIq1RTKNdJ5oZElTzBu
	 Kzw1+EsBtoPQ8EVxJsWWqhAHeg0sWtZAjAgdPwd+GDWTXqxZwXjqj812JCnXEwwuN8hRq
	 9n7SMsDbYAUD7bzOtIRY06OAFGHXWAC06y8tLBPd4Ebyreqv0Vf3jO91jgkchi9uEHl6D
	 oBmnnTyYhQAtwiQPMFXJHWssnbX4z0uE7V3GyA0qV+Dn/DR9t6RnsantIQH4qZZhxayKW
	 eEdjow7JMz8FiVTCyJXXPCw4HvpQBfrMgL+wr0ECkH/Cmnni5T8OARfE9QIpA4Lj7eg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920821;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=14s9/XhWZ4H00XZEj8YbcuRVSxhBvNdnPj1htsr8Sl8=;
	b=HqLzmBhxjECwVI4VnSJTQGDM+6w2exyaLisRw4iCS489yYgn1gu4NKikTfVYOlrCnWDQ
	 Eiu5cJL9He35oalKVYiA3ySV2kR0BTYlxDW4UnDEb1BoFR2QCRhh35lEc7a0uODy430gN
	 APhi1qgzwf52NUNvxZkF2zx03L9YVSEoAVLfk7v4sIomyc2qr3ff8qCtWjWiMSQngf8jc
	 LrrOSbctrNBi4Gj+jgdHyE4gV3VzxY+aiF073zIOHG9Rv+uRktw8Spm5dA2YTLKT8j6Gd
	 F+c0wegLLoRTMfziQz0m0tRqZD26UcM4hMq5BxQNv8ic6ARXsEScJOaf3F/SfMQcVIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 471CF1F000C7;
	Tue, 17 Nov 2026 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920821;
	bh=14s9/XhWZ4H00XZEj8YbcuRVSxhBvNdnPj1htsr8Sl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HpAEPO0jPME0JrBd+4xxvO5RpT2Ku40Q5ZI4ODhX0WunTsSoPyDy41gh4ODVvoRup
	 v/wjbYBFdpta5Sdl456kV4l+QbDv1EtLsTaTMhKIzg45K8Pxez9azewX8CKLs/Vpr6
	 yEUymeNvMNqUmlhFq1GJOArvY1qE+9gWTm1LQ1AiU8YzZfD87uyhCXtk1iiUhRWmjd
	 8AT3NKkIPGMyViUzHWRS2mcaiebnGB1RRF8HK9BPAmVtluufZ/cJrgtp+v+ZwTngCE
	 21525rwCoNsi/FtB8Seod4RqQHu7bmoqCuAtDiWKRUYSzuUQaLRuWYEHuHSg+FLU0K
	 Bg+pBRP3edu3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C57014A983;
	Tue, 17 Nov 2026 13:06:58 +0000 (UTC)
From: yy-Local-LLM via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 22:06:52 +0900
Subject: [PATCH RFC 2/6] irqchip: add the SiRF AT550 interrupt controller
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
Message-Id: <20261117-at550-rfc-v1-v1-2-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
In-Reply-To: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Ulf Hansson <ulfh@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794920817; l=5243;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=9f0nqZv4WQhgKV1VvrZgloZ85kHakrrDVLP2DGNKTf4=;
 b=m6zb8HTiPIox5b7xSvz+83eHXlrLwsdjRIptcxLk4j6673ysoDkYCiWcdc0fUQqBy0mqGhciz
 4utdk7k6o5uDMYJ5wLW5zRTjBmMg2r77oYpeU8rxeonbhVQaT3Zj1RH
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: yy-Local-LLM <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: yy-Local-LLM <yogo.0917.sabu@gmail.com>

Register the root controller through IRQCHIP_DECLARE and a linear
domain. Validate the chip ID before writes, mask both banks during setup
and route sources to IRQ. Keep dispatch bounded and leave the DSP mask
registers alone. The register operations derive from the 6.12.60
YPL514si bring-up. The device owner has now booted the 7.4-rc3 candidate
through JWM on this upstream initialization path.

Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                 |   1 +
 drivers/irqchip/Kconfig     |   5 ++
 drivers/irqchip/Makefile    |   2 +
 drivers/irqchip/irq-at550.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3702cd8..acb6fde49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25855,6 +25855,7 @@ F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
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
index 000000000..33eb18cd1
--- /dev/null
+++ b/drivers/irqchip/irq-at550.c
@@ -0,0 +1,110 @@
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



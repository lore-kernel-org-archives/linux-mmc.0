Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599154;
	b=QkXsAtAiVGJmLZEz1gjnCPyMYt7/mOiaDnVyBbbu6pFXoY76QYFh36tWOx6YNfmDiUmQ
	 IyT2TH2NLAbKYtu4xvHR4GouqIqGWs+yP4cgPfCa1aLOoBoAT7lLFzUGtH4bSSzoXl7bC
	 mYjNkpwUcWQbb1f/8ezxsdh5iaoSIasoNBR0g4ZQ/yTdJysnppJEBc0J7GUbD9jF5bWvq
	 E2X+zBEQs/pgobnu00WSlg1STZ5igFTOFtP8NwiQKQ1WfKrN1SYOm9s4MNa8xQdUfS1dw
	 OngndBlfqV00CqIpEgWHK8kZFxFzr5JM05yEkOQEiyEpcEc8en91fIPpTPAXZqR6kxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599154;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vf7ZK5u2reB6Du+GchqoDahqBht5sD1HLOrfvrlTUKY=;
	b=UWbJjsmatMIhWI5aM1jAJvwKkpKvRlDeiqlySpwq5igB5PdcDUrl3SaoaaIyzQEsyTJi
	 cEIVykga53mAPK5H14IihNWhy98Rr1t9mE0ajoWa6XcHevUnYsXBFiGMQ15JgPE3BhDV1
	 SimygeNIfEeJVoBaXVCjpKen8mGSc764faWuxEgQf/FE+lqVA8+XLqX7his/R5+6Dm/cy
	 cv2Y0t4XpptRuS6gIcelus7AOEFhIPDIF95Wv0HUY+KSFX3ZLNGDPdEei2XrfkBZVJgMR
	 2Bq7aHXjzCPnn0SdTL7oBi+PKTZEqdb4JWKLDLmLEUhRzSzCnTSk5ZXeBV3ILPheQtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0YkxMkK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAC60A3834;
	Wed, 21 Oct 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0YkxMkK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599154;
	b=YIXwmwB20pPkeOj3ygmFTgmgPTNnY/IueHYYN8PGtd4xAU666RiJDeXh2ESmAqD8lIby
	 JppUeeMeKlUIlF2NX2SL942e6LmvELAc7WNXl2nFE66jaPzF1Rwe5Dz01oL9scSNM3xvx
	 k4oJWvE8zSo0FkZO04aZivNwOGq0SguPK3vt8j125Ipn8CyDLBpxg9xMrFaejvFk3aND1
	 4ZGN6LI6Cn4540+IszkDoSPhbSj0wMh1ZdVAxcTLi+nYiMV7XGb8UQG6YE+CECfuedIR3
	 2ua0yGxHKaPihx6+k1IvVVOh9X+Enco4XsDzG2hNGe2b9xfNtn2d9kZT1xgyLWuYzoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599154;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vf7ZK5u2reB6Du+GchqoDahqBht5sD1HLOrfvrlTUKY=;
	b=jNuHH/453SdDGaBJtZaLFcyQwcU7Ti172Z15wqkHX/lc4iHQl73WCbc5IbcYudeLhmlv
	 U5ZbmXWBfY6vXBRi+OSSXRZ8Pewn+FzsvvGMuYZ8nCdKOArMi85l/A46cE7qoswU4fhvi
	 3NiYpzPDpUZgiyZuVG1Ie0VIjzt8IdM8torN452L3tIKyLH0ivbfqGTtDv0b56uHGoKwI
	 YdBhRv4IbNCLbd+GqEfK+vnaHRlr2hjm/DnbFoZVjX8zXFB9CpNaMZ2ZMD9pl47ilDG7k
	 ftWs9tN+k9vPbq3aDiFmXPID84fnodgSbXqfV6sod9ZPK0q9pYB50I5mrIx3WyPTsdg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D43361F01574;
	Wed, 21 Oct 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599154;
	bh=vf7ZK5u2reB6Du+GchqoDahqBht5sD1HLOrfvrlTUKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=V0YkxMkKvI7TQKfoMYaJ7me/jI+v3mJ1Qh8Z2vsH3iHsgzf0zyjvZTLRRo2asOwk+
	 j8e3bzcDYkzF3TrYcV9qowhtFcKfJS0oeqi8b/P3huvCfCXIhEJe/GRIimSE2dZ+mn
	 wt0RlRYCSZL23ajaN1j+IaQZZg7Fa2/h5XLutxb7MX9kd7Gx36DRiGaGGJcCdOSG2W
	 XTpqwV2e4XSVnCuBO4K5BNW80W/qoOFQ80LcDTqzaI1QtUHHCCbHdj0ljdlRb/vwk1
	 1Acgj4fArnaGpkt7WGdbM92DV+WZIjSsmISRrmk0mi7tDMAH6g4sBpb43QE90szPgw
	 AqTWJMCJBsmuA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A8DC433C1;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:06 +0800
Subject: [PATCH 09/27] gpio: rockchip: Add RK3572 GPIO support
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
Message-Id: <20261022-add-board-ok3572-c-v1-9-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=7782;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=ybuMjroqWlGrhbZ7b+7+3KlQvwUxXnFSIMLjfQO0hew=;
 b=RqtBCE+OwGqzr9ILJLcWOVv41u5fPijhMaXsMt68lHeN6E3KIkhV5WLpGINhA51ZzleGRQUis
 c3ga1PlIquNDkoeUSPuKbs2jgMY8vIykxHmYjoi3qmQQiuIcfdpIuu0
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Support GPIO V2.7, four parent interrupts, and firmware-provided
interrupt-group masks. Keep all pins on the primary interrupt when group
queries are unavailable.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/gpio/gpio-rockchip.c        | 91 +++++++++++++++++++++++++++++++++----
 drivers/pinctrl/pinctrl-rockchip.h  |  8 +++-
 include/soc/rockchip/rockchip_sip.h |  5 ++
 3 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 77b239a9a601e..35894a68b5446 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -21,6 +22,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <soc/rockchip/rockchip_sip.h>
 
 #include "../pinctrl/core.h"
 #include "../pinctrl/pinctrl-rockchip.h"
@@ -35,6 +37,7 @@
 #define GPIO_TYPE_V2		(0x01000C2B)
 #define GPIO_TYPE_V2_1		(0x0101157C)
 #define GPIO_TYPE_V2_2		(0x010219C8)
+#define GPIO_TYPE_V2_7		(0x01074D2E)
 
 static const struct rockchip_gpio_regs gpio_regs_v1 = {
 	.port_dr = 0x00,
@@ -209,12 +212,27 @@ static int rockchip_gpio_set_debounce(struct gpio_chip *gc,
 	if (bank->gpio_type == GPIO_TYPE_V2 && !IS_ERR(bank->db_clk)) {
 		div_debounce_support = true;
 		freq = clk_get_rate(bank->db_clk);
-		max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
-		if (debounce > max_debounce)
-			return -EINVAL;
 
-		div = debounce * freq;
-		div_reg = DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
+		if (of_device_is_compatible(bank->of_node, "rockchip,rk3572-gpio-bank")) {
+			if (!freq)
+				return -EINVAL;
+
+			div = (u64)(GENMASK(23, 0) + 1) * USEC_PER_SEC;
+			max_debounce = div_u64(div, 2 * freq);
+			if (debounce > max_debounce)
+				return -EINVAL;
+
+			div = (u64)debounce * freq * 2;
+			div_reg = DIV_ROUND_CLOSEST_ULL(div, USEC_PER_SEC);
+			div_reg = div_reg ? div_reg - 1 : 0;
+		} else {
+			max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
+			if (debounce > max_debounce)
+				return -EINVAL;
+
+			div = debounce * freq;
+			div_reg = DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
+		}
 	} else {
 		div_debounce_support = false;
 	}
@@ -342,6 +360,12 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	pending = readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
+	for (unsigned int i = 0; i < bank->nr_irqs; i++) {
+		if (bank->irqs[i] == irq_desc_get_irq(desc)) {
+			pending &= bank->irq_masks[i];
+			break;
+		}
+	}
 	for_each_set_bit(irq, &pending, 32) {
 		dev_dbg(bank->dev, "handling irq %d\n", irq);
 
@@ -568,8 +592,9 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	rockchip_gpio_writel(bank, 0xffffffff, bank->gpio_regs->int_en);
 	gc->mask_cache = 0xffffffff;
 
-	irq_set_chained_handler_and_data(bank->irq,
-					 rockchip_irq_demux, bank);
+	for (unsigned int i = 0; i < bank->nr_irqs; i++)
+		irq_set_chained_handler_and_data(bank->irqs[i],
+						 rockchip_irq_demux, bank);
 
 	return 0;
 }
@@ -645,6 +670,36 @@ static void rockchip_clk_put(void *data)
 	clk_put(clk);
 }
 
+static int rockchip_gpio_read_irq_groups(struct rockchip_pin_bank *bank)
+{
+	struct arm_smccc_res res;
+	u32 assigned = 0;
+	int status;
+
+	for (unsigned int i = 1; i < bank->nr_irqs; i++) {
+		arm_smccc_smc(ROCKCHIP_SIP_GPIO_CONFIG, ROCKCHIP_SIP_GPIO_GET_GROUP,
+			      bank->bank_num, i, 0, 0, 0, 0, &res);
+		status = (int)res.a0;
+		if (i == 1 && (status == SMCCC_RET_NOT_SUPPORTED ||
+			       status == ROCKCHIP_SIP_RET_NOT_SUPPORTED)) {
+			/* Older firmware leaves all pins on the primary IRQ. */
+			dev_dbg(bank->dev, "GPIO group query unsupported: %d\n",
+				status);
+			break;
+		}
+		if (status)
+			return dev_err_probe(bank->dev, -EIO,
+					     "cannot read interrupt group %u: %d\n",
+					     i, status);
+		bank->irq_masks[i] = res.a1;
+		if (assigned & bank->irq_masks[i])
+			return -EINVAL;
+		assigned |= bank->irq_masks[i];
+	}
+	bank->irq_masks[0] = ~assigned;
+	return 0;
+}
+
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 {
 	struct platform_device *pdev = to_platform_device(bank->dev);
@@ -654,10 +709,23 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
-	ret = platform_get_irq(pdev, 0);
+	ret = platform_irq_count(pdev);
 	if (ret < 0)
 		return ret;
-	bank->irq = ret;
+	if (ret != (of_device_is_compatible(bank->of_node,
+					    "rockchip,rk3572-gpio-bank") ? 4 : 1))
+		return -EINVAL;
+	bank->nr_irqs = ret;
+	for (unsigned int i = 0; i < bank->nr_irqs; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
+		bank->irqs[i] = ret;
+	}
+
+	ret = rockchip_gpio_read_irq_groups(bank);
+	if (ret)
+		return ret;
 
 	bank->clk = devm_clk_get_enabled(bank->dev, NULL);
 	if (IS_ERR(bank->clk))
@@ -669,6 +737,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	case GPIO_TYPE_V2:
 	case GPIO_TYPE_V2_1:
 	case GPIO_TYPE_V2_2:
+	case GPIO_TYPE_V2_7:
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
 		bank->db_clk = of_clk_get(bank->of_node, 1);
@@ -797,7 +866,8 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 {
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
-	irq_set_chained_handler_and_data(bank->irq, NULL, NULL);
+	for (unsigned int i = 0; i < bank->nr_irqs; i++)
+		irq_set_chained_handler_and_data(bank->irqs[i], NULL, NULL);
 	if (bank->domain) {
 		irq_domain_remove_generic_chips(bank->domain);
 		irq_domain_remove(bank->domain);
@@ -807,6 +877,7 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_gpio_match[] = {
 	{ .compatible = "rockchip,gpio-bank", },
+	{ .compatible = "rockchip,rk3572-gpio-bank" },
 	{ .compatible = "rockchip,rk3188-gpio-bank0" },
 	{ },
 };
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 553197f6dc690..058b58dcde404 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -302,7 +302,9 @@ struct rockchip_drv {
  *	    bank has its own IOC block
  * @clk: clock of the gpio bank
  * @db_clk: clock of the gpio debounce
- * @irq: interrupt of the gpio bank
+ * @irqs: parent interrupts of the GPIO bank
+ * @irq_masks: pins assigned to each parent interrupt
+ * @nr_irqs: number of parent interrupts
  * @saved_masks: Saved content of GPIO_INTEN at suspend time.
  * @pin_base: first pin number
  * @nr_pins: number of pins in this bank
@@ -331,7 +333,9 @@ struct rockchip_pin_bank {
 	struct regmap			*regmap_ioc;
 	struct clk			*clk;
 	struct clk			*db_clk;
-	int				irq;
+	unsigned int			irqs[4];
+	u32				irq_masks[4];
+	unsigned int			nr_irqs;
 	u32				saved_masks;
 	u32				pin_base;
 	u8				nr_pins;
diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
index 501ad1fedb201..984272ede3baf 100644
--- a/include/soc/rockchip/rockchip_sip.h
+++ b/include/soc/rockchip/rockchip_sip.h
@@ -20,4 +20,9 @@
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM	0x07
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD	0x08
 
+#define ROCKCHIP_SIP_RET_NOT_SUPPORTED		-2
+
+#define ROCKCHIP_SIP_GPIO_CONFIG		0x8200002c
+#define ROCKCHIP_SIP_GPIO_GET_GROUP		0
+
 #endif

-- 
2.34.1



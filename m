Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774428;
	b=Dylwoxh8xbImQ9BXItpRI+Ij2HgxFAi/s1w1gDb6P9lhtMTkeLWFcnKlwpaC4zjRbMHd
	 yY36Vp3cCIe1/BTQwt3KRBdJLKqstS10fa3EsLGQjL2MkHeNg5wYXu0w8RsH4enMmjCr8
	 qJ/pP73cHwGzc9ju5odPntamw/RG/73bqoOxjvTqfd0mNgaKmIMK6A8/zTrSB8jaPRAkA
	 qItndAfUOV1EY160FSjrDDvMu2GWkpbHQ19uidl5AZIEfHSocjzXpYY5zULQs9pziHIaD
	 l9VAPpqjXxUQelR1jCDf1b0V7933l+H/Rq3aPi/yKtZCdjkuCId6NDCRB6cKFK/+Q3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774428;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9EbUFxPpjVdox66gKmuaF7N1cKWgWEEGCceTFYu7Wik=;
	b=WWXAfdlVakfFRolviIiM7XJ69lApvsKC3i33HNLbQT8yvARVmkDQ5NzkA/Si1lk9SQPW
	 V8ktEynEfBOexTJJCkabxLwvv5gfruEwe2KT3CBbtp5oapuytHn43wXFL+IHQwOzePn1D
	 La0BIm4KAt+kY/Bxst3mEAtR6ShaPNDZwb5oqpTxYIGXYgp/yFGFzb7CwEThG9wFr/uci
	 oBgzKOJl35AZzA0hT5e2WNnFYe11y4L4K2IkwttDKOejuAisgkod77v5WpCSb1YPCZ/em
	 2y66hP9OpUa5yaASv1wT0wGB5egoYqmrDL/RBxFFbUgkAgeJ4ENyiejfbnTduPxUgpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZyhqhjr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6B606A68E;
	Fri, 27 Nov 2026 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZyhqhjr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774428;
	b=wSVyUYMUwPaLtBQGK5U3K7TrhLizk+YcxR/LpGSIyKtMBmq0X2lRBHVoBc1LDSGCKpA2
	 bhkQVq0JOBDdzHYDSw/yfCkTI64TMqdIyh/0twwRL0xz25Sx8F/3KpsCeda4tGboeFHtw
	 YqltPngEZdeCKX23t70Dk3/nGRUlDIDuiltL1sIsSQo9FRBqL8pYc3HGElsw2GzgVVmoO
	 qQ6+gVsEchu1Tus3qFYc4Fnj5yg5jA4rNIUpXqe7VYfb6qarlsaNFtUgjwGz2cG+XOF5v
	 o3NHoX7uZ+vqbU59FHOcojaJw5tYI9hffV/YExVU8wQLsFYZxBHaZtkvXJxKG0FbKYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774428;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9EbUFxPpjVdox66gKmuaF7N1cKWgWEEGCceTFYu7Wik=;
	b=hxtiM6IbG0ZKJt5I0sdb3txwxyQrWjK1gWfjmYmkgYuj/DqpShtyV4a6QznLEAIY3p1Y
	 zrRhVH+QohyXZcpTCBOIGRhxtMgt42YG+28pwdROYvTthcjGfzBXX0oYilCsu+Mqo5DOS
	 YsRuiBtnr0Nc3ERphdqigP8RCDEaFRdMmvOzb48CJQnsrvDNQU0baSTZ7JZ9dFAkR+F3W
	 ZBvNTPoZG2X0koIJ4mnoQGi6tVe5ZoHk6mSOR/XW4Voxh7LZsz7VsZCWYoXGy2FHVZh1Y
	 +B1mqKy5N1Qem6rFbfZpvBUeejHmo4R7GWTOaR2Cgl/s8+LqcUT+fikgNlYcAemEIKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 16F311F00A1F;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774428;
	bh=9EbUFxPpjVdox66gKmuaF7N1cKWgWEEGCceTFYu7Wik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KZyhqhjr2HYdGxNc4QshoUK92gM4CfPKWXTgUqpDKFcv1miwTHaWl/cT8mt6DY4NG
	 rSv5hKe0z+dK75aocBKH54eRgFjIEcDTqyJey11ooB0zlPpeuE4vLQnjxTKTOd0dhV
	 42AujTBjjokzogDqzO28ANY2OgRs3O/UTodEHI5JxmCvlFwDz80K3/FhkaAwkvqguA
	 MFJnYar8OTOHzH9OCdNZS4T640uNNDTDgoPIGyTLoQrgmXXz0sXjleTXqbcV37HMT/
	 p08PRVp86jygGjVicrybVbWip9jmQ7VNwHO64yzfL1WerHNkj1BGrau4fsJ7/9RbI7
	 sQe3hDpbj1NNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 78DA64B703;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:07 +0900
Subject: [PATCH RFC v3 06/13] clocksource/drivers/timer-at550: add SiRF
 AT550 counter and match timer
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
Message-Id: <20261127-at550-rfc-v1-v3-6-f2221008912b@gmail.com>
References: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
In-Reply-To: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
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
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev, 
 Yuugo Yoneda <yogo.0917.sabu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=5987;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=F+DqKHl+CH4glkcuw2di8GrhLBYm8jv5gyGPMv1ldyQ=;
 b=bdT/N8H+KPrd5O1LRRALcC5L9Rwfqk4Jq9XGOAwfSqCyTLD84MmMXi/cYkI2xz3Rf0a90ISgh
 7o6rA9nLGakCXWzxoSr6Vp/AJghoYXwIgOU4V5pyHmcHYFYJA6niIqV
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add a clocksource, sched_clock, and one-shot clockevent driver for the
SiRF AT550 system timer using the low 32-bit counter and match channel
0.

Enable the timer clock before reading the watchdog and divider
registers, preserve the firmware-configured divider, refuse to
initialize if a watchdog is running, write MATCH0 before clearing
status, implement set_state_oneshot_stopped, and unwind resources on
error.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                       |   1 +
 drivers/clocksource/Kconfig       |   6 ++
 drivers/clocksource/Makefile      |   2 +
 drivers/clocksource/timer-at550.c | 136 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c5a814f2..d6ea4d946 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25853,6 +25853,7 @@ S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
+F:	drivers/clocksource/timer-at550.c
 F:	drivers/irqchip/irq-at550.c
 
 SIS 190 ETHERNET DRIVER
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index da8348329..ed73947bd 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -835,4 +835,10 @@ choice
 
 endchoice
 
+config CLKSRC_AT550
+	bool
+	depends on ARM
+	select TIMER_OF
+	select CLKSRC_MMIO
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 464ec6690..0f3d4fb1c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -97,3 +97,5 @@ obj-$(CONFIG_RALINK_TIMER)		+= timer-ralink.o
 obj-$(CONFIG_NXP_STM_TIMER)		+= timer-nxp-stm.o
 obj-$(CONFIG_RTK_SYSTIMER)		+= timer-realtek.o
 obj-$(CONFIG_RZN1_TIMER)		+= timer-rzn1.o
+
+obj-$(CONFIG_CLKSRC_AT550) += timer-at550.o
diff --git a/drivers/clocksource/timer-at550.c b/drivers/clocksource/timer-at550.c
new file mode 100644
index 000000000..a56446478
--- /dev/null
+++ b/drivers/clocksource/timer-at550.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* SiRF AT550 free-running counter and match channel 0. */
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#define AT550_MATCH0	0x08
+#define AT550_STATUS	0x20
+#define AT550_ENABLE	0x24
+#define AT550_WATCHDOG	0x28
+#define AT550_DIVIDER	0x2c
+
+static void __iomem *at550_timer;
+static struct clock_event_device at550_event;
+
+static u64 notrace at550_sched_read(void)
+{
+	return readl_relaxed(at550_timer);
+}
+
+static int at550_shutdown(struct clock_event_device *event)
+{
+	writel(0, at550_timer + AT550_ENABLE);
+	return 0;
+}
+
+static int at550_next_event(unsigned long delta,
+			    struct clock_event_device *event)
+{
+	u32 target;
+
+	writel(0, at550_timer + AT550_ENABLE);
+	target = readl(at550_timer) + delta;
+	writel(target, at550_timer + AT550_MATCH0);
+	writel(1, at550_timer + AT550_STATUS);
+	writel(1, at550_timer + AT550_ENABLE);
+	if ((s32)(target - readl(at550_timer)) <= 0) {
+		writel(0, at550_timer + AT550_ENABLE);
+		return -ETIME;
+	}
+	return 0;
+}
+
+static irqreturn_t at550_timer_interrupt(int irq, void *data)
+{
+	struct clock_event_device *event = data;
+
+	if (!(readl(at550_timer + AT550_STATUS) & 1))
+		return IRQ_NONE;
+	writel(0, at550_timer + AT550_ENABLE);
+	writel(1, at550_timer + AT550_STATUS);
+	event->event_handler(event);
+	return IRQ_HANDLED;
+}
+
+static int __init at550_timer_init(struct device_node *node)
+{
+	struct clk *clk;
+	unsigned long rate;
+	unsigned int irq;
+	int ret;
+
+	if (at550_timer)
+		return -EINVAL;
+	at550_timer = of_iomap(node, 0);
+	if (!at550_timer)
+		return -ENOMEM;
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto unmap;
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto put_clock;
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		ret = -EINVAL;
+		goto disable_clock;
+	}
+	/* Do not disturb a running firmware watchdog or unknown divider bits. */
+	if (readl(at550_timer + AT550_WATCHDOG) ||
+	    readl(at550_timer + AT550_DIVIDER) > 0xffff) {
+		ret = -EBUSY;
+		goto disable_clock;
+	}
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq) {
+		ret = -EINVAL;
+		goto disable_clock;
+	}
+	writel(0, at550_timer + AT550_ENABLE);
+	writel(0x3f, at550_timer + AT550_STATUS);
+	at550_event.name = "at550-match0";
+	at550_event.features = CLOCK_EVT_FEAT_ONESHOT;
+	at550_event.rating = 200;
+	at550_event.set_next_event = at550_next_event;
+	at550_event.set_state_shutdown = at550_shutdown;
+	at550_event.set_state_oneshot = at550_shutdown;
+	at550_event.set_state_oneshot_stopped = at550_shutdown;
+	at550_event.tick_resume = at550_shutdown;
+	at550_event.cpumask = cpumask_of(0);
+	at550_event.irq = irq;
+	ret = request_irq(irq, at550_timer_interrupt, IRQF_TIMER,
+			 "at550-match0", &at550_event);
+	if (ret)
+		goto dispose_irq;
+	ret = clocksource_mmio_init(at550_timer, "at550-counter", rate, 200,
+				   32, clocksource_mmio_readl_up);
+	if (ret)
+		goto free_irq;
+	/* Firmware has configured the divider; the supplied clock is its output. */
+	sched_clock_register(at550_sched_read, 32, rate);
+	clockevents_config_and_register(&at550_event, rate,
+					max(32UL, rate / 10000), 0x7fffffff);
+	return 0;
+
+free_irq:
+	free_irq(irq, &at550_event);
+dispose_irq:
+	irq_dispose_mapping(irq);
+disable_clock:
+	clk_disable_unprepare(clk);
+put_clock:
+	clk_put(clk);
+unmap:
+	iounmap(at550_timer);
+	at550_timer = NULL;
+	return ret;
+}
+TIMER_OF_DECLARE(at550, "sirf,at550-timer", at550_timer_init);

-- 
2.56.1



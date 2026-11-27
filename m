Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774429;
	b=ZOoIl2SLtJZCs5dsdJ+E2TNQPlbIGZsdjky80Tf37OKcy1dCxMoKwCpWwYCeGdUHNq4r
	 m40piqAvZYe/lwpCs7BhFLgHmR74lkV3sC21RrgxhUYeV370h/BTKb7rNoAEqVC3wnRe6
	 Z04NOsg4tCT20SoRNU0MIWCZy7QxBe0+0XjV6mfYP9fFTxKgm44Dt2cLtxJ0FJXrXUxfk
	 oOXaBUBpGGqMib3BgP30JCAgLp+DGpm0rHHFHxBhduZOox1qRx75mOE3v2EvnFabx6Fb8
	 esbe3wzJuTmVxhdxZFkMGfmR+Xs82IK+k4OYK7vSp9lZEEfX27gRRz7gtaVhSzH8UcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LRj8oJv1/mBrDGR6Um+4n+0XBjf1pQ2R34Tjwcbna08=;
	b=4h2rACHkPMl2UvB2VyL+uBgx/dC7pceYdfoJzgC4HQC1RUHF0IRI01YPVS8l4HL7soYQ
	 EejcCGmziWWirf74I+YI6xKf6B2hJgJs52PuZRThGTZg2vxmyq4ScgYoE3+2hC5MHuv2X
	 FPdvSefk9jE+k6c3iSzuSaZbtqllJY06YlHdW3NI13pvsf+8qPFCEojvBGzl4I60FBVUw
	 IG6NFFLm+zHZnmx0wBf5s+yoG5bdzdqnnD+UJSSFLB3KYAjU/4s62t2G4ErAyqeVAzfmP
	 p5vQcLn4m06+2CKqyV4Ub28K6xp6fwAyByVB+4Lh9cfOt4cqzFgWoPv/wJ6i+c+KdzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qks/WQHu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28E60A2638;
	Fri, 27 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qks/WQHu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774429;
	b=Ja0uQS7GHZL03CUE6EI4WoDoOW8h0vCWkXdr2akBS4ZMM3DQ0wcPZ1U9PeFulwdQHcv2
	 CN9gLsxNbshp5bpd8KHIei5iZ5UaZ/qw1NQ67YjPInSeAggoRevUKWsF4denVIjqfH3VT
	 Lav0WFlIdKCfvSDlLpxuVzUzKtSN8Z0RHkewfm6U7dsr40zxxhONAFg7tmHgUBpjR5YE4
	 dB+OL0BK70CsjjpWVBIiS9Abh5CVY+MszAV3ELjo7Ii4JqH154BUf0xTUn9GtMz42xwCb
	 P9XNDl8zB/wTpbErBRIo6O05aNrmqRRimE7xeQ6aZ/IOE19Kz8yniFqg9Kg7tetx8JA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LRj8oJv1/mBrDGR6Um+4n+0XBjf1pQ2R34Tjwcbna08=;
	b=0+5zIpyeby2V+7k4egDcb2/gqpIxUb9tRHyAOeBTGRJbwLrwm51wCADt58KUl1BOoYQg
	 /JkC1yawk2C5prjRYqfEt7GIufHF1SOq6VmjlG4o2s9evMGiAmqhHJthNPP//xNCCQJ/u
	 vaPs35sOmwi7T0/Q4OvfbyCUYLoqqlvYFmQpG3yX9d8cZ8GAGfqJseWG00Ifdz/tUVROK
	 PzbDJdS6vGYAPcr60vR4yCAckV7xxJNsSnPM1DyJcr1u+J/yFsAqizSjthadx30rlFgdf
	 RNFTevjk6TCBgMlX7iyB5Uq4de2g2HYYXDZBTVQ8o1AuY1zKWQbvplpLECqWxUOOTrQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8F18F1F0093A;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774429;
	bh=LRj8oJv1/mBrDGR6Um+4n+0XBjf1pQ2R34Tjwcbna08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Qks/WQHu6iMeVCuh0GtMkOvj7gI6CosZNneOw/3J/EVD3eacNHrRq4z/L8phbTF3V
	 /eE/2jniMtlUMtBp/6fCosw8NjlSf2i0Ws38TXArSdIPxT7rWdpzmfyAuFmlKfQY6k
	 ePW5JAKEtbvcS+a23OtZ4b37p4fCdbGupCy8hxQ6faa3rwcpZITLBYKCArK4Tc2DJE
	 d2xOiXqDDXYBwHpT2M5Gca82GjlwuQfvYgXxehTXMdcaq5gQAamWpAboVp96I7n6rl
	 shbL7JpDs3+EtIuJn8wgj+y2rHYl5/w+0xiTJzY9fjD7looh1SSdIGNILse3w8lVuc
	 pXqt8iymwAyAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BB1F04B70B;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:09 +0900
Subject: [PATCH RFC v3 08/13] Input: add polled SiRF AT550 resistive
 touchscreen driver
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
Message-Id: <20261127-at550-rfc-v1-v3-8-f2221008912b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=6349;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=puJ2IprXf6pB6bDw6DUuBvE/L9OecjXtZcP2ahzgQIY=;
 b=GRcZeGFpBkGG2N7JeQzaQuSOmQXhkNHVFd8k6WyAA9JuT9o++Zy8oTqBgB6S5P69mNSZ+EKkp
 6yir5xTFHjkDIL0Er9HhCgHntidv0C4/HjGyZMB9qzLyEop0SORGrHL
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add a polled input driver for the SiRF AT550 resistive touchscreen
controller reporting raw ABS_X, ABS_Y, and BTN_TOUCH events.

Preserve firmware settling configuration, explicitly stop acquisition on
close before clearing pending interrupts, reject streaming or AUX mode
at probe, and rely on standard touchscreen properties with affine
calibration handled in userspace.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                          |   1 +
 drivers/input/touchscreen/Kconfig    |  10 +++
 drivers/input/touchscreen/Makefile   |   2 +
 drivers/input/touchscreen/at550-ts.c | 123 +++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8e239c7e..df3d38c6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25855,6 +25855,7 @@ F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
 F:	drivers/clocksource/timer-at550.c
+F:	drivers/input/touchscreen/at550-ts.c
 F:	drivers/irqchip/irq-at550.c
 
 SIS 190 ETHERNET DRIVER
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3..e68af1dd6 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1414,4 +1414,14 @@ config TOUCHSCREEN_HIMAX_HX83112B
 	  To compile this driver as a module, choose M here: the
 	  module will be called himax_hx83112b.
 
+config TOUCHSCREEN_AT550
+	tristate "SiRF AT550 resistive touchscreen"
+	depends on OF && HAS_IOMEM
+	help
+	  Say Y to enable polled coordinate acquisition on the AT550.
+	  Coordinates and pen state are exposed through the input subsystem.
+	  Firmware must initialize the touchscreen peripheral clock.
+	  Board-specific affine calibration belongs in userspace.
+	  To build as a module, choose M; it will be called at550-ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de833..6b8d09601 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -119,3 +119,5 @@ obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_IQS7211)	+= iqs7211.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
+
+obj-$(CONFIG_TOUCHSCREEN_AT550) += at550-ts.o
diff --git a/drivers/input/touchscreen/at550-ts.c b/drivers/input/touchscreen/at550-ts.c
new file mode 100644
index 000000000..80cd28047
--- /dev/null
+++ b/drivers/input/touchscreen/at550-ts.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* SiRF AT550 coordinate acquisition. Layout cross-checked with AT551 draft. */
+#include <linux/bits.h>
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define AT550_CTRL1 0x00
+#define AT550_CTRL2 0x04
+#define AT550_INTR 0x08
+#define AT550_COORD 0x0c
+#define AT550_STREAM 0x44
+#define AT550_DOWN BIT(31)
+#define AT550_VALID (BIT(29) | BIT(30))
+
+struct at550_ts {
+	void __iomem *base;
+	struct touchscreen_properties prop;
+	u32 ctrl1;
+	u32 ctrl2;
+};
+
+static void at550_ts_poll(struct input_dev *input)
+{
+	struct at550_ts *ts = input_get_drvdata(input);
+	u32 data = readl(ts->base + AT550_COORD);
+
+	if (!(data & AT550_DOWN)) {
+		input_report_key(input, BTN_TOUCH, 0);
+		input_sync(input);
+		return;
+	}
+	if ((data & AT550_VALID) != AT550_VALID)
+		return;
+	touchscreen_report_pos(input, &ts->prop, data & GENMASK(11, 0),
+			       (data >> 12) & GENMASK(11, 0), false);
+	input_report_key(input, BTN_TOUCH, 1);
+	input_sync(input);
+}
+
+static int at550_ts_open(struct input_dev *input)
+{
+	struct at550_ts *ts = input_get_drvdata(input);
+
+	/* Polling keeps the interrupt sources disabled. Preserve CE settling. */
+	writel(ts->ctrl2 | GENMASK(15, 14), ts->base + AT550_CTRL2);
+	writel((ts->ctrl1 & GENMASK(7, 4)) | BIT(11) | BIT(10),
+	       ts->base + AT550_CTRL1);
+	writel(3, ts->base + AT550_INTR);
+
+	return 0;
+}
+
+static void at550_ts_close(struct input_dev *input)
+{
+	struct at550_ts *ts = input_get_drvdata(input);
+
+	writel(ts->ctrl1 & GENMASK(7, 4), ts->base + AT550_CTRL1);
+	writel(ts->ctrl2 & ~GENMASK(15, 14), ts->base + AT550_CTRL2);
+	writel(3, ts->base + AT550_INTR);
+}
+
+static int at550_ts_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct at550_ts *ts;
+	struct input_dev *input;
+	int error;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ts->base))
+		return PTR_ERR(ts->base);
+	ts->ctrl1 = readl(ts->base + AT550_CTRL1);
+	ts->ctrl2 = readl(ts->base + AT550_CTRL2);
+	if ((ts->ctrl1 & ~0xffffU) || (ts->ctrl2 & ~0xc2ffU) ||
+	    readl(ts->base + AT550_STREAM))
+		return dev_err_probe(dev, -ENODEV, "unexpected TSC state\n");
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	input->name = "SiRF AT550 touchscreen";
+	input->id.bustype = BUS_HOST;
+	input->open = at550_ts_open;
+	input->close = at550_ts_close;
+	input_set_drvdata(input, ts);
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
+	input_set_abs_params(input, ABS_X, 0, 4095, 2, 0);
+	input_set_abs_params(input, ABS_Y, 0, 4095, 2, 0);
+	touchscreen_parse_properties(input, false, &ts->prop);
+	error = input_setup_polling(input, at550_ts_poll);
+	if (error)
+		return error;
+	input_set_poll_interval(input, 10);
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct of_device_id at550_ts_of_match[] = {
+	{ .compatible = "sirf,at550-ts" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at550_ts_of_match);
+
+static struct platform_driver at550_ts_driver = {
+	.probe = at550_ts_probe,
+	.driver = {
+		.name = "at550-ts",
+		.of_match_table = at550_ts_of_match,
+	},
+};
+module_platform_driver(at550_ts_driver);
+
+MODULE_DESCRIPTION("SiRF AT550 resistive touchscreen");
+MODULE_LICENSE("GPL");

-- 
2.56.1



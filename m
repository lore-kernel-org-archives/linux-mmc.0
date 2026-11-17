Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794920821;
	b=imB7+oFV4B6rlUFqyY500EA1DbzU/ruItyfHcvIx3ZZF8vSCFujE/OjpKO6wVVSt9lql
	 xKz976f41F2E5RVvGcp7pEc/rRldralHgaRauNAPvI4FUP3+EjgHefHPjK8g2OpPOqrT0
	 4MDz0NHyfy3fXje8lEDlFyz2l25t28bfjjVNZoGapT7qe9yiGFZkG7hrurYSQ8innIEdX
	 wdzC1Ekf1yDoFvMBfrnCZ91NxfqDHdiKJxm/OEO3rT6vyqphyR1OnIC/Q7fT5bCzm9vbo
	 nNsODL/lbCrOUQhpwdXmafHfDGagu4xkfE2i3kDR4o6biJJw+3PkAZE7tTuge+oMU/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920821;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BawjWYzTiTlbnn8nen+/fG+Daap0ZIN7b4Ci/SWVsco=;
	b=PkwOlD8Aw6oyX3nI2iWTC8F60uF2K5Cjj7DGyj3Upq8b84+D1Y3LJ8R4SKycbqGIRzoS
	 HmQDzKZxlkaJXkJpiarARZo8ZOf4AMf6nCyAkhs6nOyrwHznEkXozBs3KY46EBQ7XGtvF
	 HH5uY+0+QNabIQYUsgJQno/yTg/LubaSXAUHL7d0eLzBI1IF+c4EfRYEk2pyAmZnOv6s0
	 KOFK47qouQWEH+Y3ooN4gEQ52oiQIu1AEq7OT7cmWj321mYAmMesLbjN+QeveYtoFdfMj
	 vr9picytWpIwKIb9FEGFRt8JT7mpaLhM8Y1iT2FC3d/BqSXRpcoFJ3LTzRyYyxfjBXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh5rJ20i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BF606A8AE;
	Tue, 17 Nov 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh5rJ20i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794920821;
	b=MCfyV9yB9yaMb2Oq/VkIv8crGyZcNiQv0krETnSy6mjr6fr7YbJoLP3RYy8neeBBfR8k
	 66KWhKIsFkiHOYW4Ob1epOOMEd5Q9NnF7z3xvKEsgnAZDDYiilB0/NHdOKw8Ya6N/kF63
	 lXukGq9Ldm6+rlKRs0jovJPR11L47gt3o0ECU0pejTvJR8l0ItmPtfDx1HnTNGdMEYGam
	 jsw/3/ySc6Vjz6pYxjapyx2F0RRU77cLhBR5krUmYu++Rq+IbCojkpsmqTvLxQQQOi8NC
	 JLFsGQcOua6bZjMxechBilSFQsh2okQ6mGaBNf0t3O9o/n45n2UHqtdNT68hZELBTAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920821;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BawjWYzTiTlbnn8nen+/fG+Daap0ZIN7b4Ci/SWVsco=;
	b=1GlecLtpmCHLvMRKvic/45UkC+Q03hqwjNN5wuP/rJdLTxIB3nvH8SFsAGG9d40nEgJ3
	 txi1HzsusguwWVPsQIx+nHKJkLi8EEjtHnAitq8o8oVQXftWrle78qKNKqbaIAZo0WS8V
	 30HtPRnFO9idmotP/Hyy6NGJr4rcyh0yUptNf8yremLWvfplvmhG1YhDFndYOSXCjLVtI
	 0enrNAiOH8GH6nPr7C3uKeIHMV+Q1V+h8NRYqLml9fgfU+oIxSoqRjk8bRmyq4gNVQkmj
	 O/CMGTog6Hi3oi3l5wLTQEo2WZSOz+uUHOHRonDY7JEji1zcN01torGnbkH8mTnzbrw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6B4B81F000D0;
	Tue, 17 Nov 2026 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920821;
	bh=BawjWYzTiTlbnn8nen+/fG+Daap0ZIN7b4Ci/SWVsco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wh5rJ20ia4wAlUs7oG+pjDY29q8CJuSALtVZJHuvAhX6r8TeaHgI0Nv87LUG/48+A
	 KpQSAkBLAUHx+WfBO03msOb5xwg6rglRjCgbv30wiYgXLufGAOebN/cNhQE6OiLvok
	 T/coO3N3uREpuRQxYhfyltMxxkN+dPXr0Vwnhw1cWCtnkfDG9kQ0Gg/swEzdob0MAG
	 N2D/5eih8qQoVhUWXpzR43FeYV32WNFy89Uwd85zSibhMMZf3TmfFDNQIFY+7nRJn5
	 ozt7agJ97/Eb7Q9Q3ulnlQHHVY+HfKaCCwtbwOTOorep8peByifQRwebm6uci/I1+P
	 7IhbwedN4vEeg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1649B4A98F;
	Tue, 17 Nov 2026 13:06:59 +0000 (UTC)
From: yy-Local-LLM via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 22:06:55 +0900
Subject: [PATCH RFC 5/6] mmc: sdhci: add SiRF AT550 programmed-I/O support
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
Message-Id: <20261117-at550-rfc-v1-v1-5-5879573cb825@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794920817; l=4283;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=LwrBWxeSZ2XwQHF7WT1/41fBzwPAw/Ef7TwWxNi5nuY=;
 b=/dA5BtXKTrl9hH/6MpFGAowVS/75k0hiDq374kDE4duagqJAnScWgqBINbC62pVRhjF5Ixn3q
 p+YHmpDqMkPBfFfLaj/Cm/0v/oW4yeXWo7yeikbqQlXqVkhlvgSpMK4
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: yy-Local-LLM <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: yy-Local-LLM <yogo.0917.sabu@gmail.com>

Add a platform SDHCI host with PIO because CPU-to-controller DMA address
translation has not been validated. Reject unsupported
capability/version combinations and use the current managed host
allocation API. Board discovery and frequency restrictions are described
by the DT, rather than forcing removable-SD policy in the controller
driver.

Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                    |  1 +
 drivers/mmc/host/Kconfig       | 10 +++++++
 drivers/mmc/host/Makefile      |  2 ++
 drivers/mmc/host/sdhci-at550.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 441492230..347d46a20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25858,6 +25858,7 @@ F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
 F:	drivers/clocksource/timer-at550.c
 F:	drivers/input/touchscreen/at550-ts.c
 F:	drivers/irqchip/irq-at550.c
+F:	drivers/mmc/host/sdhci-at550.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 79bfc425e..72e7c279a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1125,3 +1125,13 @@ config MMC_LITEX
 	  module will be called litex_mmc.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_AT550
+	tristate "SiRF AT550 SDHCI host"
+	depends on MMC_SDHCI_PLTFM && OF
+	help
+	  Say Y to enable the AT550 removable SD host using programmed I/O.
+	  Firmware must configure the peripheral clock and pin multiplexing.
+	  DMA address translation is not supported by this initial driver.
+	  Card discovery and bus frequency are configured by the device tree.
+	  To build as a module, choose M; it will be called sdhci-at550.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index fd043afab..6f7b0dd14 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -115,3 +115,5 @@ endif
 
 obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
 sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
+
+obj-$(CONFIG_MMC_SDHCI_AT550) += sdhci-at550.o
diff --git a/drivers/mmc/host/sdhci-at550.c b/drivers/mmc/host/sdhci-at550.c
new file mode 100644
index 000000000..100a0fdb2
--- /dev/null
+++ b/drivers/mmc/host/sdhci-at550.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivalence. */
+#include <linux/module.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
+#include "sdhci-pltfm.h"
+static const struct sdhci_ops at550_sdhci_ops = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+static const struct sdhci_pltfm_data at550_sdhci_data = {
+	.ops = &at550_sdhci_ops,
+	.quirks = SDHCI_QUIRK_BROKEN_DMA | SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks2 = SDHCI_QUIRK2_NO_1_8_V,
+};
+static int at550_sdhci_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	u32 caps;
+	int ret;
+
+	host = sdhci_pltfm_init(pdev, &at550_sdhci_data, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if ((sdhci_readw(host, SDHCI_HOST_VERSION) & SDHCI_SPEC_VER_MASK) >
+	    SDHCI_SPEC_200 || !(caps & SDHCI_CLOCK_BASE_MASK)) {
+		ret = -ENODEV;
+		return ret;
+	}
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		return ret;
+	sdhci_get_property(pdev);
+	ret = sdhci_add_host(host);
+	if (!ret)
+		return 0;
+	return ret;
+}
+static void at550_sdhci_remove(struct platform_device *pdev)
+{
+	sdhci_pltfm_remove(pdev);
+}
+static const struct of_device_id at550_sdhci_of_match[] = {
+	{ .compatible = "sirf,at550-sdhci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at550_sdhci_of_match);
+static struct platform_driver at550_sdhci_driver = {
+	.probe = at550_sdhci_probe,
+	.remove = at550_sdhci_remove,
+	.driver = {
+		.name = "sdhci-at550",
+		.of_match_table = at550_sdhci_of_match,
+		.pm = &sdhci_pltfm_pmops,
+	},
+};
+module_platform_driver(at550_sdhci_driver);
+MODULE_DESCRIPTION("SiRF AT550 SDHCI PIO host");
+MODULE_LICENSE("GPL");

-- 
2.56.0



Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774429;
	b=DNSOlxHGbB/hQJ68Y1XzlWAtvC8JyVK9LLgf1ChC4yfPx0n6t11IY+zumQs+tujh0vla
	 JTcy/QZOSzYKnjVfHkLV3F3TU0zxANZUahpw2IAr/1Mr8m9QhYoVPb3902i9nLmLtZesn
	 rGnh6d+FN89gDfStTvrHkhYsoV4KQWXSfrxNhFHV8xUY6O1X8+R58VAakxhwBS7JvVKcV
	 0WCfpfHL1ddQD6Sh6Ez6gyusa4933eDRAQiI+MZyhb6gBHF7Vz8o/trM1J8gFtaUXWh+M
	 35/LQ/LWZzeUkR316aAyTlh87szLmwpLeZ+FyNrtSCRbtFiv6MreHZPOe115hkyaOTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=otKhYi7f1KYAID09Ba2fOl2QMPjPmlYRMKc9qtkUFAc=;
	b=WpuUKQ98cgSnIO44IDHHTm20pIRRzSFZIYqzyIJBbBShh9HbucoQFgAtW5h6ArkluSNn
	 IXfFyYSrWKDWdVG9rrFqTOfmD6HMjvPJeo1mNaJQiTAAu2LRZrv4Y+EUC0nFSJJi2xkWv
	 mHwBp6Ker1TovENCbsqvz2f0xBsv2s8JQl7KIUE3LrEyAQYqwUp4InMVFGy05sKF384Hp
	 USb2loqU6djUdUSCTp3XlIHjaJrD6cMNrLsWhBDuOt3ACOSjlPB9p/MMiY4NlmCnm856z
	 mt7pWjO6WyfIwNcbDn9c+Bx/lYCgEH0IW4HVlEFtkixhQXCKe+CyTuY+QZD1SYuTrNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNikTaDT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D860A5BD4;
	Fri, 27 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNikTaDT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774429;
	b=fzgZecten4ibPBo/aynIrSKM+ZVAfZ98x5MkEXrlzn2Jz1mv+FBoQAy1Eg/I3MIl3GUZ
	 MZDvUsVIOgYEAWDr9HoSZ33JH0oytq9PnkBN7TvfTLmjFnDImlPR/4UPPYVYHICgKCVdF
	 GzKlyGaWjTsmPvq8Z8+flFS+DPyhvSa9S9PRBTywXlX57FT96NzBsHATgeDS/oo/nHQoR
	 llSDw+h14Gx6bybxwA/XtFM1mIV4nxNFsxID6zzCVQKhIrBhsy7HbveIcfaAdvAIJeSW5
	 NLbBcd+9y0cLJE8/+PYAkEI4c80Auv5Zpsz8SwcHPBXErxKrw0fsgD7A8yX6DJVDVEg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=otKhYi7f1KYAID09Ba2fOl2QMPjPmlYRMKc9qtkUFAc=;
	b=ZviHf+5kM8fVWavdipadI9bVtvreO91qf4UEnJ0r6badbrn99glCqKBJ5D7pVnb8yySM
	 s9V2x4EDrC7uDTu0NVEoZpLTJl2idkrqGP2whK8rwvhri4JurtDnMYLi/npjy4VjF6nSL
	 w64brTpavWoC7L5ZORXQpWk0OcWmNZyun+8IwOwU0ncdxrc9F5y0ocPArY5LfLxdGAyEP
	 23lDHqWxc5uWprgv7xvVGY260tn3rpLJ0+iKAGnFpz4k9jPeBw3FS0J/bz86Qcn8YSiAe
	 UsHBXdt8KX0aBNc3Spf/bdkRXi6xBhzWlqmEOvNaIt61CjdEGKIZDm7CrVlFl/sdnDQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8C6F1F00A1E;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774429;
	bh=otKhYi7f1KYAID09Ba2fOl2QMPjPmlYRMKc9qtkUFAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NNikTaDTbDLYWvJR/g7+JnhW+sLcUmyq131Z80F6e7zcjuSkfTonf7/YZbJqNqDQw
	 2erqZpDBH1N1lP4VO7fj/JtIWRut3Ifz6xsOzrnIKr+GFDsgDbqo4zkvKDCF2iDvkX
	 HZ9gIZAjRLxgRbAEu5NPaQx6i6hlp0grMSr06zHfezjm4nEpKL2UW5rLMO6ZzN5shc
	 0barQEVHcIG/fUYEUxBui4r/lK3dolrgVwZfuGCDo9bPm1x1zGaQGjw7uYtrrzFIj1
	 aJfIC+EyoD64BDtmumBg/6Xyl1jB0Siqx8crDcHZIy+MP7ZcxxFYI1GtwtG/vNQ581
	 JdEApAB5lRzMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 08B604B713;
	Fri, 27 Nov 2026 10:13:23 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:11 +0900
Subject: [PATCH RFC v3 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
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
Message-Id: <20261127-at550-rfc-v1-v3-10-f2221008912b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=3663;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=zroMOlHblXPaJRW0XvRKrL7RwM+BR4h2/zPNcw5DK2Y=;
 b=rlDtAeNkTvi8vm6bH4zbOW+5ouocRpS8BdSbOofqm3ULLVwiOKqC95wdHMf/QeJ7mrWACXCQ0
 xOplD8EiZW0DSOMbx6CUE9IwG/zTpRodVK8z3BP6CgjlJ1sSziFQnAw
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add a platform SDHCI host driver for the SiRF AT550 using programmed
I/O, as CPU-to-controller DMA address translation is not yet validated.

Use sdhci_pltfm_init() with default platform ops and
sdhci_pltfm_remove(), leaving bus width, clock limits, and
card-discovery constraints to the device tree.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                    |  1 +
 drivers/mmc/host/Kconfig       | 10 +++++++++
 drivers/mmc/host/Makefile      |  2 ++
 drivers/mmc/host/sdhci-at550.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1164152dc..9d02a79a2 100644
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
index 000000000..c1f7399ad
--- /dev/null
+++ b/drivers/mmc/host/sdhci-at550.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivalence. */
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "sdhci-pltfm.h"
+
+static const struct sdhci_pltfm_data at550_sdhci_data = {
+	.quirks = SDHCI_QUIRK_BROKEN_DMA | SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks2 = SDHCI_QUIRK2_NO_1_8_V,
+};
+
+static int at550_sdhci_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	int ret;
+
+	host = sdhci_pltfm_init(pdev, &at550_sdhci_data, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		return ret;
+
+	sdhci_get_property(pdev);
+
+	return sdhci_add_host(host);
+}
+
+static const struct of_device_id at550_sdhci_of_match[] = {
+	{ .compatible = "sirf,at550-sdhci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at550_sdhci_of_match);
+
+static struct platform_driver at550_sdhci_driver = {
+	.probe = at550_sdhci_probe,
+	.remove = sdhci_pltfm_remove,
+	.driver = {
+		.name = "sdhci-at550",
+		.of_match_table = at550_sdhci_of_match,
+		.pm = &sdhci_pltfm_pmops,
+	},
+};
+module_platform_driver(at550_sdhci_driver);
+
+MODULE_DESCRIPTION("SiRF AT550 SDHCI PIO host");
+MODULE_LICENSE("GPL");

-- 
2.56.1



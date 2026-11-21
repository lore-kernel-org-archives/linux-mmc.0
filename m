Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795264998;
	b=VKJuPbrslMgrZN+J8xAxPVo7hBDUfZ5Cd/dFdUMVYBkQ3+Psv0TkUhUK5I5ujUku9nQZ
	 co27tNL9m4sZ7Zs4YjnO03Xqi9aMK8UyLjX64fgzCHNDNV+SyHQq4EG5PFLVfJ9sZPZHo
	 iPmMF56H75CM6omnQD/1mj3x8mZr0+ezdLQQDMbmDBIrSL8uI+U3Tni/b0D9xTXyq4L3P
	 1ULZDmiYJLUqgWaBCrAuU3Ad+xP/rinWU2IAVtr5NtG34iE8EgdkR9NkwaacBoBy+0/VA
	 28x1Dh5n2KmQdgzoSxStThFE7CPkyJ/TZTKvswn/cU96Q/y8zuwFt22Z10MNb3ACs0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264998;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=de/zgkDFGYSdLBTnqb+HXEzXLJe1FdmuCcE9kYLWjgI=;
	b=K/i1QbhYj4H1Ha83MuJvtnPgXwiKw6pi8kXviq5xDmq5VpOqhfJa5SeycA1bYqvWBkEU
	 VMxyStEJCqPoohkDQNm6R2CFUaDBTjAecCyLo69yQw0P6U5EqvtxyFa4Fyxk5BwHQKFXG
	 Xexh0dd0OxqIPifWKShVMajojmxzlg8emOXH8nABdgj4rXo2eIhQ9it5gI/J4PVIcUERd
	 hT8n8jZex0BdOs8NnmG2hj0vZtpSYWHzcU41DX9tinuPEGstkJdNRn55q6udJXbP137sw
	 cqKMybe/IqQA4pbQ2gJNy/dCXVo/aTr5EoBwp9XwuxSCyMz5AvBGhN8tNScq1JiHwqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfjQ8HsH;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D160A2613;
	Sat, 21 Nov 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfjQ8HsH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264997;
	b=eHHTg5wJ8yxyNW442BMJmyJUXprTi5T0/+Wa091TSjx0nYXncHL4jERKhAbW9KGCHUlY
	 TYpLwS1tNeR6bU0iVzBwMaGkcHq0Zkc9Fv9MxoUIorVM4wNVyv7gkRfOYqp7CqcSKsk7f
	 l3LGHWBnbOSjQ+f2f7fHDbfgUpLkkmH0x3okUCp895y88DU2cKPKibn6ch0yDJC5GAS/F
	 CW+z4xmCYLChhVmR7Ur6AZ/yQX2cedZ5ndskEvOdb1u2vNc7AcgH0NbeauoTrePuH8Vp1
	 ioKR/E8UkLT7IMga231gl0/KC2mj2SMFJFIsvxulAscQTc2pnbndRQutaRYVkmEB5sg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264997;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=de/zgkDFGYSdLBTnqb+HXEzXLJe1FdmuCcE9kYLWjgI=;
	b=Y0eOyjLpvEde/zVrwCk6Rw218bWsa5VOMTO7diLTeAg71GUQGbIarcPfqp18IwVZlS1q
	 N8gKpb0piO6c3TQHmUY+RiChn5UeZGlMNCMW2iSLPk6yxyimNa0+NTfy50WIBH28AUpFe
	 CR4zqsV0hFBt5DAD88Wd8Iuh4t9zxqrLHz8cuqUEuM/MxqFNm9eb2mkO5ikkow5l6fGbW
	 8jRZW99V2vuao9RwZprklfYxbaa5s6SzvqqpC/v8d5hgfayOFG0GT9Hbr1/YVh8KCC59E
	 /S60qFyul+TJ5laQpG5anSAuC+nDqVMhNHg1ckLIbjg7xx+PnrGmk8U7nucc7UsRglQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5F6521F000E0;
	Sat, 21 Nov 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264997;
	bh=de/zgkDFGYSdLBTnqb+HXEzXLJe1FdmuCcE9kYLWjgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CfjQ8HsHOb++jn8h4ZdL4G1coTf5ic9Yy3UCu9ihe0lTup0pfbQ7s9e1Zm1Ra76gy
	 RoYRxu9GPq3IeDNPWZodiODUd33mKo3SEtQJ24W82GpxT7dNfnIMkeLZvF2jj5Y1GR
	 1cTI9igu6ndZy82HoeYIySEq0rJW2WxKT+vkQGYsMxUMmBHCZ9Han9Xe/VH0Fk0ESW
	 U4sYzYTzqX2EwHswm/f0mjKhqQsoJu8em7WCQDEpdUl1KnuqFzKK2aGxqMgFPGENw5
	 z4mPVxwWFop80yWppqidQJJ6SJfBXMfqRA4Oww2E48ZlhHQydyjrjP4Q7D3EreyGP/
	 Oq8w+LkJZ+FlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E8C0B4BC5A;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:20 +0900
Subject: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
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
Message-Id: <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=3700;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=lLUcutGX6X4e7Y1C/cRp2+SQBhJ32ubOSzrRcMWPbOc=;
 b=v8DAdauk7XLOkFUVJ5JH3CmGSOAkceaCiwFKutb1k7uQ9l4PY0RQREgAM4lgKeBksqHFm2+o7
 QP3rzsSg6sgDz6tj2AXVG7CNK+hfpsO5ZCqcczyCS2U96T5fAH0Z2di
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
 drivers/mmc/host/sdhci-at550.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

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
index 000000000..11c9de0c9
--- /dev/null
+++ b/drivers/mmc/host/sdhci-at550.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivalence. */
+#include <linux/mmc/host.h>
+#include <linux/mod_devicetable.h>
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
2.56.0



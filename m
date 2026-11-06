Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957600;
	b=IXW6xuXaF2p9Zz7XLwBzX9QZhpxGc0jUj0N3ZRm8L9j773a+8PYsKIkqwWMEl+B+3Rwi
	 As5zy+4hPA7jo1QfcsWUUlqIW7HsLjNsZvUtdBgEWvNGT+q2ZBIWA4T6JwOprZCA2NM7M
	 xKc+ISL5oItHjrmaWgxqurTYcQO6sbq4EO18u0rgvqai19HEis6+tZLz3ysQ/1blSVMsZ
	 6rCxmBIVfG7GvFLZ1UswnMh6xYTwJtgjgCXynnHdjj0X9yrZn9jd8WO4acjrVbPy4Tnmh
	 42wLtwj2r6rAeJbE+Bnxyj6v1bhbwH+aq86/mhvtIlqKf6QSXfBJRrzTfNYJ/G6lquw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957600;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=xNxhGNlUd/QAYjwS9+p2YRVic4RXKhAhrhTTLAcBT1A=;
	b=Yriywgh6qWGc0kELpEEsxP48h1HNVLWjd/sSNCYiYUdVWNFCcQL7ACWSAnbBn47bMMEU
	 O2tkFgw+lYM5nJvx50f3pdp+JKFtVLjfgIVaMIoNMi5CYhoUcUyq4MMWzEaK0nF3tEhNX
	 o88MIodVke0r6L6bzwlkk3HfcmHECedvo0ob6GVXPxsR4qaUwdshc8jXQHu96LgrSZeVu
	 n+RMSf6Ennuo8DPmstc0CNMuUnc1mBeLOb1Usp+E/xRcXGXLXvTrsxfhnaSSHAQY6QtGx
	 +uGM11VUeGUdDv9bYYkXLqFoxqj+laZfugm2h9VzNp0TRvdfvvIkbXZxQm7XRledYAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qzjngm6W;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA634606D83D;
	Fri,  6 Nov 2026 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA634606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qzjngm6W
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 253DEC69168;
	Fri,  6 Nov 2026 09:33:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 843B35FFBC;
	Fri,  6 Nov 2026 09:33:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2CAD10329258;
	Fri,  6 Nov 2026 10:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xNxhGNlUd/QAYjwS9+p2YRVic4RXKhAhrhTTLAcBT1A=;
	b=qzjngm6WnCz2RSJjNd87zanbSOH2E4/m7iNJaRu8O8NApdI6HB0JwSC9zihCXzReroWlBy
	YbEr4t/R5C8POfP7mahglsIZLkb/jgbiht0kTGtezBFmH62HZx8bBVObq9zEUSYr2uCKn7
	OPsvspCzw7u0i+M5RJygf1N7C+c/GORrrW5f0oREYTS7xvfuFqeluPN0vC9w7IBImagl1I
	tvWtXPB6yRp/oxW/Z3wF3A41LIHDsu9DvFr7FvQTpdWc3eYenyQiltaVyrB9ADHBI8jAxK
	miLKg/TcH/bOQIYypD7IvoCCmyertaDVNtwFs3eR+bX+MJM+qpe1zItVfCFxrg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:19 +0100
Subject: [PATCH 22/25] phy: metanoia: add USB2 PHY driver
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-22-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Add a minimal reset-only PHY provider for the Metanoia MT2824 USB2 PHY.
It deasserts the PHY reset required by the DWC2 USB controller on init
and asserts it again on exit.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/phy/Kconfig             |  1 +
 drivers/phy/Makefile            |  1 +
 drivers/phy/metanoia/Kconfig    | 16 ++++++++
 drivers/phy/metanoia/Makefile   |  3 ++
 drivers/phy/metanoia/phy-usb2.c | 88 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 105fbe408aa2..73ef61f1f53d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -184,6 +184,7 @@ source "drivers/phy/intel/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
 source "drivers/phy/mediatek/Kconfig"
+source "drivers/phy/metanoia/Kconfig"
 source "drivers/phy/microchip/Kconfig"
 source "drivers/phy/motorola/Kconfig"
 source "drivers/phy/mscc/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c6dd02003bbe..57991b50978c 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
 					   lantiq/	\
 					   marvell/	\
 					   mediatek/	\
+					   metanoia/	\
 					   microchip/	\
 					   motorola/	\
 					   mscc/	\
diff --git a/drivers/phy/metanoia/Kconfig b/drivers/phy/metanoia/Kconfig
new file mode 100644
index 000000000000..b8a49085bb95
--- /dev/null
+++ b/drivers/phy/metanoia/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for Metanoia platforms
+#
+
+config PHY_METANOIA_USB2
+	tristate "Metanoia USB2 PHY reset support"
+	depends on OF && (ARCH_METANOIA || COMPILE_TEST)
+	depends on RESET_CONTROLLER
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB2 PHY reset block that is part
+	  of Metanoia SoCs.
+
+	  This driver only toggles the reset line of the PHY needed by
+	  the DWC2 USB controller.
diff --git a/drivers/phy/metanoia/Makefile b/drivers/phy/metanoia/Makefile
new file mode 100644
index 000000000000..ce1b5f8af15d
--- /dev/null
+++ b/drivers/phy/metanoia/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PHY_METANOIA_USB2)	+= phy-usb2.o
diff --git a/drivers/phy/metanoia/phy-usb2.c b/drivers/phy/metanoia/phy-usb2.c
new file mode 100644
index 000000000000..b06d423eada7
--- /dev/null
+++ b/drivers/phy/metanoia/phy-usb2.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc.
+ *
+ * Author: Jun Chang <jun.chang@metanoia-comm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+struct metanoia_usb2phy {
+	struct reset_control *reset;
+};
+
+static int metanoia_usb2phy_init(struct phy *phy)
+{
+	struct metanoia_usb2phy *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		dev_err(&phy->dev, "failed to reset phy: %d\n", ret);
+
+	return ret;
+}
+
+static int metanoia_usb2phy_exit(struct phy *phy)
+{
+	struct metanoia_usb2phy *priv = phy_get_drvdata(phy);
+
+	return reset_control_assert(priv->reset);
+}
+
+static const struct phy_ops metanoia_usb2phy_ops = {
+	.init = metanoia_usb2phy_init,
+	.exit = metanoia_usb2phy_exit,
+	.owner = THIS_MODULE,
+};
+
+static int metanoia_usb2phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct metanoia_usb2phy *priv;
+	struct phy *phy;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->reset = devm_reset_control_get_exclusive(dev, "usb2-phy");
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(dev, PTR_ERR(priv->reset),
+				     "failed to get usb2-phy reset\n");
+
+	phy = devm_phy_create(dev, NULL, &metanoia_usb2phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "failed to create usb2 phy\n");
+
+	phy_set_drvdata(phy, priv);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id metanoia_usb2phy_of_match[] = {
+	{ .compatible = "metanoia,mt2824-usb2-phy" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, metanoia_usb2phy_of_match);
+
+static struct platform_driver metanoia_usb2phy_driver = {
+	.probe = metanoia_usb2phy_probe,
+	.driver = {
+		.name = "metanoia-usb2-phy",
+		.of_match_table = metanoia_usb2phy_of_match,
+	},
+};
+module_platform_driver(metanoia_usb2phy_driver);
+
+MODULE_DESCRIPTION("Metanoia USB2 PHY driver");
+MODULE_AUTHOR("Jun Chang <jun.chang@metanoia-comm.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0


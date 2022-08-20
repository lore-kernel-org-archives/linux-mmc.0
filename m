Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51BBC32772
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiHTT7b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiHTT7C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:59:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428D3B96C
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x15so6150813pfp.4
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=LU92Q2K7j5de49rLx4/oeszq80ftTh5p9/LMGWQC0I0=;
        b=4E9UZ4khHsfbwcWdeqRo0cGO3bLTZmLWdPVw21Pb5aXKMASCUbvANinNmWIxEaTNI2
         3rdD2B+Ru8b4SfIkoXnTFUQMEC+Rem32dzuIJBnx2nuejlhtocBaQ6b31IOjOhRmolsT
         RyOqFJ2oUpTzDtSfE3gg7KnGHf86K1l4PXQe4M08nCZQiFk2rJ6GJicGjep5UrTAm93Q
         6EUE+kjjoSz8ASsCW26sUiQaihp1wcfAH5uQ7aq2VUuZqY76Y68ASt/pC4JrNTulOVH7
         vwZFgkyqd3yW1YZUoAzFcMa8xXoNgv8CqDyW1G7O7Ge5TfeRNHztJ1wdnxESTm93Sacs
         kN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=LU92Q2K7j5de49rLx4/oeszq80ftTh5p9/LMGWQC0I0=;
        b=8O9Y1IZbc1/9DGYh2wUBEQZhpMfOdQTt8jxvP1qbChblI0eR/aB8nX1ZGMPDA6MV3t
         AQX6F6LHMSm5eCaxRpNKc20GSsDEgaTtcAye4uXdHDUzX48Y2aGuLD09ysgiKmRmsVYH
         L+goPVulfqp37WJ/FbR9IFS3XiCgXX3GvZPLDGs7cZLQp+86LqxQ+y0K2nsOxYQNxkpK
         7bthmaJ0Ug0tUWQSusKuy6bRUlmw8eq6ctrqTBgYg8PfBQxjMSi3kmlRT/ato+knlaIG
         gSZYtF3XYqboCL/tCkKWhTnEOixIdRkxhrYwcuVpzpV0HKrwE7qctTM77orPkCB3WtzF
         idEA==
X-Gm-Message-State: ACgBeo3t1hTvcsL275c2WErfitkEBVaOt1e8XjOUHomDVHDoPaDdWd+n
        8WLrhBU2QfTK/Wo+2vBHBLfEuw==
X-Google-Smtp-Source: AA6agR66oTJzWmeG7LAj7ZK2COy1RNfjGHtLHnxrvQiNVDRnnOSNpeQ9d8iKOcnZcKHEAfWSxlnxUA==
X-Received: by 2002:a65:4c06:0:b0:429:71e4:216 with SMTP id u6-20020a654c06000000b0042971e40216mr10752069pgq.163.1661025532582;
        Sat, 20 Aug 2022 12:58:52 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:52 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 15/17] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
Date:   Sat, 20 Aug 2022 12:57:48 -0700
Message-Id: <20220820195750.70861-16-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

This patch adds the reset controller functionality for the
AMD Pensando Elba System Resource Chip.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/reset/Kconfig        |  9 +++++
 drivers/reset/Makefile       |  1 +
 drivers/reset/reset-elbasr.c | 77 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/reset/reset-elbasr.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 806773e88832..04b700c90ce4 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
 	  BCM7216.
 
+config RESET_ELBASR
+	tristate "Pensando Elba System Resource reset controller"
+	depends on MFD_PENSANDO_ELBASR || COMPILE_TEST
+	help
+	  This option enables support for the external reset functions
+	  on the Pensando Elba System Resource Chip.  Reset control
+	  of peripherals is accessed over SPI to the system resource
+	  chip device registers using CS0.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cd5cf8e7c6a7..9e6b095ee63a 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
+obj-$(CONFIG_RESET_ELBASR) += reset-elbasr.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
new file mode 100644
index 000000000000..ab5d49f5e6a7
--- /dev/null
+++ b/drivers/reset/reset-elbasr.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/pensando-elbasr.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+struct elbasr_reset {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+};
+
+static inline struct elbasr_reset *to_elbasr_rst(struct reset_controller_dev *rc)
+{
+	return container_of(rc, struct elbasr_reset, rcdev);
+}
+
+static int elbasr_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct elbasr_reset *elbar = to_elbasr_rst(rcdev);
+
+	return regmap_update_bits(elbar->regmap, ELBASR_CTRL0_REG, BIT(6), BIT(6));
+}
+
+static int elbasr_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct elbasr_reset *elbar = to_elbasr_rst(rcdev);
+
+	return regmap_update_bits(elbar->regmap, ELBASR_CTRL0_REG, BIT(6), 0);
+}
+
+static const struct reset_control_ops elbasr_reset_ops = {
+	.assert	= elbasr_reset_assert,
+	.deassert = elbasr_reset_deassert,
+};
+
+static int elbasr_reset_probe(struct platform_device *pdev)
+{
+	struct elbasr_data *elbasr = dev_get_drvdata(pdev->dev.parent);
+	struct elbasr_reset *elbar;
+
+	elbar = devm_kzalloc(&pdev->dev, sizeof(struct elbasr_reset),
+			     GFP_KERNEL);
+	if (!elbar)
+		return -ENOMEM;
+
+	elbar->rcdev.owner = THIS_MODULE;
+	elbar->rcdev.nr_resets = ELBASR_NR_RESETS;
+	elbar->rcdev.ops = &elbasr_reset_ops;
+	elbar->rcdev.of_node = pdev->dev.of_node;
+	elbar->regmap = elbasr->elbasr_regs;
+
+	platform_set_drvdata(pdev, elbar);
+
+	return devm_reset_controller_register(&pdev->dev, &elbar->rcdev);
+}
+
+static const struct of_device_id elba_reset_dt_match[] = {
+	{ .compatible = "amd,pensando-elbasr-reset", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver elbasr_reset_driver = {
+	.probe	= elbasr_reset_probe,
+	.driver = {
+		.name = "pensando_elbasr_reset",
+		.of_match_table	= elba_reset_dt_match,
+	},
+};
+builtin_platform_driver(elbasr_reset_driver);
-- 
2.17.1


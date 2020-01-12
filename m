Return-Path: <SRS0=SKJ7=3B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9449FC33CA8
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Jan 2020 00:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5276820866
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Jan 2020 00:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZRgUYoXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgALAZZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:25:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55124 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbgALAZZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jan 2020 19:25:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so5839364wmj.4;
        Sat, 11 Jan 2020 16:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VdRKjItMpumgPEbU2M/gS1dTA+2qT6+UNLOZfpz4CY=;
        b=ZRgUYoXsvppeu9aw6D+lrz1iTB1jmm9E0gkoVkF7OVrU3eN0ZteuWZWGY0JbNFnhh6
         NWSsM+Jc87Gwqsk1INbY929UI5epVCg6YfCia6Mf5nO9/hsi14sUAajgmj1AMcFqeG+R
         FrzDT/+3tkXdJsaofZ8fodL9J47xbxWnfoRS+u+c+hT4XK1nFvnF9HOEE9HNcvkRSxMU
         xPlSOLpL5AfhHXiH46lOocOICK6vLngJEhoLH9yHtfqelFfsnoHbYoQWpGrzfC9tk1mz
         ka7yqzDzP758umhpVAvB6AlgEQ7El9HgyeYz0E3a3Bqb4whi79d/9G5ESfG/1SMZH0j1
         Ma+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VdRKjItMpumgPEbU2M/gS1dTA+2qT6+UNLOZfpz4CY=;
        b=NI/6ixeyk9ZZmBYUQhtnkrTSMoyu5xn5uvrN0jWjEfR/JrUaoVEqFQh8JtpQkW+l3a
         7Mj/ATAx6oCy9bIaAA5QZwKjKWposwhOmDADtKFCVqJAQhi4Tzs8+enjYiTmkqSP/Lp3
         EB+FcpXzWannI079KlvVmPYA6jg8rF1K2v5medpeJ0SFDRdely83sxgAyYMj3CQCfJA4
         t1JeYAmcQIAytOHk872eO1pNfSavSV1TxMW/wJoAlRuEV6ay8EDu9sghp2arVPm/bsN4
         meXhluqH7Z2S4Opq0DQY1DP1cKJ7zh7ndpQ5L6kxHUP75bRcsJ4u1ryFprc4RhgvqLFh
         uKWQ==
X-Gm-Message-State: APjAAAW/Pb6rmorrQW406LUUqUsmDmdtK7CLNL7zf4kvp4zIu/Q5Wg+S
        EQU2MMWtjGx6RWtV+bY8Gy0=
X-Google-Smtp-Source: APXvYqyQVIntHVKZIibeZHGPgSR0YMD0CeoJtnMcEPSlpwN0OsWd7gxeVOlO+jVkP/txUKXy6SSLNQ==
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr12228413wmd.77.1578788721667;
        Sat, 11 Jan 2020 16:25:21 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id t5sm8407389wrr.35.2020.01.11.16.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:25:21 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 2/3] clk: meson: add a driver for the Meson8/8b/8m2 SDHC clock controller
Date:   Sun, 12 Jan 2020 01:24:58 +0100
Message-Id: <20200112002459.2124850-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
References: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHC (MMC) controller embeds a clock controller inside one of the
SDHC registers. The outputs of thisclock controller are dedicated to the
SDHC controller.

Implement a dedicated clock controller driver so we can keep all the
clock specific logic outside of the MMC controller driver. There is no
dedicated clock controller OF node because the hardware is a big SDHC IP
block with an embedded clock controller (so the .dts doesn't need a
separate clock controller node). Instead this driver re-uses the regmap
as registered by the (platform_device) parent.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/Kconfig         |   9 ++
 drivers/clk/meson/Makefile        |   1 +
 drivers/clk/meson/meson-mx-sdhc.c | 212 ++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/clk/meson/meson-mx-sdhc.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index dabeb435d067..8769335d2d46 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -53,6 +53,15 @@ config COMMON_CLK_MESON8B
 	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
 	  want peripherals and CPU frequency scaling to work.
 
+config COMMON_CLK_MESON_MX_SDHC
+	tristate "Meson MX SDHC MMC Clock Controller Driver"
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_REGMAP
+	help
+	  Support for the SDHC clock controller on Amlogic Meson8/8b/8m2 SoCs
+	  devices. Say Y or M if you want to use the SDHC MMC controller.
+	  Otherwise say N.
+
 config COMMON_CLK_GXBB
 	bool
 	depends on ARCH_MESON
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 6eca2a406ee3..b71c7ae78dbd 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
+obj-$(CONFIG_COMMON_CLK_MESON_MX_SDHC) += meson-mx-sdhc.o
diff --git a/drivers/clk/meson/meson-mx-sdhc.c b/drivers/clk/meson/meson-mx-sdhc.c
new file mode 100644
index 000000000000..b98a35d99f65
--- /dev/null
+++ b/drivers/clk/meson/meson-mx-sdhc.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Meson SDHC clock controller
+ *
+ * Copyright (C) 2019 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ */
+
+#include <dt-bindings/clock/meson-mx-sdhc-clkc.h>
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "clk-regmap.h"
+#include "clk-pll.h"
+
+#define MESON_SDHC_CLKC			0x10
+
+static const struct clk_regmap meson_mx_sdhc_src_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = MESON_SDHC_CLKC,
+		.mask = 0x3,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sdhc_src_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .fw_name = "clkin0", .index = -1, },
+			{ .fw_name = "clkin1", .index = -1, },
+			{ .fw_name = "clkin2", .index = -1, },
+			{ .fw_name = "clkin3", .index = -1, },
+		},
+		.num_parents = 4,
+	},
+};
+
+static const struct clk_div_table meson_mx_sdhc_div_table[] = {
+	{ .div = 6, .val = 5, },
+	{ .div = 8, .val = 7, },
+	{ .div = 9, .val = 8, },
+	{ .div = 10, .val = 9, },
+	{ .div = 12, .val = 11, },
+	{ .div = 16, .val = 15, },
+	{ .div = 18, .val = 17, },
+	{ .div = 34, .val = 33, },
+	{ .div = 142, .val = 141, },
+	{ .div = 850, .val = 849, },
+	{ .div = 2126, .val = 2125, },
+	{ .div = 4096, .val = 4095, },
+	{ /* sentinel */ }
+};
+
+static const struct clk_regmap meson_mx_sdhc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = MESON_SDHC_CLKC,
+		.shift = 0,
+		.width = 12,
+		.table = meson_mx_sdhc_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sdhc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "sdhc_src_sel", .index = -1, },
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_regmap meson_mx_sdhc_mod_clk_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MESON_SDHC_CLKC,
+		.bit_idx = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sdhc_mod_clk_on",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "sdhc_div", .index = -1, },
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE,
+	},
+};
+
+static const struct clk_regmap meson_mx_sdhc_tx_clk_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MESON_SDHC_CLKC,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sdhc_tx_clk_on",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "sdhc_div", .index = -1, },
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE,
+	},
+};
+
+static const struct clk_regmap meson_mx_sdhc_rx_clk_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MESON_SDHC_CLKC,
+		.bit_idx = 13,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sdhc_rx_clk_on",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "sdhc_div", .index = -1, },
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+	},
+};
+
+static const struct clk_regmap meson_mx_sdhc_sd_clk_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MESON_SDHC_CLKC,
+		.bit_idx = 12,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sdhc_sd_clk_on",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "sdhc_div", .index = -1, },
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+	},
+};
+
+static const struct clk_regmap *meson_mx_sdhc_clk_regmaps[] = {
+	[SDHC_CLKID_SRC_SEL]	= &meson_mx_sdhc_src_sel,
+	[SDHC_CLKID_DIV]	= &meson_mx_sdhc_div,
+	[SDHC_CLKID_MOD_CLK]	= &meson_mx_sdhc_mod_clk_en,
+	[SDHC_CLKID_SD_CLK]	= &meson_mx_sdhc_sd_clk_en,
+	[SDHC_CLKID_TX_CLK]	= &meson_mx_sdhc_tx_clk_en,
+	[SDHC_CLKID_RX_CLK]	= &meson_mx_sdhc_rx_clk_en,
+};
+
+#define MESON_MX_SDHC_NUM_CLKS ARRAY_SIZE(meson_mx_sdhc_clk_regmaps)
+
+static int meson_mx_sdhc_clkc_probe(struct platform_device *pdev)
+{
+	struct device *parent = pdev->dev.parent;
+	struct clk_hw_onecell_data *onecell_data;
+	struct clk_regmap *clk_regmap;
+	struct regmap *regmap;
+	int i, ret;
+
+	regmap = dev_get_regmap(parent, NULL);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_regmap = devm_kcalloc(parent, sizeof(*clk_regmap),
+				  MESON_MX_SDHC_NUM_CLKS, GFP_KERNEL);
+	if (!clk_regmap)
+		return -ENOMEM;
+
+	onecell_data = devm_kzalloc(parent,
+				    struct_size(onecell_data, hws,
+						MESON_MX_SDHC_NUM_CLKS),
+				    GFP_KERNEL);
+	if (!onecell_data)
+		return -ENOMEM;
+
+	for (i = 0; i < MESON_MX_SDHC_NUM_CLKS; i++) {
+		memcpy(&clk_regmap[i], meson_mx_sdhc_clk_regmaps[i],
+		       sizeof(*clk_regmap));
+
+		clk_regmap[i].map = regmap;
+		onecell_data->hws[i] = &clk_regmap[i].hw;
+
+		ret = devm_clk_hw_register(parent, onecell_data->hws[i]);
+		if (ret) {
+			dev_err(parent,
+				"Registration of SDHC clock %d failed\n", i);
+			return ret;
+		}
+	}
+
+	onecell_data->num = MESON_MX_SDHC_NUM_CLKS;
+
+	return devm_of_clk_add_hw_provider(parent, of_clk_hw_onecell_get,
+					   onecell_data);
+}
+
+static const struct platform_device_id meson_mx_sdhc_clkc_ids[] = {
+	{ "meson8-sdhc-clkc" },
+	{ "meson8b-sdhc-clkc" },
+	{ "meson8m2-sdhc-clkc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, meson_mx_sdhc_clkc_ids);
+
+static struct platform_driver meson_mx_sdhc_clkc_driver = {
+	.id_table	= meson_mx_sdhc_clkc_ids,
+	.probe		= meson_mx_sdhc_clkc_probe,
+	.driver		= {
+		.name	= "meson-mx-sdhc-clkc",
+	},
+};
+module_platform_driver(meson_mx_sdhc_clkc_driver);
+
+MODULE_DESCRIPTION("Amlogic Meson8/8b/8m2 SDHC clock controller driver");
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.1


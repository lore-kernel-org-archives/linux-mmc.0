Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AD9C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 10:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A686611AC
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 10:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhEFKHH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 06:07:07 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:30082 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhEFKHA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 06:07:00 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1469pQMd024637;
        Thu, 6 May 2021 17:51:26 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 18:03:13 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v3 2/5] ARM: dts: aspeed: ast2600evb: Add comment for gpio regulator of sdhci
Date:   Thu, 6 May 2021 18:03:09 +0800
Message-ID: <20210506100312.1638-3-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210506100312.1638-1-steven_lee@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1469pQMd024637
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the description for describing the AST2600-A2 EVB reference design of
GPIO regulators.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 2772796e215e..1ae0facc3d5f 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -104,6 +104,21 @@
 	status = "okay";
 };
 
+/*
+ * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
+ * toggled by GPIO pins.
+ * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
+ * power load switch that providing 3.3v to sdhci0 vdd, GPIOV1 is connected to
+ * a 1.8v and a 3.3v power load switch that providing signal voltage to
+ * sdhci0 bus.
+ * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
+ * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
+ * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
+ * sdhci0 signal voltage becomes 1.8v.
+ * AST2600-A2 EVB also support toggling signal voltage for sdhci1.
+ * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
+ * as power-switch-gpio.
+ */
 &emmc {
 	non-removable;
 	bus-width = <4>;
-- 
2.17.1


From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 12/12] arm64: configs: enable SDHCI driver for Xenon
Date: Tue, 13 Dec 2016 18:48:41 +0100
Message-ID: <8ec71e7c1aa877a8189862bc4b74d05fee7b413d.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34892 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934412AbcLMRst (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2016 12:48:49 -0500
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>

This patch enables the driver for the SDHCI controller found on the
Marvell Armada 3700 and 7K/8K ARM64 SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0c1f1c..2d1f5ee62b18 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -353,6 +353,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_SDHCI_XENON=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
git-series 0.9.1

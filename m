From: <patrice.chotard@st.com>
Subject: [PATCH v3 13/14] ARM: configs: stm32: Enable EXT3_FS support
Date: Thu, 18 Jan 2018 15:34:29 +0100
Message-ID: <1516286070-24927-14-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36967 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756640AbeAROgM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jan 2018 09:36:12 -0500
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>

From: Patrice Chotard <patrice.chotard@st.com>

Enable EXT3_FS support to be able to read rootfs from MMC partition
formatted in EXT2/3/4 .

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none


 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 8b64a9e..b736823 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -72,6 +72,7 @@ CONFIG_STM32_MDMA=y
 CONFIG_IIO=y
 CONFIG_STM32_ADC_CORE=y
 CONFIG_STM32_ADC=y
+CONFIG_EXT3_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-- 
1.9.1


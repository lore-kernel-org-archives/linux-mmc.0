From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 5/9] mmc: mmci: add STM32 variant
Date: Tue,  8 Nov 2016 14:43:41 +0100
Message-ID: <1478612625-23256-6-git-send-email-andrea.merello@gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34070 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbcKHNo1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 08:44:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id p190so22760987wmp.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2016 05:44:26 -0800 (PST)
In-Reply-To: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>

STM32 mcu has a SDIO controller that looks like an ARM pl810.
This patch adds the STM32 variant so that mmci driver supports it.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/mmc/host/mmci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 170c78a..3e67cdd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -221,6 +221,23 @@ static __maybe_unused struct variant_data variant_ux500v2 = {
 	.has_pad_config		= true,
 };
 
+static __maybe_unused struct variant_data variant_stm32 = {
+	.fifosize		= 32 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.datalength_bits	= 24,
+	.datactrl_mask_sdio	= MCI_ST_DPSM_SDIOEN,
+	.st_sdio		= true,
+	.st_clkdiv		= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
+	.f_max			= 48000000,
+	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
+};
+
 static __maybe_unused struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -1981,6 +1998,7 @@ module_amba_driver(mmci_driver);
 #endif
 
 static const struct of_device_id mmci_pltfm_match[] = {
+	{ .compatible = "st,stm32f4xx-sdio", .data = &variant_stm32},
 	{},
 };
 
-- 
2.7.4


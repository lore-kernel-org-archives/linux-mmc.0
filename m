From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 5/9] mmc: mmci: add STM32 variant
Date: Tue, 10 Jan 2017 09:42:12 +0100
Message-ID: <1484037736-25029-6-git-send-email-andrea.merello@gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36002 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030935AbdAJImw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:42:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id r126so7671460wmr.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 00:42:52 -0800 (PST)
In-Reply-To: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

STM32 mcu has a SDIO controller that looks like an ARM pl810.
This patch adds the STM32 variant so that mmci driver supports it.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/mmc/host/mmci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c581b81..88a350b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -235,6 +235,23 @@ static __maybe_unused struct variant_data variant_ux500v2 = {
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
+	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
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
@@ -2033,6 +2050,7 @@ static struct amba_driver mmci_driver = {
 #endif
 
 static const struct of_device_id mmci_pltfm_match[] = {
+	{ .compatible = "st,stm32f4xx-sdio", .data = &variant_stm32},
 	{},
 };
 
-- 
2.7.4


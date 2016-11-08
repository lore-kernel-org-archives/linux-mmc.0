From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 3/9] mmc: mmci: don't pretend all variants to have MCI_STARBITERR flag
Date: Tue,  8 Nov 2016 14:43:39 +0100
Message-ID: <1478612625-23256-4-git-send-email-andrea.merello@gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32847 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbcKHNoX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 08:44:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so22718124wmu.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2016 05:44:23 -0800 (PST)
In-Reply-To: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>

This patch prepares for supporting the STM32 variant, that has no such bit
in the status register.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/mmc/host/mmci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b1dfde3..0c629e3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -106,6 +106,7 @@ struct variant_data {
 	bool			qcom_fifo;
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
+	bool			has_start_err;
 };
 
 static __maybe_unused struct variant_data variant_arm = {
@@ -115,6 +116,7 @@ static __maybe_unused struct variant_data variant_arm = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo = {
@@ -123,6 +125,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo = {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -132,6 +135,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_u300 = {
@@ -147,6 +151,7 @@ static __maybe_unused struct variant_data variant_u300 = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_nomadik = {
@@ -163,6 +168,7 @@ static __maybe_unused struct variant_data variant_nomadik = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500 = {
@@ -182,6 +188,7 @@ static __maybe_unused struct variant_data variant_ux500 = {
 	.pwrreg_clkgate		= true,
 	.busy_detect		= true,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500v2 = {
@@ -203,6 +210,7 @@ static __maybe_unused struct variant_data variant_ux500v2 = {
 	.pwrreg_clkgate		= true,
 	.busy_detect		= true,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_qcom = {
@@ -221,6 +229,7 @@ static __maybe_unused struct variant_data variant_qcom = {
 	.explicit_mclk_control	= true,
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
+	.has_start_err		= true,
 };
 
 static int mmci_card_busy(struct mmc_host *mmc)
@@ -909,8 +918,9 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		return;
 
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
-		      MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+	if (status & (MCI_DATACRCFAIL | MCI_DATATIMEOUT |
+			(host->variant->has_start_err ? MCI_STARTBITERR : 0) |
+			MCI_TXUNDERRUN | MCI_RXOVERRUN)) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-- 
2.7.4


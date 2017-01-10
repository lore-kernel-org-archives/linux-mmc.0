From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 3/9] mmc: mmci: don't pretend all variants to have MCI_STARBITERR flag
Date: Tue, 10 Jan 2017 09:42:10 +0100
Message-ID: <1484037736-25029-4-git-send-email-andrea.merello@gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33428 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030935AbdAJImv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:42:51 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so86800732wjc.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 00:42:50 -0800 (PST)
In-Reply-To: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

This patch prepares for supporting the STM32 variant, that has no such bit
in the status register.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/mmc/host/mmci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 54c2fc3..fbb5728 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -114,6 +114,7 @@ struct variant_data {
 	bool			qcom_fifo;
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
+	bool			has_start_err;
 };
 
 static __maybe_unused struct variant_data variant_arm = {
@@ -123,6 +124,7 @@ static __maybe_unused struct variant_data variant_arm = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo = {
@@ -131,6 +133,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo = {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -140,6 +143,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_u300 = {
@@ -155,6 +159,7 @@ static __maybe_unused struct variant_data variant_u300 = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_nomadik = {
@@ -171,6 +176,7 @@ static __maybe_unused struct variant_data variant_nomadik = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500 = {
@@ -193,6 +199,7 @@ static __maybe_unused struct variant_data variant_ux500 = {
 	.busy_detect_flag	= MCI_ST_CARDBUSY,
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500v2 = {
@@ -217,6 +224,7 @@ static __maybe_unused struct variant_data variant_ux500v2 = {
 	.busy_detect_flag	= MCI_ST_CARDBUSY,
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
+	.has_start_err		= true,
 };
 
 static __maybe_unused struct variant_data variant_qcom = {
@@ -235,6 +243,7 @@ static __maybe_unused struct variant_data variant_qcom = {
 	.explicit_mclk_control	= true,
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
+	.has_start_err		= true,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -923,8 +932,9 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
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


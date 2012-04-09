From: "Linus Walleij" <linus.walleij@linaro.org>
Subject: [PATCH] ARM: mmci: add support for the Nomadik MMCI variant
Date: Mon,  9 Apr 2012 23:03:30 +0200
Message-ID: <1334005410-20539-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:19824 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757441Ab2DIVDn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Apr 2012 17:03:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

The Nomadik variant is somewhere inbetween the U300 and the Ux500
variant, its actually expose the same primecell ID as the U300
but had different characteristics so it needs a small revision
bump and hard-coding from the board/device tree. After this it
works just fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 032b847..d115916 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -94,6 +94,17 @@ static struct variant_data variant_u300 = {
 	.signal_direction	= true,
 };
 
+static struct variant_data variant_nomadik = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg			= MCI_CLK_ENABLE,
+	.datalength_bits	= 24,
+	.sdio			= true,
+	.st_clkdiv		= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
+	.signal_direction	= true,
+};
+
 static struct variant_data variant_ux500 = {
 	.fifosize		= 30 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -1569,6 +1580,11 @@ static struct amba_id mmci_ids[] = {
 		.data	= &variant_u300,
 	},
 	{
+		.id     = 0x10180180,
+		.mask   = 0xf0ffffff,
+		.data	= &variant_nomadik,
+	},
+	{
 		.id     = 0x00280180,
 		.mask   = 0x00ffffff,
 		.data	= &variant_u300,
-- 
1.7.7.6


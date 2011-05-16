From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 3/6] mmc: vub300: Remove initialization of static ints to 0.
Date: Sun, 15 May 2011 20:21:45 -0400
Message-ID: <1305505308-8767-3-git-send-email-cjb@laptop.org>
References: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:37128 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1EPATz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 20:19:55 -0400
In-Reply-To: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>

As Nicolas Pitre points out, we may omit initializing global variables
to 0 -- they are guaranteed to be automatically cleared to 0 at
run-time, and we save space in the compiled binary.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/vub300.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index d5cff96..ac2fa06 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -224,29 +224,28 @@ MODULE_AUTHOR("Tony Olech <tony.olech@elandigitalsystems.com>");
 MODULE_DESCRIPTION("VUB300 USB to SD/MMC/SDIO adapter driver");
 MODULE_LICENSE("GPL");
 
-#define INITIALIZE_VALUE_TO_ZERO 0
 #define FUN(c) (0x000007 & (c->arg>>28))
 #define REG(c) (0x01FFFF & (c->arg>>9))
 
-static int limit_speed_to_24_MHz = INITIALIZE_VALUE_TO_ZERO;
+static int limit_speed_to_24_MHz;
 module_param(limit_speed_to_24_MHz, bool, 0644);
 MODULE_PARM_DESC(limit_speed_to_24_MHz, "Limit Max SDIO Clock Speed to 24 MHz");
 
-static int pad_input_to_usb_pkt = INITIALIZE_VALUE_TO_ZERO;
+static int pad_input_to_usb_pkt;
 module_param(pad_input_to_usb_pkt, bool, 0644);
 MODULE_PARM_DESC(pad_input_to_usb_pkt,
 		 "Pad USB data input transfers to whole USB Packet");
 
-static int disable_offload_processing = INITIALIZE_VALUE_TO_ZERO;
+static int disable_offload_processing;
 module_param(disable_offload_processing, bool, 0644);
 MODULE_PARM_DESC(disable_offload_processing, "Disable Offload Processing");
 
-static int force_1_bit_data_xfers = INITIALIZE_VALUE_TO_ZERO;
+static int force_1_bit_data_xfers;
 module_param(force_1_bit_data_xfers, bool, 0644);
 MODULE_PARM_DESC(force_1_bit_data_xfers,
 		 "Force SDIO Data Transfers to 1-bit Mode");
 
-static int force_polling_for_irqs = INITIALIZE_VALUE_TO_ZERO;
+static int force_polling_for_irqs;
 module_param(force_polling_for_irqs, bool, 0644);
 MODULE_PARM_DESC(force_polling_for_irqs, "Force Polling for SDIO interrupts");
 
-- 
1.7.0.1


From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 2/6] mmc: vub300: add whitespace after module_param decls
Date: Sun, 15 May 2011 20:21:44 -0400
Message-ID: <1305505308-8767-2-git-send-email-cjb@laptop.org>
References: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:37130 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab1EPATz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 20:19:55 -0400
In-Reply-To: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/vub300.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 04d445b..d5cff96 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -231,31 +231,39 @@ MODULE_LICENSE("GPL");
 static int limit_speed_to_24_MHz = INITIALIZE_VALUE_TO_ZERO;
 module_param(limit_speed_to_24_MHz, bool, 0644);
 MODULE_PARM_DESC(limit_speed_to_24_MHz, "Limit Max SDIO Clock Speed to 24 MHz");
+
 static int pad_input_to_usb_pkt = INITIALIZE_VALUE_TO_ZERO;
 module_param(pad_input_to_usb_pkt, bool, 0644);
 MODULE_PARM_DESC(pad_input_to_usb_pkt,
 		 "Pad USB data input transfers to whole USB Packet");
+
 static int disable_offload_processing = INITIALIZE_VALUE_TO_ZERO;
 module_param(disable_offload_processing, bool, 0644);
 MODULE_PARM_DESC(disable_offload_processing, "Disable Offload Processing");
+
 static int force_1_bit_data_xfers = INITIALIZE_VALUE_TO_ZERO;
 module_param(force_1_bit_data_xfers, bool, 0644);
 MODULE_PARM_DESC(force_1_bit_data_xfers,
 		 "Force SDIO Data Transfers to 1-bit Mode");
+
 static int force_polling_for_irqs = INITIALIZE_VALUE_TO_ZERO;
 module_param(force_polling_for_irqs, bool, 0644);
 MODULE_PARM_DESC(force_polling_for_irqs, "Force Polling for SDIO interrupts");
+
 static int firmware_irqpoll_timeout = 1024;
 module_param(firmware_irqpoll_timeout, int, 0644);
 MODULE_PARM_DESC(firmware_irqpoll_timeout, "VUB300 firmware irqpoll timeout");
+
 static int force_max_req_size = 128;
 module_param(force_max_req_size, int, 0644);
 MODULE_PARM_DESC(force_max_req_size, "set max request size in kBytes");
+
 #ifdef SMSC_DEVELOPMENT_BOARD
 static int firmware_rom_wait_states = 0x04;
 #else
 static int firmware_rom_wait_states = 0x1C;
 #endif
+
 module_param(firmware_rom_wait_states, bool, 0644);
 MODULE_PARM_DESC(firmware_rom_wait_states,
 		 "ROM wait states byte=RRRIIEEE (Reserved Internal External)");
-- 
1.7.0.1


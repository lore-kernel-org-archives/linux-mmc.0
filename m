From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0696/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:37 +0800
Message-ID: <20160802113737.28461-1-baolex.ni@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34969 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933029AbcHBMT7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Aug 2016 08:19:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony.olech@elandigitalsystems.com, ulf.hansson@linaro.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, grundler@chromium.org, lporzio@micron.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/mmc/host/vub300.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 1e819f9..9abdc44 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -224,33 +224,33 @@ enum SD_RESPONSE_TYPE {
 #define REG(c) (0x01FFFF & (c->arg>>9))
 
 static bool limit_speed_to_24_MHz;
-module_param(limit_speed_to_24_MHz, bool, 0644);
+module_param(limit_speed_to_24_MHz, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(limit_speed_to_24_MHz, "Limit Max SDIO Clock Speed to 24 MHz");
 
 static bool pad_input_to_usb_pkt;
-module_param(pad_input_to_usb_pkt, bool, 0644);
+module_param(pad_input_to_usb_pkt, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pad_input_to_usb_pkt,
 		 "Pad USB data input transfers to whole USB Packet");
 
 static bool disable_offload_processing;
-module_param(disable_offload_processing, bool, 0644);
+module_param(disable_offload_processing, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(disable_offload_processing, "Disable Offload Processing");
 
 static bool force_1_bit_data_xfers;
-module_param(force_1_bit_data_xfers, bool, 0644);
+module_param(force_1_bit_data_xfers, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(force_1_bit_data_xfers,
 		 "Force SDIO Data Transfers to 1-bit Mode");
 
 static bool force_polling_for_irqs;
-module_param(force_polling_for_irqs, bool, 0644);
+module_param(force_polling_for_irqs, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(force_polling_for_irqs, "Force Polling for SDIO interrupts");
 
 static int firmware_irqpoll_timeout = 1024;
-module_param(firmware_irqpoll_timeout, int, 0644);
+module_param(firmware_irqpoll_timeout, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(firmware_irqpoll_timeout, "VUB300 firmware irqpoll timeout");
 
 static int force_max_req_size = 128;
-module_param(force_max_req_size, int, 0644);
+module_param(force_max_req_size, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(force_max_req_size, "set max request size in kBytes");
 
 #ifdef SMSC_DEVELOPMENT_BOARD
@@ -259,7 +259,7 @@ static int firmware_rom_wait_states = 0x04;
 static int firmware_rom_wait_states = 0x1C;
 #endif
 
-module_param(firmware_rom_wait_states, int, 0644);
+module_param(firmware_rom_wait_states, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(firmware_rom_wait_states,
 		 "ROM wait states byte=RRRIIEEE (Reserved Internal External)");
 
-- 
2.9.2


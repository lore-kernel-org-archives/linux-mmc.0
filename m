From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v1 3/4] mmc: core: Add trace event for SD OCR response
Date: Mon, 15 Apr 2019 16:52:40 -0600
Message-ID: <20190415225241.70088-3-rrangel@chromium.org>
References: <20190415225241.70088-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415225241.70088-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Example:
ocr_request: mmc0: 0x51200000 SDHC or SDXC Supported (HCS) | Maximum Performance (XPC) | Switch to 1.8V (S18R) | 3.3 ~ 3.4
ocr_response: mmc0: 0xff8000 2.7 ~ 2.8 | 2.8 ~ 2.9 | 2.9 ~ 3.0 | 3.0 ~ 3.1 | 3.1 ~ 3.2 | 3.2 ~ 3.3 | 3.3 ~ 3.4 | 3.4 ~ 3.5 | 3.5 ~ 3.6

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/sd_ops.c  |  6 +++
 include/trace/events/mmc.h | 91 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 0bb0b8419016..4cf0f040f896 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -19,6 +19,8 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 
+#include <trace/events/mmc.h>
+
 #include "core.h"
 #include "sd_ops.h"
 
@@ -130,11 +132,15 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
+	trace_sd_ocr_request(host, ocr);
+
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
 		if (err)
 			break;
 
+		trace_sd_ocr_response(host, cmd.resp[0]);
+
 		/* if we're just probing, do a single pass */
 		if (ocr == 0)
 			break;
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index cad604ee800f..fa82c010ae4e 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -10,6 +10,97 @@
 #include <linux/mmc/host.h>
 #include <linux/tracepoint.h>
 
+#define SD_OCR_REQUEST \
+	{SD_OCR_CCS, "SDHC or SDXC Supported (HCS)"}, \
+	{SD_OCR_XPC, "Maximum Performance (XPC)"}, \
+	{SD_ROCR_S18A, "Switch to 1.8V (S18R)"}, \
+	{MMC_VDD_165_195, "1.65 - 1.95"}, \
+	{MMC_VDD_20_21, "2.0 ~ 2.1"}, \
+	{MMC_VDD_21_22, "2.1 ~ 2.2"}, \
+	{MMC_VDD_22_23, "2.2 ~ 2.3"}, \
+	{MMC_VDD_23_24, "2.3 ~ 2.4"}, \
+	{MMC_VDD_24_25, "2.4 ~ 2.5"}, \
+	{MMC_VDD_25_26, "2.5 ~ 2.6"}, \
+	{MMC_VDD_26_27, "2.6 ~ 2.7"}, \
+	{MMC_VDD_27_28, "2.7 ~ 2.8"}, \
+	{MMC_VDD_28_29, "2.8 ~ 2.9"}, \
+	{MMC_VDD_29_30, "2.9 ~ 3.0"}, \
+	{MMC_VDD_30_31, "3.0 ~ 3.1"}, \
+	{MMC_VDD_31_32, "3.1 ~ 3.2"}, \
+	{MMC_VDD_32_33, "3.2 ~ 3.3"}, \
+	{MMC_VDD_33_34, "3.3 ~ 3.4"}, \
+	{MMC_VDD_34_35, "3.4 ~ 3.5"}, \
+	{MMC_VDD_35_36, "3.5 ~ 3.6"} \
+
+TRACE_EVENT(sd_ocr_request,
+
+	TP_PROTO(struct mmc_host *host, u32 ocr),
+
+	TP_ARGS(host, ocr),
+
+	TP_STRUCT__entry(
+		__field(u32,			ocr)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->ocr = ocr;
+		__assign_str(name, mmc_hostname(host));
+	),
+
+	TP_printk("%s: %#x %s",
+		  __get_str(name),
+		  __entry->ocr,
+		  __print_flags(__entry->ocr, " | ", SD_OCR_REQUEST)
+	)
+);
+
+#define SD_OCR_RESPONSE \
+	{MMC_CARD_BUSY, "Ready"}, \
+	{SD_OCR_CCS, "SDHC or SDXC (CCS)"}, \
+	{(1<<29), "UHS-II Card"}, \
+	{SD_ROCR_S18A, "1.8V Accepted (S18A)"}, \
+	{MMC_VDD_165_195, "1.65 - 1.95"}, \
+	{MMC_VDD_20_21, "2.0 ~ 2.1"}, \
+	{MMC_VDD_21_22, "2.1 ~ 2.2"}, \
+	{MMC_VDD_22_23, "2.2 ~ 2.3"}, \
+	{MMC_VDD_23_24, "2.3 ~ 2.4"}, \
+	{MMC_VDD_24_25, "2.4 ~ 2.5"}, \
+	{MMC_VDD_25_26, "2.5 ~ 2.6"}, \
+	{MMC_VDD_26_27, "2.6 ~ 2.7"}, \
+	{MMC_VDD_27_28, "2.7 ~ 2.8"}, \
+	{MMC_VDD_28_29, "2.8 ~ 2.9"}, \
+	{MMC_VDD_29_30, "2.9 ~ 3.0"}, \
+	{MMC_VDD_30_31, "3.0 ~ 3.1"}, \
+	{MMC_VDD_31_32, "3.1 ~ 3.2"}, \
+	{MMC_VDD_32_33, "3.2 ~ 3.3"}, \
+	{MMC_VDD_33_34, "3.3 ~ 3.4"}, \
+	{MMC_VDD_34_35, "3.4 ~ 3.5"}, \
+	{MMC_VDD_35_36, "3.5 ~ 3.6"}
+
+TRACE_EVENT(sd_ocr_response,
+
+	TP_PROTO(struct mmc_host *host, u32 ocr),
+
+	TP_ARGS(host, ocr),
+
+	TP_STRUCT__entry(
+		__field(u32,			ocr)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->ocr = ocr;
+		__assign_str(name, mmc_hostname(host));
+	),
+
+	TP_printk("%s: %#x %s",
+		  __get_str(name),
+		  __entry->ocr,
+		  __print_flags(__entry->ocr, " | ", SD_OCR_RESPONSE)
+	)
+);
+
 TRACE_EVENT(sd_scr,
 
 	TP_PROTO(struct mmc_card *card, struct sd_scr *scr),
-- 
2.21.0.392.gf8f6787159e-goog

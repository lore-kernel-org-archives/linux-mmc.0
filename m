From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3] mmc: Provide tracepoints for request processing
Date: Mon, 28 Mar 2016 14:39:49 +0800
Message-ID: <45a62181170848cbd00c8e863f7c84772f2a8a5c.1459147046.git.baolin.wang@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34500 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbcC1Gkh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2016 02:40:37 -0400
Received: by mail-pf0-f180.google.com with SMTP id x3so130204256pfb.1
        for <linux-mmc@vger.kernel.org>; Sun, 27 Mar 2016 23:40:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, rostedt@goodmis.org, mingo@redhat.com
Cc: adrian.hunter@intel.com, yangbo.lu@freescale.com, akpm@linux-foundation.org, JBottomley@Odin.com, lporzio@micron.com, jonathanh@nvidia.com, grundler@chromium.org, axboe@fb.com, fabf@skynet.be, yunpeng.gao@intel.com, dan.j.williams@intel.com, rabin.vincent@axis.com, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, david@protonic.nl, broonie@kernel.org, linus.walleij@linaro.org, takahiro.akashi@linaro.org, baolin.wang@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

This patch provides some tracepoints for the lifecycle of a mmc request from
starting to completion to help with performance analysis of MMC subsystem.

Changes since v2:
 - Remove some redundant tracepoints which are repeated in block layer.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/core/core.c    |    7 +++
 include/trace/events/mmc.h |  129 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 include/trace/events/mmc.h

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f95d41f..7222e3f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -36,6 +36,9 @@
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/mmc.h>
+
 #include "core.h"
 #include "bus.h"
 #include "host.h"
@@ -152,6 +155,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		led_trigger_event(host->led, LED_OFF);
 
+		trace_mmc_request_done(host, mrq);
+
 		if (mrq->sbc) {
 			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
 				mmc_hostname(host), mrq->sbc->opcode,
@@ -229,6 +234,8 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
+	trace_mmc_request_start(host, mrq);
+
 	if (mrq->sbc) {
 		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
 			 mmc_hostname(host), mrq->sbc->opcode,
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
new file mode 100644
index 0000000..e231bd5
--- /dev/null
+++ b/include/trace/events/mmc.h
@@ -0,0 +1,129 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mmc
+
+#if !defined(_TRACE_MMC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MMC_H
+
+#include <linux/blkdev.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mmc_request_start,
+
+	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
+
+	TP_ARGS(host, mrq),
+
+	TP_STRUCT__entry(
+		__field(u32,			cmd_opcode)
+		__field(u32,			cmd_arg)
+		__field(unsigned int,		cmd_flags)
+		__field(u32,			stop_opcode)
+		__field(u32,			stop_arg)
+		__field(unsigned int,		stop_flags)
+		__field(u32,			sbc_opcode)
+		__field(u32,			sbc_arg)
+		__field(unsigned int,		sbc_flags)
+		__field(unsigned int,		blocks)
+		__field(unsigned int,		blksz)
+		__field(unsigned int,		data_flags)
+		__field(struct mmc_request *,	mrq)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->cmd_opcode = mrq->cmd->opcode;
+		__entry->cmd_arg = mrq->cmd->arg;
+		__entry->cmd_flags = mrq->cmd->flags;
+		__entry->stop_opcode = mrq->stop ? mrq->stop->opcode : 0;
+		__entry->stop_arg = mrq->stop ? mrq->stop->arg : 0;
+		__entry->stop_flags = mrq->stop ? mrq->stop->flags : 0;
+		__entry->sbc_opcode = mrq->sbc ? mrq->sbc->opcode : 0;
+		__entry->sbc_arg = mrq->sbc ? mrq->sbc->arg : 0;
+		__entry->sbc_flags = mrq->sbc ? mrq->sbc->flags : 0;
+		__entry->blksz = mrq->data ? mrq->data->blksz : 0;
+		__entry->blocks = mrq->data ? mrq->data->blocks : 0;
+		__entry->data_flags = mrq->data ? mrq->data->flags : 0;
+		__assign_str(name, mmc_hostname(host));
+		__entry->mrq = mrq;
+	),
+
+	TP_printk("%s: start struct mmc_request[%p]: "
+		  "cmd_opcode=%u cmd_arg=0x%x cmd_flags=0x%x "
+		  "stop_opcode=%u stop_arg=0x%x stop_flags=0x%x "
+		  "sbc_opcode=%u sbc_arg=0x%x sbc_flags=0x%x "
+		  "blocks=%u blksz=%u data_flags=0x%x",
+		  __get_str(name), __entry->mrq,
+		  __entry->cmd_opcode, __entry->cmd_arg, __entry->cmd_flags,
+		  __entry->stop_opcode, __entry->stop_arg, __entry->stop_flags,
+		  __entry->sbc_opcode, __entry->sbc_arg, __entry->sbc_flags,
+		  __entry->blocks, __entry->blksz, __entry->data_flags)
+);
+
+TRACE_EVENT(mmc_request_done,
+
+	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
+
+	TP_ARGS(host, mrq),
+
+	TP_STRUCT__entry(
+		__field(u32,		cmd_opcode)
+		__field(int,		cmd_err)
+		__array(u32,		cmd_resp,	4)
+		__field(u32,		stop_opcode)
+		__field(int,		stop_err)
+		__array(u32,		stop_resp,	4)
+		__field(u32,		sbc_opcode)
+		__field(int,		sbc_err)
+		__array(u32,		sbc_resp,	4)
+		__field(unsigned int,		bytes_xfered)
+		__field(int,			data_err)
+		__field(struct mmc_request *,	mrq)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->cmd_opcode = mrq->cmd->opcode;
+		__entry->cmd_err = mrq->cmd->error;
+		memcpy(__entry->cmd_resp, mrq->cmd->resp, 4);
+		__entry->stop_opcode = mrq->stop ? mrq->stop->opcode : 0;
+		__entry->stop_err = mrq->stop ? mrq->stop->error : 0;
+		__entry->stop_resp[0] = mrq->stop ? mrq->stop->resp[0] : 0;
+		__entry->stop_resp[1] = mrq->stop ? mrq->stop->resp[1] : 0;
+		__entry->stop_resp[2] = mrq->stop ? mrq->stop->resp[2] : 0;
+		__entry->stop_resp[3] = mrq->stop ? mrq->stop->resp[3] : 0;
+		__entry->sbc_opcode = mrq->sbc ? mrq->sbc->opcode : 0;
+		__entry->sbc_err = mrq->sbc ? mrq->sbc->error : 0;
+		__entry->sbc_resp[0] = mrq->sbc ? mrq->sbc->resp[0] : 0;
+		__entry->sbc_resp[1] = mrq->sbc ? mrq->sbc->resp[1] : 0;
+		__entry->sbc_resp[2] = mrq->sbc ? mrq->sbc->resp[2] : 0;
+		__entry->sbc_resp[3] = mrq->sbc ? mrq->sbc->resp[3] : 0;
+		__entry->bytes_xfered = mrq->data ? mrq->data->bytes_xfered : 0;
+		__entry->data_err = mrq->data ? mrq->data->error : 0;
+		__assign_str(name, mmc_hostname(host));
+		__entry->mrq = mrq;
+	),
+
+	TP_printk("%s: end struct mmc_request[%p]: "
+		  "cmd_opcode=%u cmd_err=%d cmd_resp=0x%x 0x%x 0x%x 0x%x "
+		  "stop_opcode=%u stop_err=%d stop_resp=0x%x 0x%x 0x%x 0x%x "
+		  "sbc_opcode=%u sbc_err=%d sbc_resp=0x%x 0x%x 0x%x 0x%x "
+		  "bytes_xfered=%u data_err=%d",
+		  __get_str(name), __entry->mrq,
+		  __entry->cmd_opcode, __entry->cmd_err,
+		  __entry->cmd_resp[0], __entry->cmd_resp[1],
+		  __entry->cmd_resp[2], __entry->cmd_resp[3],
+		  __entry->stop_opcode, __entry->stop_err,
+		  __entry->stop_resp[0], __entry->stop_resp[1],
+		  __entry->stop_resp[2], __entry->stop_resp[3],
+		  __entry->sbc_opcode, __entry->sbc_err,
+		  __entry->sbc_resp[0], __entry->sbc_resp[1],
+		  __entry->sbc_resp[2], __entry->sbc_resp[3],
+		  __entry->bytes_xfered, __entry->data_err)
+);
+
+#endif /* _TRACE_MMC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.9.5


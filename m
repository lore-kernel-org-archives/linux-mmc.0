From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4] mmc: Provide tracepoints for request processing
Date: Thu, 31 Mar 2016 11:16:27 +0800
Message-ID: <5e5fca2076b5ae6307ef48b279c8f4fcf27de91b.1459393711.git.baolin.wang@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34872 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcCaDRe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2016 23:17:34 -0400
Received: by mail-pf0-f182.google.com with SMTP id n5so58394996pfn.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2016 20:17:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, rostedt@goodmis.org, mingo@redhat.com
Cc: adrian.hunter@intel.com, yangbo.lu@freescale.com, akpm@linux-foundation.org, JBottomley@Odin.com, lporzio@micron.com, jonathanh@nvidia.com, grundler@chromium.org, axboe@fb.com, fabf@skynet.be, yunpeng.gao@intel.com, dan.j.williams@intel.com, rabin.vincent@axis.com, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, david@protonic.nl, broonie@kernel.org, linus.walleij@linaro.org, takahiro.akashi@linaro.org, baolin.wang@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

This patch provides some tracepoints for the lifecycle of a mmc request from
starting to completion to help with performance analysis of MMC subsystem.

Changes since v3:
 - Add "retries" and "re-tune state" in the trace print.
 - Move trace_mmc_request_start() to __mmc_start_request() function to avoid
 missing valuable information about which command/request is being sent.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/core/core.c    |    7 ++
 include/trace/events/mmc.h |  182 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 include/trace/events/mmc.h

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f95d41f..98ff0f9 100644
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
@@ -140,6 +143,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 			cmd->retries = 0;
 	}
 
+	trace_mmc_request_done(host, mrq);
+
 	if (err && cmd->retries && !mmc_card_removed(host->card)) {
 		/*
 		 * Request starter must handle retries - see
@@ -215,6 +220,8 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 
+	trace_mmc_request_start(host, mrq);
+
 	host->ops->request(host, mrq);
 }
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
new file mode 100644
index 0000000..a72f9b9
--- /dev/null
+++ b/include/trace/events/mmc.h
@@ -0,0 +1,182 @@
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
+		__field(unsigned int,		cmd_retries)
+		__field(u32,			stop_opcode)
+		__field(u32,			stop_arg)
+		__field(unsigned int,		stop_flags)
+		__field(unsigned int,		stop_retries)
+		__field(u32,			sbc_opcode)
+		__field(u32,			sbc_arg)
+		__field(unsigned int,		sbc_flags)
+		__field(unsigned int,		sbc_retries)
+		__field(unsigned int,		blocks)
+		__field(unsigned int,		blksz)
+		__field(unsigned int,		data_flags)
+		__field(unsigned int,		can_retune)
+		__field(unsigned int,		doing_retune)
+		__field(unsigned int,		retune_now)
+		__field(int,			need_retune)
+		__field(int,			hold_retune)
+		__field(unsigned int,		retune_period)
+		__field(struct mmc_request *,	mrq)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->cmd_opcode = mrq->cmd->opcode;
+		__entry->cmd_arg = mrq->cmd->arg;
+		__entry->cmd_flags = mrq->cmd->flags;
+		__entry->cmd_retries = mrq->cmd->retries;
+		__entry->stop_opcode = mrq->stop ? mrq->stop->opcode : 0;
+		__entry->stop_arg = mrq->stop ? mrq->stop->arg : 0;
+		__entry->stop_flags = mrq->stop ? mrq->stop->flags : 0;
+		__entry->stop_retries = mrq->stop ? mrq->stop->retries : 0;
+		__entry->sbc_opcode = mrq->sbc ? mrq->sbc->opcode : 0;
+		__entry->sbc_arg = mrq->sbc ? mrq->sbc->arg : 0;
+		__entry->sbc_flags = mrq->sbc ? mrq->sbc->flags : 0;
+		__entry->sbc_retries = mrq->sbc ? mrq->sbc->retries : 0;
+		__entry->blksz = mrq->data ? mrq->data->blksz : 0;
+		__entry->blocks = mrq->data ? mrq->data->blocks : 0;
+		__entry->data_flags = mrq->data ? mrq->data->flags : 0;
+		__entry->can_retune = host->can_retune;
+		__entry->doing_retune = host->doing_retune;
+		__entry->retune_now = host->retune_now;
+		__entry->need_retune = host->need_retune;
+		__entry->hold_retune = host->hold_retune;
+		__entry->retune_period = host->retune_period;
+		__assign_str(name, mmc_hostname(host));
+		__entry->mrq = mrq;
+	),
+
+	TP_printk("%s: start struct mmc_request[%p]: "
+		  "cmd_opcode=%u cmd_arg=0x%x cmd_flags=0x%x cmd_retries=%u "
+		  "stop_opcode=%u stop_arg=0x%x stop_flags=0x%x stop_retries=%u "
+		  "sbc_opcode=%u sbc_arg=0x%x sbc_flags=0x%x sbc_retires=%u "
+		  "blocks=%u block_size=%u data_flags=0x%x "
+		  "can_retune=%u doing_retune=%u retune_now=%u "
+		  "need_retune=%d hold_retune=%d retune_period=%u",
+		  __get_str(name), __entry->mrq,
+		  __entry->cmd_opcode, __entry->cmd_arg,
+		  __entry->cmd_flags, __entry->cmd_retries,
+		  __entry->stop_opcode, __entry->stop_arg,
+		  __entry->stop_flags, __entry->stop_retries,
+		  __entry->sbc_opcode, __entry->sbc_arg,
+		  __entry->sbc_flags, __entry->sbc_retries,
+		  __entry->blocks, __entry->blksz, __entry->data_flags,
+		  __entry->can_retune, __entry->doing_retune,
+		  __entry->retune_now, __entry->need_retune,
+		  __entry->hold_retune, __entry->retune_period)
+);
+
+TRACE_EVENT(mmc_request_done,
+
+	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
+
+	TP_ARGS(host, mrq),
+
+	TP_STRUCT__entry(
+		__field(u32,			cmd_opcode)
+		__field(int,			cmd_err)
+		__array(u32,			cmd_resp,	4)
+		__field(unsigned int,		cmd_retries)
+		__field(u32,			stop_opcode)
+		__field(int,			stop_err)
+		__array(u32,			stop_resp,	4)
+		__field(unsigned int,		stop_retries)
+		__field(u32,			sbc_opcode)
+		__field(int,			sbc_err)
+		__array(u32,			sbc_resp,	4)
+		__field(unsigned int,		sbc_retries)
+		__field(unsigned int,		bytes_xfered)
+		__field(int,			data_err)
+		__field(unsigned int,		can_retune)
+		__field(unsigned int,		doing_retune)
+		__field(unsigned int,		retune_now)
+		__field(int,			need_retune)
+		__field(int,			hold_retune)
+		__field(unsigned int,		retune_period)
+		__field(struct mmc_request *,	mrq)
+		__string(name,			mmc_hostname(host))
+	),
+
+	TP_fast_assign(
+		__entry->cmd_opcode = mrq->cmd->opcode;
+		__entry->cmd_err = mrq->cmd->error;
+		memcpy(__entry->cmd_resp, mrq->cmd->resp, 4);
+		__entry->cmd_retries = mrq->cmd->retries;
+		__entry->stop_opcode = mrq->stop ? mrq->stop->opcode : 0;
+		__entry->stop_err = mrq->stop ? mrq->stop->error : 0;
+		__entry->stop_resp[0] = mrq->stop ? mrq->stop->resp[0] : 0;
+		__entry->stop_resp[1] = mrq->stop ? mrq->stop->resp[1] : 0;
+		__entry->stop_resp[2] = mrq->stop ? mrq->stop->resp[2] : 0;
+		__entry->stop_resp[3] = mrq->stop ? mrq->stop->resp[3] : 0;
+		__entry->stop_retries = mrq->stop ? mrq->stop->retries : 0;
+		__entry->sbc_opcode = mrq->sbc ? mrq->sbc->opcode : 0;
+		__entry->sbc_err = mrq->sbc ? mrq->sbc->error : 0;
+		__entry->sbc_resp[0] = mrq->sbc ? mrq->sbc->resp[0] : 0;
+		__entry->sbc_resp[1] = mrq->sbc ? mrq->sbc->resp[1] : 0;
+		__entry->sbc_resp[2] = mrq->sbc ? mrq->sbc->resp[2] : 0;
+		__entry->sbc_resp[3] = mrq->sbc ? mrq->sbc->resp[3] : 0;
+		__entry->sbc_retries = mrq->sbc ? mrq->sbc->retries : 0;
+		__entry->bytes_xfered = mrq->data ? mrq->data->bytes_xfered : 0;
+		__entry->data_err = mrq->data ? mrq->data->error : 0;
+		__entry->can_retune = host->can_retune;
+		__entry->doing_retune = host->doing_retune;
+		__entry->retune_now = host->retune_now;
+		__entry->need_retune = host->need_retune;
+		__entry->hold_retune = host->hold_retune;
+		__entry->retune_period = host->retune_period;
+		__assign_str(name, mmc_hostname(host));
+		__entry->mrq = mrq;
+	),
+
+	TP_printk("%s: end struct mmc_request[%p]: "
+		  "cmd_opcode=%u cmd_err=%d cmd_resp=0x%x 0x%x 0x%x 0x%x "
+		  "cmd_retries=%u stop_opcode=%u stop_err=%d "
+		  "stop_resp=0x%x 0x%x 0x%x 0x%x stop_retries=%u "
+		  "sbc_opcode=%u sbc_err=%d sbc_resp=0x%x 0x%x 0x%x 0x%x "
+		  "sbc_retries=%u bytes_xfered=%u data_err=%d "
+		  "can_retune=%u doing_retune=%u retune_now=%u need_retune=%d "
+		  "hold_retune=%d retune_period=%u",
+		  __get_str(name), __entry->mrq,
+		  __entry->cmd_opcode, __entry->cmd_err,
+		  __entry->cmd_resp[0], __entry->cmd_resp[1],
+		  __entry->cmd_resp[2], __entry->cmd_resp[3],
+		  __entry->cmd_retries,
+		  __entry->stop_opcode, __entry->stop_err,
+		  __entry->stop_resp[0], __entry->stop_resp[1],
+		  __entry->stop_resp[2], __entry->stop_resp[3],
+		  __entry->stop_retries,
+		  __entry->sbc_opcode, __entry->sbc_err,
+		  __entry->sbc_resp[0], __entry->sbc_resp[1],
+		  __entry->sbc_resp[2], __entry->sbc_resp[3],
+		  __entry->sbc_retries,
+		  __entry->bytes_xfered, __entry->data_err,
+		  __entry->can_retune, __entry->doing_retune,
+		  __entry->retune_now, __entry->need_retune,
+		  __entry->hold_retune, __entry->retune_period)
+);
+
+#endif /* _TRACE_MMC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.9.5


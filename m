From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v2 1/4] mmc: core: Add trace event for SD SCR response
Date: Tue, 16 Apr 2019 12:32:54 -0600
Message-ID: <20190416183257.247902-2-rrangel@chromium.org>
References: <20190416183257.247902-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183257.247902-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, hongjiefang <hongjiefang@asrmicro.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Example:
sd_scr: mmc0: version: 2, spec3: 1, width: [1-BIT | 4-BIT], cmds: [], raw: {0x2b58000,0x0} */

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/sd.c      |  6 +++++
 include/trace/events/mmc.h | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..f1772972d6a3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -21,6 +21,8 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 
+#include <trace/events/mmc.h>
+
 #include "core.h"
 #include "card.h"
 #include "host.h"
@@ -200,6 +202,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 	if (scr_struct != 0) {
 		pr_err("%s: unrecognised SCR structure version %d\n",
 			mmc_hostname(card->host), scr_struct);
+		trace_sd_scr(card, NULL);
 		return -EINVAL;
 	}
 
@@ -221,6 +224,9 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+
+	trace_sd_scr(card, scr);
+
 	return 0;
 }
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 7b706ff21335..9761d3db16db 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -10,6 +10,57 @@
 #include <linux/mmc/host.h>
 #include <linux/tracepoint.h>
 
+#define SD_SCR_WIDTH_FLAGS		\
+	{SD_SCR_BUS_WIDTH_1, "1-BIT"},	\
+	{SD_SCR_BUS_WIDTH_4, "4-BIT"}
+
+#define SD_SCR_CMD_FLAGS		\
+	{SD_SCR_CMD20_SUPPORT, "CMD20"},\
+	{SD_SCR_CMD23_SUPPORT, "CMD23"}
+
+TRACE_EVENT(sd_scr,
+
+	TP_PROTO(struct mmc_card *card, struct sd_scr *scr),
+
+	TP_ARGS(card, scr),
+
+	TP_STRUCT__entry(
+		__array(u32,			raw,	2)
+		__field(unsigned char,		sda_vsn)
+		__field(unsigned char,		sda_spec3)
+		__field(unsigned char,		bus_widths)
+		__field(unsigned char,		cmds)
+		__string(name,			mmc_hostname(card->host))
+	),
+
+	TP_fast_assign(
+		BUILD_BUG_ON(sizeof(card->raw_scr) != sizeof(__entry->raw));
+		memcpy(__entry->raw, card->raw_scr, sizeof(__entry->raw));
+		if (scr) {
+			__entry->sda_vsn = scr->sda_vsn;
+			__entry->sda_spec3 = scr->sda_spec3;
+			__entry->bus_widths = scr->bus_widths;
+			__entry->cmds = scr->cmds;
+		} else {
+			__entry->sda_vsn = 0;
+			__entry->sda_spec3 = 0;
+			__entry->bus_widths = 0;
+			__entry->cmds = 0;
+		}
+		__assign_str(name, mmc_hostname(card->host));
+	),
+
+	TP_printk("%s: version: %d, spec3: %d, width: [%s], cmds: [%s], "
+		  "raw: %s",
+		  __get_str(name),
+		  __entry->sda_vsn,
+		  __entry->sda_spec3,
+		  __print_flags(__entry->bus_widths, " | ", SD_SCR_WIDTH_FLAGS),
+		  __print_flags(__entry->cmds, " | ", SD_SCR_CMD_FLAGS),
+		  __print_array(__entry->raw, 2, sizeof(u32))
+	)
+);
+
 TRACE_EVENT(mmc_request_start,
 
 	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
-- 
2.21.0.392.gf8f6787159e-goog

From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v1 4/4] mmc: core: Add trace event for CSD response
Date: Mon, 15 Apr 2019 16:52:41 -0600
Message-ID: <20190415225241.70088-4-rrangel@chromium.org>
References: <20190415225241.70088-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415225241.70088-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Ingo Molnar <mingo@redhat.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Example:
mmc_csd: mmc0: struct: 0, cmdclass: 0x5b5, raw: {0x400e0032,0x5b590000,0x3b4b7f80,0xa404000}

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/mmc.c     |  4 ++++
 drivers/mmc/core/sd.c      |  2 ++
 include/trace/events/mmc.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3e786ba204c3..46ce894f7c03 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -20,6 +20,8 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/mmc.h>
 
+#include <trace/events/mmc.h>
+
 #include "core.h"
 #include "card.h"
 #include "host.h"
@@ -182,6 +184,8 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->erase_size <<= csd->write_blkbits - 9;
 	}
 
+	trace_mmc_csd(card);
+
 	return 0;
 }
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cc33a4f96c6a..4e704a7280ba 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -183,6 +183,8 @@ static int mmc_decode_csd(struct mmc_card *card)
 
 	card->erase_size = csd->erase_size;
 
+	trace_mmc_csd(card);
+
 	return 0;
 }
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index fa82c010ae4e..58f6f7808974 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -174,6 +174,34 @@ TRACE_EVENT(sd_ssr,
 	)
 );
 
+TRACE_EVENT(mmc_csd,
+
+	TP_PROTO(struct mmc_card *card),
+
+	TP_ARGS(card),
+
+	TP_STRUCT__entry(
+		__array(u32,			raw,	4)
+		__field(unsigned char,		structure)
+		__field(unsigned short,		cmdclass)
+		__string(name,			mmc_hostname(card->host))
+	),
+
+	TP_fast_assign(
+		__entry->structure = card->csd.structure;
+		__entry->cmdclass = card->csd.cmdclass;
+		memcpy(__entry->raw, card->raw_csd, sizeof(card->raw_csd));
+		__assign_str(name, mmc_hostname(card->host));
+	),
+
+	TP_printk("%s: struct: %d, cmdclass: %#x, raw: %s",
+		  __get_str(name),
+		  __entry->structure,
+		  __entry->cmdclass,
+		  __print_array(__entry->raw, 4, sizeof(u32))
+	)
+);
+
 TRACE_EVENT(mmc_request_start,
 
 	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
-- 
2.21.0.392.gf8f6787159e-goog

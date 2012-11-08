From: dragos.tatulea@intel.com
Subject: [PATCH v2 12/26] mmc: panic write: bypass regulators
Date: Thu,  8 Nov 2012 15:06:10 +0200
Message-ID: <1352379984-18381-13-git-send-email-dragos.tatulea@intel.com>
References: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kirill.shutemov@linux.intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, tony.luck@intel.com, keescook@chromium.org, dragos.tatulea@gmail.com, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/mmc/core/core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f7552af..d3caa7e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1128,6 +1128,9 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 	int			result = 0;
 	int			min_uV, max_uV;
 
+	if (mmc_am_panic_task(mmc))
+		return 0;
+
 	if (vdd_bit) {
 		int		tmp;
 		int		voltage;
-- 
1.7.9.5

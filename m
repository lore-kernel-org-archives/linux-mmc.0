From: <micky_ching@realsil.com.cn>
Subject: [PATCH v3 2/2] mmc: rtsx: modify phase searching method for tuning
Date: Tue, 3 Dec 2013 10:34:13 +0800
Message-ID: <83e5f85df34724c6be6ee9276cb23de140d223cc.1385947736.git.micky_ching@realsil.com.cn>
References: <cover.1385947736.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1385947736.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

The new phase searching method is more concise and easier to
understand.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |  112 +++++++++++--------------------------
 include/linux/mfd/rtsx_pci.h      |    2 +-
 2 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index c9a7328..7da270b 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -31,16 +31,6 @@
 #include <linux/mfd/rtsx_pci.h>
 #include <asm/unaligned.h>
 
-/* SD Tuning Data Structure
- * Record continuous timing phase path
- */
-struct timing_phase_path {
-	int start;
-	int end;
-	int mid;
-	int len;
-};
-
 struct realtek_pci_sdmmc {
 	struct platform_device	*pdev;
 	struct rtsx_pcr		*pcr;
@@ -511,85 +501,47 @@ static int sd_change_phase(struct realtek_pci_sdmmc *host,
 	return 0;
 }
 
-static u8 sd_search_final_phase(struct realtek_pci_sdmmc *host, u32 phase_map)
+static inline u32 test_phase_bit(u32 phase_map, unsigned int bit)
 {
-	struct timing_phase_path path[MAX_PHASE + 1];
-	int i, j, cont_path_cnt;
-	int new_block, max_len, final_path_idx;
-	u8 final_phase = 0xFF;
+	bit %= RTSX_PHASE_MAX;
+	return phase_map & (1 << bit);
+}
 
-	/* Parse phase_map, take it as a bit-ring */
-	cont_path_cnt = 0;
-	new_block = 1;
-	j = 0;
-	for (i = 0; i < MAX_PHASE + 1; i++) {
-		if (phase_map & (1 << i)) {
-			if (new_block) {
-				new_block = 0;
-				j = cont_path_cnt++;
-				path[j].start = i;
-				path[j].end = i;
-			} else {
-				path[j].end = i;
-			}
-		} else {
-			new_block = 1;
-			if (cont_path_cnt) {
-				/* Calculate path length and middle point */
-				int idx = cont_path_cnt - 1;
-				path[idx].len =
-					path[idx].end - path[idx].start + 1;
-				path[idx].mid =
-					path[idx].start + path[idx].len / 2;
-			}
-		}
-	}
+static int sd_get_phase_len(u32 phase_map, unsigned int start_bit)
+{
+	int i;
 
-	if (cont_path_cnt == 0) {
-		dev_dbg(sdmmc_dev(host), "No continuous phase path\n");
-		goto finish;
-	} else {
-		/* Calculate last continuous path length and middle point */
-		int idx = cont_path_cnt - 1;
-		path[idx].len = path[idx].end - path[idx].start + 1;
-		path[idx].mid = path[idx].start + path[idx].len / 2;
+	for (i = 0; i < RTSX_PHASE_MAX; i++) {
+		if (test_phase_bit(phase_map, start_bit + i) == 0)
+			return i;
 	}
+	return RTSX_PHASE_MAX;
+}
+
+static u8 sd_search_final_phase(struct realtek_pci_sdmmc *host, u32 phase_map)
+{
+	int start = 0, len = 0;
+	int start_final = 0, len_final = 0;
+	u8 final_phase = 0xFF;
 
-	/* Connect the first and last continuous paths if they are adjacent */
-	if (!path[0].start && (path[cont_path_cnt - 1].end == MAX_PHASE)) {
-		/* Using negative index */
-		path[0].start = path[cont_path_cnt - 1].start - MAX_PHASE - 1;
-		path[0].len += path[cont_path_cnt - 1].len;
-		path[0].mid = path[0].start + path[0].len / 2;
-		/* Convert negative middle point index to positive one */
-		if (path[0].mid < 0)
-			path[0].mid += MAX_PHASE + 1;
-		cont_path_cnt--;
+	if (phase_map == 0) {
+		dev_err(sdmmc_dev(host), "phase error: [map:%x]\n", phase_map);
+		return final_phase;
 	}
 
-	/* Choose the longest continuous phase path */
-	max_len = 0;
-	final_phase = 0;
-	final_path_idx = 0;
-	for (i = 0; i < cont_path_cnt; i++) {
-		if (path[i].len > max_len) {
-			max_len = path[i].len;
-			final_phase = (u8)path[i].mid;
-			final_path_idx = i;
+	while (start < RTSX_PHASE_MAX) {
+		len = sd_get_phase_len(phase_map, start);
+		if (len_final < len) {
+			start_final = start;
+			len_final = len;
 		}
-
-		dev_dbg(sdmmc_dev(host), "path[%d].start = %d\n",
-				i, path[i].start);
-		dev_dbg(sdmmc_dev(host), "path[%d].end = %d\n",
-				i, path[i].end);
-		dev_dbg(sdmmc_dev(host), "path[%d].len = %d\n",
-				i, path[i].len);
-		dev_dbg(sdmmc_dev(host), "path[%d].mid = %d\n",
-				i, path[i].mid);
+		start += len ? len : 1;
 	}
 
-finish:
-	dev_dbg(sdmmc_dev(host), "Final chosen phase: %d\n", final_phase);
+	final_phase = (start_final + len_final / 2) % RTSX_PHASE_MAX;
+	dev_dbg(sdmmc_dev(host), "phase: [map:%x] [maxlen:%d] [final:%d]\n",
+		phase_map, len_final, final_phase);
+
 	return final_phase;
 }
 
@@ -635,7 +587,7 @@ static int sd_tuning_phase(struct realtek_pci_sdmmc *host,
 	int err, i;
 	u32 raw_phase_map = 0;
 
-	for (i = MAX_PHASE; i >= 0; i--) {
+	for (i = 0; i < RTSX_PHASE_MAX; i++) {
 		err = sd_tuning_rx_cmd(host, opcode, (u8)i);
 		if (err == 0)
 			raw_phase_map |= 1 << i;
diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_pci.h
index 0ce7721..a383597 100644
--- a/include/linux/mfd/rtsx_pci.h
+++ b/include/linux/mfd/rtsx_pci.h
@@ -144,7 +144,7 @@
 #define HOST_TO_DEVICE		0
 #define DEVICE_TO_HOST		1
 
-#define MAX_PHASE		31
+#define RTSX_PHASE_MAX		32
 #define RX_TUNING_CNT		3
 
 /* SG descriptor */
-- 
1.7.9.5

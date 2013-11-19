From: <micky_ching@realsil.com.cn>
Subject: [PATCH 2/2] mmc: rtsx: modify phase searching method for tunning
Date: Tue, 19 Nov 2013 19:10:35 +0800
Message-ID: <38cd1d9d7f10f6a65b4dc608f310ac3818da827f.1384858553.git.micky_ching@realsil.com.cn>
References: <cover.1384858553.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1384858553.git.micky_ching@realsil.com.cn>
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
 drivers/mmc/host/rtsx_pci_sdmmc.c |  108 +++++++++++--------------------------
 1 file changed, 30 insertions(+), 78 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index c9a7328..fb2f159 100644
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
+static inline u32 sd_get_phase_point(u32 phase_map, unsigned int idx)
 {
-	struct timing_phase_path path[MAX_PHASE + 1];
-	int i, j, cont_path_cnt;
-	int new_block, max_len, final_path_idx;
-	u8 final_phase = 0xFF;
+	idx &= MAX_PHASE;
+	return phase_map & (1 << idx);
+}
+
+static int sd_get_phase_len(u32 phase_map, unsigned int idx)
+{
+	int i;
 
-	/* Parse phase_map, take it as a bit-ring */
-	cont_path_cnt = 0;
-	new_block = 1;
-	j = 0;
 	for (i = 0; i < MAX_PHASE + 1; i++) {
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
+		if (sd_get_phase_point(phase_map, idx + i) == 0)
+			return i;
 	}
+	return MAX_PHASE + 1;
+}
 
-	if (cont_path_cnt == 0) {
-		dev_dbg(sdmmc_dev(host), "No continuous phase path\n");
-		goto finish;
-	} else {
-		/* Calculate last continuous path length and middle point */
-		int idx = cont_path_cnt - 1;
-		path[idx].len = path[idx].end - path[idx].start + 1;
-		path[idx].mid = path[idx].start + path[idx].len / 2;
-	}
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
+		dev_dbg(sdmmc_dev(host), "Phase: [map:%x]\n", phase_map);
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
+	while (start < MAX_PHASE + 1) {
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
+	final_phase = (start_final + len_final / 2) & MAX_PHASE;
+	dev_dbg(sdmmc_dev(host), "Phase: [map:%x] [maxlen:%d] [final:%d]\n",
+		phase_map, len_final, final_phase);
+
 	return final_phase;
 }
 
-- 
1.7.9.5

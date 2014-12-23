From: <micky_ching@realsil.com.cn>
Subject: [PATCH v5 2/6] mmc: rtsx: add dump_reg_range to simplify dump register
Date: Tue, 23 Dec 2014 09:19:42 +0800
Message-ID: <dcd9add1d29623726bdde4819c7e5267966d2f4f.1419297154.git.micky_ching@realsil.com.cn>
References: <cover.1419297154.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1419297154.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

Add a new function to dump register within a range.
We print 1 register a line before this patch,
this may make debug info too long when we add more register to dump.

The new dump_reg_range() dump to 8 register a line,
and it is easy to use.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index c70b602..b1390f0 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -71,25 +71,29 @@ static inline void sd_clear_error(struct realtek_pci_sdmmc *host)
 }
 
 #ifdef DEBUG
-static void sd_print_debug_regs(struct realtek_pci_sdmmc *host)
+static void dump_reg_range(struct realtek_pci_sdmmc *host, u16 start, u16 end)
 {
-	struct rtsx_pcr *pcr = host->pcr;
-	u16 i;
-	u8 *ptr;
+	u16 len = end - start + 1;
+	int i;
+	u8 data[8];
+
+	for (i = 0; i < len; i += 8) {
+		int j;
+		int n = min(8, len - i);
+
+		memset(&data, 0, sizeof(data));
+		for (j = 0; j < n; j++)
+			rtsx_pci_read_register(host->pcr, start + i + j,
+				data + j);
+		dev_dbg(sdmmc_dev(host), "0x%04X(%d): %8ph\n",
+			start + i, n, data);
+	}
+}
 
-	/* Print SD host internal registers */
-	rtsx_pci_init_cmd(pcr);
-	for (i = 0xFDA0; i <= 0xFDAE; i++)
-		rtsx_pci_add_cmd(pcr, READ_REG_CMD, i, 0, 0);
-	for (i = 0xFD52; i <= 0xFD69; i++)
-		rtsx_pci_add_cmd(pcr, READ_REG_CMD, i, 0, 0);
-	rtsx_pci_send_cmd(pcr, 100);
-
-	ptr = rtsx_pci_get_cmd_data(pcr);
-	for (i = 0xFDA0; i <= 0xFDAE; i++)
-		dev_dbg(sdmmc_dev(host), "0x%04X: 0x%02x\n", i, *(ptr++));
-	for (i = 0xFD52; i <= 0xFD69; i++)
-		dev_dbg(sdmmc_dev(host), "0x%04X: 0x%02x\n", i, *(ptr++));
+static void sd_print_debug_regs(struct realtek_pci_sdmmc *host)
+{
+	dump_reg_range(host, 0xFDA0, 0xFDB3);
+	dump_reg_range(host, 0xFD52, 0xFD69);
 }
 #else
 #define sd_print_debug_regs(host)
-- 
1.9.1

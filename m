From: <micky_ching@realsil.com.cn>
Subject: [PATCH 1/2] mmc: rtsx: finish request if no card exist
Date: Wed, 14 Jan 2015 11:09:11 +0800
Message-ID: <c19c0517af26529df439333b556315a4bc88d815.1421204431.git.micky_ching@realsil.com.cn>
References: <cover.1421204431.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1421204431.git.micky_ching@realsil.com.cn>
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

Return error-code directly if no card exist, this can
make card remove faster.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 26c6a7c..b435806 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -100,6 +100,11 @@ static void sd_print_debug_regs(struct realtek_pci_sdmmc *host)
 #define sd_print_debug_regs(host)
 #endif /* DEBUG */
 
+static inline int sd_get_cd_int(struct realtek_pci_sdmmc *host)
+{
+	return rtsx_pci_readl(host->pcr, RTSX_BIPR) & SD_EXIST;
+}
+
 static void sd_cmd_set_sd_cmd(struct rtsx_pcr *pcr, struct mmc_command *cmd)
 {
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CMD0, 0xFF,
@@ -798,7 +803,7 @@ static void sd_request(struct work_struct *work)
 	unsigned int data_size = 0;
 	int err;
 
-	if (host->eject) {
+	if (host->eject || !sd_get_cd_int(host)) {
 		cmd->error = -ENOMEDIUM;
 		goto finish;
 	}
@@ -1116,7 +1121,7 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	u32 val;
 
 	if (host->eject)
-		return -ENOMEDIUM;
+		return cd;
 
 	mutex_lock(&pcr->pcr_mutex);
 
-- 
1.9.1

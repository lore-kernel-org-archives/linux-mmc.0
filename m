From: <wei_wang@realsil.com.cn>
Subject: [PATCH 2/3] mmc:rtsx:Clear SD_CLK toggle enable bit if switching
 voltage fail
Date: Wed, 21 Aug 2013 09:46:26 +0800
Message-ID: <c9999b9b7eeb218d6af6965fb39f6d69b7ccd041.1377049122.git.wei_wang@realsil.com.cn>
References: <cover.1377049122.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1377049122.git.wei_wang@realsil.com.cn>
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
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Wei WANG <wei_wang@realsil.com.cn>, rogerable@realtek.com, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

If switching voltage fails, SD_CLK toggle enable bit should been cleared
so that SD host can control SD clock automatically.

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index fcb368e..0fefe4e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -227,6 +227,7 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	int stat_idx = 0;
 	u8 rsp_type;
 	int rsp_len = 5;
+	bool clock_toggled = false;
 
 	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
 			__func__, cmd_idx, arg);
@@ -270,6 +271,8 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 				0xFF, SD_CLK_TOGGLE_EN);
 		if (err < 0)
 			goto out;
+
+		clock_toggled = true;
 	}
 
 	rtsx_pci_init_cmd(pcr);
@@ -350,6 +353,10 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 
 out:
 	cmd->error = err;
+
+	if (err && clock_toggled)
+		rtsx_pci_write_register(pcr, SD_BUS_STAT,
+				SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 }
 
 static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
@@ -1121,11 +1128,11 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 			goto out;
 	}
 
+out:
 	/* Stop toggle SD clock in idle */
 	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
 			SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 
-out:
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return err;
-- 
1.7.9.5

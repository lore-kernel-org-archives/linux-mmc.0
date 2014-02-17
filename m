From: <micky_ching@realsil.com.cn>
Subject: [PATCH RESEND 1/3] mmc: rtsx: fix card poweroff bug
Date: Mon, 17 Feb 2014 10:00:55 +0800
Message-ID: <90c7ee3dd655e1f203938dbe8dc45769cfd509de.1392602322.git.micky_ching@realsil.com.cn>
References: <cover.1392602322.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1392602322.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: chris@printf.net, sameo@linux.intel.com
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

If the host driver removed while card in the slot, the host will not
power off card power correctly. This bug is produced because host
eject flag set before the last mmc_set_ios callback, we should set the
eject flag after power off.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 375a880e..c9a7328 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1328,7 +1328,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr->slots[RTSX_SD_CARD].p_dev = NULL;
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
 	mmc = host->mmc;
-	host->eject = true;
 
 	mutex_lock(&host->host_mutex);
 	if (host->mrq) {
@@ -1346,6 +1345,8 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	mutex_unlock(&host->host_mutex);
 
 	mmc_remove_host(mmc);
+	host->eject = true;
+
 	mmc_free_host(mmc);
 
 	dev_dbg(&(pdev->dev),
-- 
1.7.9.5

From: <micky_ching@realsil.com.cn>
Subject: [PATCH] mmc: rtsx: fix possible circular locking dependency
Date: Wed, 16 Apr 2014 09:38:44 +0800
Message-ID: <1397612325-4968-1-git-send-email-micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
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

To avoid dead lock, we need make sure host->lock is always acquire
before pcr->lock. But in irq handler, we acquired pcr->lock in rtsx mfd
driver, and sd_isr_done_transfer() is called during pcr->lock already
acquired. Since in sd_isr_done_transfer() the only work we do is schdule
tasklet, the cmd_tasklet and data_tasklet never conflict, so it is safe
to remove spin_lock() here.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 453e1d4..40695e0 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -108,12 +108,10 @@ static void sd_isr_done_transfer(struct platform_device *pdev)
 {
 	struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
 
-	spin_lock(&host->lock);
 	if (host->cmd)
 		tasklet_schedule(&host->cmd_tasklet);
-	if (host->data)
+	else if (host->data)
 		tasklet_schedule(&host->data_tasklet);
-	spin_unlock(&host->lock);
 }
 
 static void sd_request_timeout(unsigned long host_addr)
-- 
1.7.9.5

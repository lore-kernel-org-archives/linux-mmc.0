From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 3/6] mmc: rtsx: Constify platform_device_id
Date: Sat,  2 May 2015 00:49:19 +0900
Message-ID: <1430495362-31506-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 1d3d6c4bfdc6..93137483ecde 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1474,7 +1474,7 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id rtsx_pci_sdmmc_ids[] = {
+static const struct platform_device_id rtsx_pci_sdmmc_ids[] = {
 	{
 		.name = DRV_NAME_RTSX_PCI_SDMMC,
 	}, {
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 88af827e086b..6c71fc9f76c7 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1439,7 +1439,7 @@ static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id rtsx_usb_sdmmc_ids[] = {
+static const struct platform_device_id rtsx_usb_sdmmc_ids[] = {
 	{
 		.name = "rtsx_usb_sdmmc",
 	}, {
-- 
2.1.4

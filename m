From: <micky_ching@realsil.com.cn>
Subject: [PATCH 2/2] mmc: rtsx: check sg_count before long data xfer
Date: Wed, 14 Jan 2015 11:09:12 +0800
Message-ID: <55d9f11a9338acd70f820673d4548ac9939dabc6.1421204431.git.micky_ching@realsil.com.cn>
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

Check sg_count before sending long data xfer.
Because dma_map_sg() return int, and sg_count may be negative,
so using int instead of unsigned.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index b435806..1d3d6c4 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -54,9 +54,9 @@ struct realtek_pci_sdmmc {
 #define SDMMC_POWER_ON		1
 #define SDMMC_POWER_OFF		0
 
-	unsigned int		sg_count;
+	int			sg_count;
 	s32			cookie;
-	unsigned int		cookie_sg_count;
+	int			cookie_sg_count;
 	bool			using_cookie;
 };
 
@@ -557,6 +557,13 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 {
 	struct mmc_data *data = mrq->data;
 
+	if (host->sg_count < 0) {
+		data->error = host->sg_count;
+		dev_dbg(sdmmc_dev(host), "%s: sg_count = %d is invalid\n",
+			__func__, host->sg_count);
+		return data->error;
+	}
+
 	if (data->flags & MMC_DATA_READ)
 		return sd_read_long_data(host, mrq);
 
-- 
1.9.1

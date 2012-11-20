From: <wei_wang@realsil.com.cn>
Subject: [PATCH v2 1/2] mmc/host/rtsx: Configure SD_CFG2 register in
 sd_rw_multi
Date: Tue, 20 Nov 2012 10:09:16 +0800
Message-ID: <00fb063304a0720f3ba9db6f79bb67263d450356.1353377266.git.wei_wang@realsil.com.cn>
References: <cover.1353377266.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1353377266.git.wei_wang@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: cjb@laptop.org, sameo@linux.intel.com
Cc: arnd@arndb.de, oakad@yahoo.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Wei WANG <wei_wang@realsil.com.cn>, bp@alien8.de, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

For Realtek card reader, internal regsiter SD_CFG2 should be configured
before transferring data. In the prior version, the value of this register
has been calculated, but forgotten to write back to the internal register.

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 0e934bf..067dd46 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -405,6 +405,7 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_DATA_SOURCE,
 			0x01, RING_BUFFER);
 
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF, cfg2);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
 			trans_mode | SD_TRANSFER_START);
 	rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
-- 
1.7.9.5

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 1/1] of_mmc_spi: fix little endian support
Date: Mon, 30 Jan 2012 05:15:29 +0100
Message-ID: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
List-Id: linux-mmc@vger.kernel.org

the voltage_ranges is supposed to switch from big endian to little endian

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/of_mmc_spi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index ab66f24..ede2c64 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -109,12 +109,13 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 		goto err_ocr;
 	}
 
+
 	for (i = 0; i < num_ranges; i++) {
 		const int j = i * 2;
 		u32 mask;
 
-		mask = mmc_vddrange_to_ocrmask(voltage_ranges[j],
-					       voltage_ranges[j + 1]);
+		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
+					       be32_to_cpu(voltage_ranges[j + 1]));
 		if (!mask) {
 			ret = -EINVAL;
 			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
-- 
1.7.7

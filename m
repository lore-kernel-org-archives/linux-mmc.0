From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] mmc: mxs-mmc: Enable MMC_CAP_ERASE
Date: Thu, 14 Mar 2019 17:18:22 +0100
Message-ID: <1552580302-11393-1-git-send-email-stefan.wahren@i2se.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

According to the i.MX23/28 reference manuals both mmc interfaces support
the MMC_ERASE command. So enable this capability in the driver to allow
erase/discard/trim requests.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/mxs-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4f06fb0..c021d43 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -648,7 +648,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	/* set mmc core parameters */
 	mmc->ops = &mxs_mmc_ops;
 	mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23;
+		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23 |
+		    MMC_CAP_ERASE;
 
 	host->broken_cd = of_property_read_bool(np, "broken-cd");
 
-- 
2.7.4

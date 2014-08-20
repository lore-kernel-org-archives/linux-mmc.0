From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] mmc: sunxi: Declare ERASE capability
Date: Wed, 20 Aug 2014 21:39:20 +0800
Message-ID: <1408541960-14788-1-git-send-email-wens@csie.org>
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
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: david.lanzendoerfer@o2s.ch, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Declare ERASE capability so we can use filesystems with the discard
option and the fstrim tool.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 024f67c..7bf5c1c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	/* 400kHz ~ 50MHz */
 	mmc->f_min		=   400000;
 	mmc->f_max		= 50000000;
-	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
+	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				  MMC_CAP_ERASE;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.1.0

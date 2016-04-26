From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] mmc: sunxi: Disable eMMC HS-DDR (MMC_CAP_1_8V_DDR) for Allwinner A80
Date: Tue, 26 Apr 2016 23:37:26 +0800
Message-ID: <1461685046-24798-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

eMMC HS-DDR no longer works on the A80, despite it working when support
for this developed.

Disable it for now.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi,

When i worked on this it was working, but now it isn't. Unfortunately I
don't have my old tree to do a proper bisect. I probably won't have time
to dig into this issue before v4.6 release, so it's best to disable it
on the A80 for now.

Thanks.

---
 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8372a413848c..7fc8b7aa83f0 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1129,6 +1129,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 				  MMC_CAP_1_8V_DDR |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
+	/* TODO MMC DDR is not working on A80 */
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun9i-a80-mmc"))
+		mmc->caps &= ~MMC_CAP_1_8V_DDR;
+
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto error_free_dma;
-- 
2.8.1

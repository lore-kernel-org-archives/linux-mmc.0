From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: card: modify mmc_getgeo function
Date: Tue, 20 Sep 2011 16:38:49 +0530
Message-ID: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

In the earlier code the cylinder, sector and head are assigned
independently. Current patch generates the cylinder number
with the values of sector and head.
This patch only makes they cylinder value to be dependent on
the sector and head.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/card/block.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1ff5486..bebb13b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -226,9 +226,10 @@ static int mmc_blk_release(struct gendisk *disk, fmode_t mode)
 static int
 mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
 	geo->heads = 4;
 	geo->sectors = 16;
+	geo->cylinders = get_capacity(bdev->bd_disk) /
+		(geo->heads * geo->sectors);
 	return 0;
 }
 
-- 
1.7.1

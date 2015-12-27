From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 05/10] mmc: cb710: use to_platform_device()
Date: Sun, 27 Dec 2015 21:15:43 +0800
Message-ID: <fc686afe2f3846425396bebe8cac7d3b76da42a2.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geliang Tang <geliangtang@163.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/mmc/host/cb710-mmc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.h b/drivers/mmc/host/cb710-mmc.h
index 8984ec8..8ecd9e5 100644
--- a/drivers/mmc/host/cb710-mmc.h
+++ b/drivers/mmc/host/cb710-mmc.h
@@ -29,8 +29,7 @@ static inline struct mmc_host *cb710_slot_to_mmc(struct cb710_slot *slot)
 
 static inline struct cb710_slot *cb710_mmc_to_slot(struct mmc_host *mmc)
 {
-	struct platform_device *pdev = container_of(mmc_dev(mmc),
-		struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(mmc_dev(mmc));
 	return cb710_pdev_to_slot(pdev);
 }
 
-- 
2.5.0

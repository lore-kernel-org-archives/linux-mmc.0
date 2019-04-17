From: Pan Bian <bianpan2016@163.com>
Subject: mmc: core: fix possible use after free of host
Date: Wed, 17 Apr 2019 16:28:37 +0800
Message-ID: <1555489717-28294-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tony Lindgren <tony@atomide.com>, Mathieu Malaterre <malat@debian.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-mmc@vger.kernel.org

In the function mmc_alloc_host, the function put_device is called to
release allocated resources when mmc_gpio_alloc fails. Finally, the
function pointed by host->class_dev.class->dev_release (i.e.,
mmc_host_classdev_release) is used to release resources including the
host structure. However, after put_device, host is used and released
again. Resulting in a use-after-free bug.

Fixes: 1ed21719448("mmc: core: fix error path in mmc_host_alloc")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/mmc/core/host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a..f8ac567 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -429,8 +429,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
-		ida_simple_remove(&mmc_host_ida, host->index);
-		kfree(host);
 		return NULL;
 	}
 
-- 
2.7.4

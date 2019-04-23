From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 17/25] mmc: omap_hsmmc: Use dev_get_drvdata()
Date: Tue, 23 Apr 2019 15:50:12 +0800
Message-ID: <20190423075020.173734-18-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 29a1ddaa7466..952fa4063ff8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2077,7 +2077,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 	unsigned long flags;
 	int ret = 0;
 
-	host = platform_get_drvdata(to_platform_device(dev));
+	host = dev_get_drvdata(dev);
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
@@ -2118,7 +2118,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	struct omap_hsmmc_host *host;
 	unsigned long flags;
 
-	host = platform_get_drvdata(to_platform_device(dev));
+	host = dev_get_drvdata(dev);
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-- 
2.20.1

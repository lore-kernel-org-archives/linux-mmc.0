From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Subject: [PATCH v2] mmc: meson-gx: remove mmc host on device removal
Date: Sat, 18 Feb 2017 18:06:47 +0100
Message-ID: <20170218170647.5860-2-webczat@webczatnet.pl>
References: <20170218170647.5860-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170218170647.5860-1-webczat@webczatnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
List-Id: linux-mmc@vger.kernel.org

The mmc host was added in meson_mmc_probe, but never removed in
meson_mmc_remove.
Fix that by removing the host before deallocating other resources.

Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
Tested-by: Michał Zegan <webczat@webczatnet.pl>
---
changes since v1:
rebased on top of patchset at
https://patchwork.kernel.org/patch/9581057/
This is in turn based on patchset at
https://patchwork.kernel.org/patch/9561215/

 drivers/mmc/host/meson-gx-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e759e4c2e4a0..336b6a2e94c6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -791,6 +791,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
 {
 	struct meson_host *host = dev_get_drvdata(&pdev->dev);
 
+	mmc_remove_host(host->mmc);
+
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
 
-- 
2.11.0

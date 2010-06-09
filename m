From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/5] sdhci-s3c: add missing remove function
Date: Wed, 09 Jun 2010 11:39:40 +0200
Message-ID: <1276076383-24825-3-git-send-email-m.szyprowski@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index af21792..ad30f07 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -365,6 +365,26 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 {
+	struct sdhci_host *host =  platform_get_drvdata(pdev);
+	struct sdhci_s3c *sc = sdhci_priv(host);
+	int ptr;
+
+	sdhci_remove_host(host, 1);
+
+	for (ptr = 0; ptr < 3; ptr++) {
+		clk_disable(sc->clk_bus[ptr]);
+		clk_put(sc->clk_bus[ptr]);
+	}
+	clk_disable(sc->clk_io);
+	clk_put(sc->clk_io);
+
+	iounmap(host->ioaddr);
+	release_resource(sc->ioarea);
+	kfree(sc->ioarea);
+
+	sdhci_free_host(host);
+	platform_set_drvdata(pdev, NULL);
+
 	return 0;
 }
 
-- 
1.7.1.240.g225c

From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 7/8] mmc: sunxi: Set our device drvdata earlier
Date: Thu,  8 Mar 2018 15:52:53 +0100
Message-ID: <d4f41babadf6dcab3520d25c658b93c49d10f64d.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, ulf.hansson@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

As soon as the pm_runtime_enable hook is called, our runtime_suspend and
runtime_resume hooks can be called as well. However, we only set the device
drvdata that we will use after we have registered into the MMC core. Move
that earlier so that we don't have a race that could lead to a crash.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c6431f6e816f..f6374066081b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1336,6 +1336,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "mmc alloc host failed\n");
 		return -ENOMEM;
 	}
+	platform_set_drvdata(pdev, mmc);
 
 	host = mmc_priv(mmc);
 	host->dev = &pdev->dev;
@@ -1402,7 +1403,6 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 		goto error_free_dma;
 
 	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
-	platform_set_drvdata(pdev, mmc);
 	return 0;
 
 error_free_dma:
-- 
git-series 0.9.1

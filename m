From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/6] mmc: renesas_sdhc: remove eprobe jump label
Date: Tue,  7 Nov 2017 17:09:27 +0900
Message-ID: <1510042172-27220-2-git-send-email-yamada.masahiro@socionext.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

"goto eprobe" does nothing useful.  Return directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index fcf7235..4b7a4e2 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -495,9 +495,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		ret = PTR_ERR(priv->clk);
-		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
-		goto eprobe;
+		dev_err(&pdev->dev, "cannot get clock\n");
+		return PTR_ERR(priv->clk);
 	}
 
 	/*
@@ -524,10 +523,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	}
 
 	host = tmio_mmc_host_alloc(pdev);
-	if (!host) {
-		ret = -ENOMEM;
-		goto eprobe;
-	}
+	if (!host)
+		return -ENOMEM;
 
 	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
@@ -652,7 +649,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	tmio_mmc_host_remove(host);
 efree:
 	tmio_mmc_host_free(host);
-eprobe:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
-- 
2.7.4

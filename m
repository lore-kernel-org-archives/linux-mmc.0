From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 03/22] mmc: renesas_sdhi: remove eprobe jump label
Date: Sat, 25 Nov 2017 01:24:38 +0900
Message-ID: <1511540697-27387-4-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

"goto eprobe" does nothing.  Return directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix a typo : renesas_sdhc -> renesas_sdhi
  - Restore the "ret" printout for devm_clk_get()

 drivers/mmc/host/renesas_sdhi_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index fcf7235..0590ae0 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -497,7 +497,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->clk)) {
 		ret = PTR_ERR(priv->clk);
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
-		goto eprobe;
+		return ret;
 	}
 
 	/*
@@ -524,10 +524,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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
@@ -652,7 +650,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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

From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] mmc: dw_mmc: Indicate that regulators may be absent
Date: Tue, 30 Jul 2013 12:46:16 +0100
Message-ID: <1375184777-25404-4-git-send-email-broonie@kernel.org>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

Use regulator_get_optional() to tell the core that requests for regulators
can fail in a real system.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ee5f167..5424073 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2231,7 +2231,7 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	host->vmmc = devm_regulator_get(host->dev, "vmmc");
+	host->vmmc = devm_regulator_get_optional(host->dev, "vmmc");
 	if (IS_ERR(host->vmmc)) {
 		ret = PTR_ERR(host->vmmc);
 		if (ret == -EPROBE_DEFER)
-- 
1.8.3.2

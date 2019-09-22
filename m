From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 187/203] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date: Sun, 22 Sep 2019 14:43:33 -0400
Message-ID: <20190922184350.30563-187-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 1c81d69d4c98aab56c5a7d5a810f84aefdb37e9b ]

In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
the driver. However, this still means msdc_runtime_suspend|resume() gets
called during system suspend/resume, via pm_runtime_force_suspend|resume().

This means during system suspend/resume, the register context of the mtk-sd
device most likely loses its register context, even in cases when SDIO IRQs
have been enabled.

To re-enable the SDIO IRQs during system resume, the mtk-sd driver
currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
the SDIO card, but this isn't the recommended solution. Instead, it's
better to deal with this locally in the mtk-sd driver, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b6387ef71..978c8ccce7e31 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2421,6 +2421,9 @@ static void msdc_restore_reg(struct msdc_host *host)
 	} else {
 		writel(host->save_para.pad_tune, host->base + tune_reg);
 	}
+
+	if (sdio_irq_claimed(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static int msdc_runtime_suspend(struct device *dev)
-- 
2.20.1

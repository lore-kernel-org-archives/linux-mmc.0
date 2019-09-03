From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date: Tue,  3 Sep 2019 16:21:59 +0200
Message-ID: <20190903142207.5825-4-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

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
---
 drivers/mmc/host/mtk-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6946bb040a28..669ea0668159 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
 	} else {
 		host->save_para.pad_tune = readl(host->base + tune_reg);
 	}
+
+	if (sdio_irq_enabled(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
-- 
2.17.1

From: Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH V2 2/2] mmc: mediatek: fix SDIO IRQ detection issue
Date: Mon, 17 Jun 2019 19:04:08 +0800
Message-ID: <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
References: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, chaotian.jing@mediatek.com, matthias.bgg@gmail.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: yong.mao@mediatek.com, srv_heupstream@mediatek.com, jjian zhou <jjian.zhou@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: jjian zhou <jjian.zhou@mediatek.com>

If cmd19 timeout or response crcerr occurs during execute_tuning(),
it need invoke msdc_reset_hw(). Otherwise SDIO IRQ can't be detected.

Signed-off-by: jjian zhou <jjian.zhou@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fa7d420..ba1ad5e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1031,6 +1031,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	msdc_track_cmd_data(host, mrq->cmd, mrq->data);
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq);
+	if (host->error)
+		msdc_reset_hw(host);
 	mmc_request_done(host->mmc, mrq);
 }

--
1.9.1

From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v1] mmc: mediatek: Fixed bug where clock frequency could be set wrong
Date: Fri, 24 Feb 2017 16:22:07 +0800
Message-ID: <1487924527-22584-2-git-send-email-yong.mao@mediatek.com>
References: <1487924527-22584-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:23997 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751005AbdBXIWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2017 03:22:25 -0500
In-Reply-To: <1487924527-22584-1-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

This patch can fix two issues:

Issue 1:
The maximum value of clock divider is 0xff.
Because the type of div is u32, div may be larger than max_div.
In this case, we should use max_div to set the clock frequency.

Issue 2:
In previous code, we can not set the correct clock frequency when
div equals 0xff.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 07f3236..3174445 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -540,6 +540,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 mode;
 	u32 flags;
 	u32 div;
+	u32 max_div;
 	u32 sclk;
 
 	if (!hz) {
@@ -590,8 +591,18 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 			sclk = (host->src_clk_freq >> 2) / div;
 		}
 	}
+
+	/**
+	 * The maximum value of div is 0xff.
+	 * Check if the div is larger than max_div.
+	 */
+	max_div = 0xff;
+	if (div > max_div) {
+		div = max_div;
+		sclk = (host->src_clk_freq >> 2) / div;
+	}
 	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
-			(mode << 8) | (div % 0xff));
+		      (mode << 8) | div);
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
-- 
1.7.9.5


From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v5 12/12] mmc: mediatek: perfer to use rise edge latching for cmd line
Date: Wed, 11 Oct 2017 10:41:36 +0800
Message-ID: <1507689696-25928-13-git-send-email-chaotian.jing@mediatek.com>
References: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:53560 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932768AbdJKCm2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2017 22:42:28 -0400
In-Reply-To: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com

data lines have applied to perfer to use rise edge, also need
apply it to cmd line.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 95759bb..27a6225 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1550,7 +1550,8 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
-	if (final_rise_delay.maxlen >= 12 && final_rise_delay.start < 4)
+	if (final_rise_delay.maxlen >= 12 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
 		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-- 
1.8.1.1.dirty


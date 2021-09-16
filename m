Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FEC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F688611C4
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 18:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbhIPSVI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:21:08 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:58463
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S238824AbhIPST6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2021 14:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=PCF+Xo2nLU
        E+xPInggtNzHSH34QrjJaEbkWXuAtuuhQ=; b=k11ouRv/SSiEQQdpYuIAWQ9hX2
        w7wcjvaG1K3c+ounlIESJ9VCGfte2VD9rOSp4MDzenNsdgaMJOoUb+OXy5oJJXfh
        5rJiHteNYSQCGMEgr+7RZinu53ImvkJPXxQ+A0fY0lhwYsdjkHL3V8DUNyp0Pr+s
        R2oEhC9qzPVPAhC5E=
Received: from localhost.localdomain (unknown [223.104.212.225])
        by app2 (Coremail) with SMTP id XQUFCgCnrqJhikNhpMiKAA--.4926S4;
        Fri, 17 Sep 2021 02:18:27 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] drivers/mmc: fix reference count leaks in moxart_probe
Date:   Fri, 17 Sep 2021 02:18:08 +0800
Message-Id: <20210916181808.2399-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XQUFCgCnrqJhikNhpMiKAA--.4926S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1fXw1kWr4DAw4Utw1xGrg_yoW5Ww4xpF
        4rCF9xKryDtrsxAay7Cw4DXF15Zr1Fkw4a9r4ku3s7u345Jrs7Cwn7G3ZYqry8JFyxXFWF
        gF1YqF15WFy5XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjfU0BT5DUUUU
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAg4GEFKp2a8jBwAAsz
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The issue happens in several error handling paths on two refcounted
object related to the object "host" (dma_chan_rx, dma_chan_tx). In
these paths, the function forgets to decrement the reference count of
one or both objects' reference count increased earlier by
dma_request_chan(), causing reference count leaks.

Fix it by decreasing reference counts of both objects in each path
separately.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 38 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 6c9d38132..b5aa1010c 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -606,7 +606,28 @@ static int moxart_probe(struct platform_device *pdev)
 	host->sysclk = clk_get_rate(clk);
 	host->fifo_width = readl(host->base + REG_FEATURE) << 2;
 	host->dma_chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_chan_tx)) {
+		if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+            goto out;
+        }
+    }
+
 	host->dma_chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_chan_rx)) {
+		if (!IS_ERR(host->dma_chan_tx))
+			dma_release_channel(host->dma_chan_tx);
+		if (PTR_ERR(host->dma_chan_rx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out;
+        }
+        dev_dbg(dev, "PIO mode transfer enabled\n");
+        host->have_dma = false;
+    } else if (IS_ERR(host->dma_chan_tx)) {
+		dma_release_channel(host->chan_rx);
+		dev_dbg(dev, "PIO mode transfer enabled\n");
+		host->have_dma = false;
+    }
 
 	spin_lock_init(&host->lock);
 
@@ -615,15 +636,7 @@ static int moxart_probe(struct platform_device *pdev)
 	mmc->f_min = DIV_ROUND_CLOSEST(host->sysclk, CLK_DIV_MASK * 2);
 	mmc->ocr_avail = 0xffff00;	/* Support 2.0v - 3.6v power. */
 
-	if (IS_ERR(host->dma_chan_tx) || IS_ERR(host->dma_chan_rx)) {
-		if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER ||
-		    PTR_ERR(host->dma_chan_rx) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto out;
-		}
-		dev_dbg(dev, "PIO mode transfer enabled\n");
-		host->have_dma = false;
-	} else {
+    if (!IS_ERR(host->dma_chan_tx) && !IS_ERR(host->dma_chan_rx)) {
 		dev_dbg(dev, "DMA channels found (%p,%p)\n",
 			 host->dma_chan_tx, host->dma_chan_rx);
 		host->have_dma = true;
@@ -664,8 +677,13 @@ static int moxart_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(dev, irq, moxart_irq, 0, "moxart-mmc", host);
-	if (ret)
+	if (ret) {
+		if (host->have_dma) {
+			dma_release_channel(host->dma_chan_tx);
+			dma_release_channel(host->dma_chan_rx);
+		}
 		goto out;
+	}
 
 	dev_set_drvdata(dev, mmc);
 	mmc_add_host(mmc);
-- 
2.25.1


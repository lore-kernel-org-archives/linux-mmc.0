Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E4C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 02:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023A660FE7
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 02:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhI0CCN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Sep 2021 22:02:13 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:39157
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232434AbhI0CCM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2021 22:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=INcf37QQi9
        siQzq/L1Iyk1bKxcSM2+zBRsgtdm2Bjhw=; b=lYA4G2bIi1F4zXgtFKJ7DY8PQZ
        kaexJzBEr1Ez13IgvQuK8pDSRWMUfdKNWTfC7VH9pttlBOmeQfcRvT8azbU95AFl
        AqZx14T+pO+20W2r3g30SsBGjOZUOjlqHwjsfhfsv8Hggc/RIo/Ft80lrGte5QCp
        a3dD+J6OFsJBK8atM=
Received: from localhost.localdomain (unknown [39.144.40.15])
        by app2 (Coremail) with SMTP id XQUFCgDX3s6ZJVFhNA_yAA--.45020S4;
        Mon, 27 Sep 2021 10:00:24 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v2] drivers/mmc: fix reference count leaks in moxart_probe
Date:   Mon, 27 Sep 2021 09:57:59 +0800
Message-Id: <20210927015759.30855-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XQUFCgDX3s6ZJVFhNA_yAA--.45020S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xJF4Utw4rKFyUXr4xJFb_yoW8WrW8pF
        48Cr9IkrWUtr4akF47Ca1DWF18ur4Fyw43KrZ093s7Z34UJFsrC348Ga40qr95JryrXFZY
        gF1YqF15uFZ5JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbBMKJUUUUU==
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAg4REFKp2bi50AAAs+
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The issue happens in several error handling paths on two refcounted
object related to the object "host" (dma_chan_rx, dma_chan_tx). In
these paths, the function forgets to decrement one or both objects'
reference count increased earlier by dma_request_chan(), causing
reference count leaks.

Fix it by balancing the refcounts of both objects in some error
handling paths.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 6c9d38132..e27ab3446 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -621,6 +621,14 @@ static int moxart_probe(struct platform_device *pdev)
 			ret = -EPROBE_DEFER;
 			goto out;
 		}
+        if (!IS_ERR(host->dma_chan_tx)) {
+            dma_release_channel(host->dma_chan_tx);
+            host->dma_chan_tx = NULL;
+        }
+        if (!IS_ERR(host->dma_chan_rx)) {
+            dma_release_channel(host->dma_chan_rx);
+            host->dma_chan_rx = NULL;
+        }
 		dev_dbg(dev, "PIO mode transfer enabled\n");
 		host->have_dma = false;
 	} else {
@@ -675,6 +683,10 @@ static int moxart_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+    if (!IS_ERR_OR_NULL(host->dma_chan_tx))
+        dma_release_channel(host->dma_chan_tx);
+    if (!IS_ERR_OR_NULL(host->dma_chan_rx))
+        dma_release_channel(host->dma_chan_rx);
 	if (mmc)
 		mmc_free_host(mmc);
 	return ret;
-- 
2.25.1


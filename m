Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF12CC433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  9 Oct 2021 04:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB8C60F9C
	for <linux-mmc@archiver.kernel.org>; Sat,  9 Oct 2021 04:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhJIEWs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 9 Oct 2021 00:22:48 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:56504
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229480AbhJIEWr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Oct 2021 00:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=djcJNMrGEx
        11DVeXfstEyaEscPLXu5hozbJu0q4CIqU=; b=tW3DT98Y/QG1bzhwtNp/ra8uo9
        Wxaa2l2HM3rczHiQ8lc4PvZ1UYti6+NOCW8R0N6R5XhfoJc87rGWOdBvR0uBOxEW
        l/WxbBN6V6gpxzqO6H0JD4MbPujy8rvVav3lfyer8hLJZHLQcf4JcQfMnWPwJSXF
        XUj9OTAUsElweQ/wY=
Received: from localhost.localdomain (unknown [10.102.225.147])
        by app2 (Coremail) with SMTP id XQUFCgBXim6OGGFhruAAAA--.1394S4;
        Sat, 09 Oct 2021 12:20:40 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v4] drivers/mmc: fix reference count leaks in moxart_probe
Date:   Sat,  9 Oct 2021 12:19:18 +0800
Message-Id: <20211009041918.28419-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XQUFCgBXim6OGGFhruAAAA--.1394S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xJF4Utw4rKFyUXr4xJFb_yoW8tr4xpF
        48Cr9xKrWUtr4agF4xCa1kXF18Zr1Fyw4akrZ8u3s7A34UJFnrC34kG3W0qF95JryrXa9Y
        gF15tF1ruFW8JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiARAIEFKp41whwwABsu
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The issue happens in several error handling paths on two refcounted
object related to the object "host" (dma_chan_rx, dma_chan_tx). In
these paths, the function forgets to decrement one or both objects'
reference count increased earlier by dma_request_chan(), causing
reference count leaks.

Fix it by balancing the refcounts of both objects in some error
handling paths. In correspondence with the changes in moxart_probe(),
IS_ERR() is replaced with IS_ERR_OR_NULL() in moxart_remove() as well.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 6c9d38132..7b9fcef49 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -621,6 +621,14 @@ static int moxart_probe(struct platform_device *pdev)
 			ret = -EPROBE_DEFER;
 			goto out;
 		}
+		if (!IS_ERR(host->dma_chan_tx)) {
+			dma_release_channel(host->dma_chan_tx);
+			host->dma_chan_tx = NULL;
+		}
+		if (!IS_ERR(host->dma_chan_rx)) {
+			dma_release_channel(host->dma_chan_rx);
+			host->dma_chan_rx = NULL;
+		}
 		dev_dbg(dev, "PIO mode transfer enabled\n");
 		host->have_dma = false;
 	} else {
@@ -675,6 +683,10 @@ static int moxart_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	if (!IS_ERR_OR_NULL(host->dma_chan_tx))
+		dma_release_channel(host->dma_chan_tx);
+	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
+		dma_release_channel(host->dma_chan_rx);
 	if (mmc)
 		mmc_free_host(mmc);
 	return ret;
@@ -687,9 +699,9 @@ static int moxart_remove(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, NULL);
 
-	if (!IS_ERR(host->dma_chan_tx))
+	if (!IS_ERR_OR_NULL(host->dma_chan_tx))
 		dma_release_channel(host->dma_chan_tx);
-	if (!IS_ERR(host->dma_chan_rx))
+	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
 	mmc_remove_host(mmc);
 	mmc_free_host(mmc);
-- 
2.25.1


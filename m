Return-Path: <SRS0=TOBz=6J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62211C55185
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438DF20704
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 13:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="dD8DUw+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYNB2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:01:28 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:60080 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbgDYNB2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 25 Apr 2020 09:01:28 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2020 09:01:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=johz7ezEhkI1R++xhPEgeFcUv28KqNL7JOn5MDPRhlk=; b=d
        D8DUw+viibmUZm5PP8JEIAolLCWyk3njOqMhSzngIu1I7TJFmhNS9SCNuhF7Tvi9
        n1kSwYBadRdIIFcaCz6OZpAj3Y/QcVmRxGygdblCpTP+qffosZfULnQmaEWEu8oF
        EAxbdD44guGglHl5iEDiBvUsBWnvYXxplnQXCtnkVw=
Received: from localhost.localdomain (unknown [120.229.255.80])
        by app1 (Coremail) with SMTP id XAUFCgAnLsb_MqRehWmNAA--.2704S3;
        Sat, 25 Apr 2020 20:54:24 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] mmc: owl-mmc: Fix dma_chan refcnt leak in owl_mmc_probe()
Date:   Sat, 25 Apr 2020 20:53:45 +0800
Message-Id: <1587819225-38916-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgAnLsb_MqRehWmNAA--.2704S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUCw4kJF13uF13XF1fZwb_yoW8ur1kpF
        WfG3yfKrW8KF45trZxGa18XF1Fqr4Ik34xKayDGw1rZ390q39FyF13CFyFgF1rJFykJwn2
        9F1jgr4rZFyDuw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5fHUUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

owl_mmc_probe() invokes dma_request_chan(), which returns a reference of
the specified dma_chan object to "owl_host->dma" with increased refcnt.

When owl_mmc_probe() encounters error, it calls mmc_free_host() to free
the "mmc" memory. Since "owl_host" comes from one of "mmc" fields, this
"free" behavior causes "owl_host" and "owl_host->dma" become invalid, so
the refcount for its field should be decreased to keep refcount balanced
before mmc_free_host() calls.

The reference counting issue happens in several exception handling paths
of owl_mmc_probe(). When those error scenarios occur such as failed to
request irq, the function forgets to decrease the refcnt increased by
dma_request_chan(), causing a refcnt leak.

Fix this issue by jumping to "err_put_dma" label when those error
scenarios occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/mmc/host/owl-mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 01ffe51f413d..4dc72f5f32f5 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -635,7 +635,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	owl_host->irq = platform_get_irq(pdev, 0);
 	if (owl_host->irq < 0) {
 		ret = -EINVAL;
-		goto err_free_host;
+		goto err_put_dma;
 	}
 
 	ret = devm_request_irq(&pdev->dev, owl_host->irq, owl_irq_handler,
@@ -643,19 +643,22 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq %d\n",
 			owl_host->irq);
-		goto err_free_host;
+		goto err_put_dma;
 	}
 
 	ret = mmc_add_host(mmc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add host\n");
-		goto err_free_host;
+		goto err_put_dma;
 	}
 
 	dev_dbg(&pdev->dev, "Owl MMC Controller Initialized\n");
 
 	return 0;
 
+err_put_dma:
+	if (owl_host->dma)
+		dma_release_channel(owl_host->dma);
 err_free_host:
 	mmc_free_host(mmc);
 
-- 
2.7.4


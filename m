Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6836C678D5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Mar 2023 16:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCGQqs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCGQqb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Mar 2023 11:46:31 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE3AD59C5;
        Tue,  7 Mar 2023 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZvgJq
        6YQjqwerye4CIoGP8CONxW/nYcnI2f8hDW3NOY=; b=eCxvF9lelgvUf1BW4fTWU
        3/qR3RaQjjJsIkdrGJ4A2xerExV7DE9Y8u0dyiGlEVFxwCugEImCwBTqxRpY54z0
        yZWmDDyIKS8GkOJOtKxaVovt3+HrONz2E+BxmboUgVlVRY4Za3C2HuM1XFckVdaH
        +TlYktQr7cJcHRHCwv+I/8=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wAnL_eIaQdk3p3pCQ--.58784S2;
        Wed, 08 Mar 2023 00:42:48 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     maximlevitsky@gmail.com
Cc:     oakad@yahoo.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] memstick: r592: Fix UAF bug in r592_remove due to race condition
Date:   Wed,  8 Mar 2023 00:42:47 +0800
Message-Id: <20230307164247.1245293-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnL_eIaQdk3p3pCQ--.58784S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rJryfAr4rKrWxGFyUWrg_yoWkuwb_uF
        yrZFySgr48Grn5Ww1UCFy3ur4Uuw1qgFZ7Za18Kry3JayUGF1UXr1kZr9ava1xu3y29Fy3
        CrWUJ3WIgw15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKBMNUUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXAorU1Xl52YmvgAAsH
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In r592_probe, dev->detect_timer was bound with r592_detect_timer.
In r592_irq function, the timer function will be invoked by mod_timer.

If we remove the module which will call hantro_release to make cleanup,
there may be a unfinished work. The possible sequence is as follows,
which will cause a typical UAF bug.

Fix it by canceling the work before cleanup in r592_remove.

CPU0                  CPU1

                    |r592_detect_timer
r592_remove         |
  memstick_free_host|
  put_device;       |
  kfree(host);      |
                    |
                    | queue_work
                    |   &host->media_checker //use

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/memstick/host/r592.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 1d35d147552d..2bfa7eaae80a 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -829,7 +829,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-
+del_timer_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {
-- 
2.25.1


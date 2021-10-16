Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C87BC433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Oct 2021 11:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D103261101
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Oct 2021 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbhJPL2o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 Oct 2021 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhJPL2o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Oct 2021 07:28:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712BEC061570;
        Sat, 16 Oct 2021 04:26:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa4so9034324pjb.2;
        Sat, 16 Oct 2021 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=r9fwNM9GKQH17yC9Q3NgykdrcmxUpMayXjBnqsUJA/0=;
        b=eMBXODueWZCF1lIKJ7Hd0flKHLkiZO3LfXKwhNIfdNKmmDZ1FbLrKs6Np+LC4PXdZZ
         4bOG39GvqJOnvlkUcPdrduDx8AlDVCExczFaQIXPCkeo1e87pTmCuy2IYfe8KR6wdw4j
         x7WVK9016VeDuYZjWDqcpTAqqZNOGl+JgnIH4D4u3m6m33SJ//lfoxpLUMDPp0TShl/c
         et7qB3yezm3S8QumdhCPi4H97M55n+N2W7ybK1MAgfZVHsgdP0HkAQLVeHhRzk1WmigX
         2uKw4GXQx6pFbiPk9SmBdep5VTcU79uOXq2IGhQ9duydZb0K1ul//wkhRG1F9YacQZOq
         3Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r9fwNM9GKQH17yC9Q3NgykdrcmxUpMayXjBnqsUJA/0=;
        b=f+/iR5flfut0N2xZvYBaicQGiYrz63xsouTH64w16jAj51eWnZ+dnN57J+kDqCIymv
         Mvs0ap37+eIcKJodMIb5UbdyuSh6XUh8tk1lSgVrq5e/5rC52+ts979Sk2nL8XHdpKkL
         ezzhVum0zEsUfKv6MQWjh6fQhNEoWrH/qAgBxWgDPPEXEaiDJp/kijWFQn51xkFxogpY
         I5Yiff+qmKFWjDU4P2A12X7D8mEWhkGG8CgVbUHH8ZNnBL1GfFD/ajlN8E06ih1vQi0f
         r4qNzm27RWu6t5sj9MB0+96Z2SEpuhpkCOykWPdMlOmKWYKlgzQfhLnz+Bifh3MxkeNq
         eaRQ==
X-Gm-Message-State: AOAM533h/q9IjBwtBB4KvRcVlrCAT5ly0I6g3yLfN5HvhcEJBTjPRZ59
        MyyCHSXzfqQDNNaN0KbIi2HBT8vTnKTg
X-Google-Smtp-Source: ABdhPJzGsqr8LeqTNeI6Koql+jBGFZuHGYGO7eFxnG8JX3bVKUJD1wkzkSl6NhSbq2pPiSIH3S66Rw==
X-Received: by 2002:a17:90b:4b85:: with SMTP id lr5mr20087134pjb.66.1634383595956;
        Sat, 16 Oct 2021 04:26:35 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id h4sm7096943pgn.6.2021.10.16.04.26.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Oct 2021 04:26:35 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] memstick: r592: Fix a UAF bug when removing the driver
Date:   Sat, 16 Oct 2021 11:26:21 +0000
Message-Id: <1634383581-11055-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In r592_remove(), the driver will free dma after freeing the host, which
may cause a UAF bug.

The following log reveals it:

[   45.361796 ] BUG: KASAN: use-after-free in r592_remove+0x269/0x350 [r592]
[   45.364286 ] Call Trace:
[   45.364472 ]  dump_stack_lvl+0xa8/0xd1
[   45.364751 ]  print_address_description+0x87/0x3b0
[   45.365137 ]  kasan_report+0x172/0x1c0
[   45.365415 ]  ? r592_remove+0x269/0x350 [r592]
[   45.365834 ]  ? r592_remove+0x269/0x350 [r592]
[   45.366168 ]  __asan_report_load8_noabort+0x14/0x20
[   45.366531 ]  r592_remove+0x269/0x350 [r592]
[   45.378785 ]
[   45.378903 ] Allocated by task 4674:
[   45.379162 ]  ____kasan_kmalloc+0xb5/0xe0
[   45.379455 ]  __kasan_kmalloc+0x9/0x10
[   45.379730 ]  __kmalloc+0x150/0x280
[   45.379984 ]  memstick_alloc_host+0x2a/0x190
[   45.380664 ]
[   45.380781 ] Freed by task 5509:
[   45.381014 ]  kasan_set_track+0x3d/0x70
[   45.381293 ]  kasan_set_free_info+0x23/0x40
[   45.381635 ]  ____kasan_slab_free+0x10b/0x140
[   45.381950 ]  __kasan_slab_free+0x11/0x20
[   45.382241 ]  slab_free_freelist_hook+0x81/0x150
[   45.382575 ]  kfree+0x13e/0x290
[   45.382805 ]  memstick_free+0x1c/0x20
[   45.383070 ]  device_release+0x9c/0x1d0
[   45.383349 ]  kobject_put+0x2ef/0x4c0
[   45.383616 ]  put_device+0x1f/0x30
[   45.383865 ]  memstick_free_host+0x24/0x30
[   45.384162 ]  r592_remove+0x242/0x350 [r592]
[   45.384473 ]  pci_device_remove+0xa9/0x250

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/memstick/host/r592.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index e79a0218c492..1d35d147552d 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -838,15 +838,15 @@ static void r592_remove(struct pci_dev *pdev)
 	}
 	memstick_remove_host(dev->host);
 
+	if (dev->dummy_dma_page)
+		dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
+			dev->dummy_dma_page_physical_address);
+
 	free_irq(dev->irq, dev);
 	iounmap(dev->mmio);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	memstick_free_host(dev->host);
-
-	if (dev->dummy_dma_page)
-		dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
-			dev->dummy_dma_page_physical_address);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.6


Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B0C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Feb 2022 12:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiBYMTp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbiBYMTp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2022 07:19:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363E2763E2;
        Fri, 25 Feb 2022 04:19:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n14so4204752wrq.7;
        Fri, 25 Feb 2022 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=o8+NAbtQaM8s0QBtxYtXps/G0x/Yv55F5vuRsn9wotI=;
        b=KuLnE3sLDbqmkuOj7t76BVglUHe1X9tcTFgwLI/gQUjbB0qhd9+wjcppT3k7+zMh8p
         3Qjkr+QPwhe6JrD2jkP1bmfCBkPfROR/b1d6FAYDErB4ybb3q49Uyi4fOSuJ3YgQ9gNR
         4GC03kRpyjF6nw0z9l3P6f5oDCUf8LBDSVImNGakqt0b7Da9RvvXfebbqTQ7XqRyR7lD
         EJ7bIsvl14f9qKX9xNJszbzbQN3riYjPJdjEWxbOn9hM6p+hAnJMQH3Z+ptG50jW9LiV
         J5FaL0VVLjqsf6Gxj5FOsnlpCkd0b6iYCbGcjJUCbZB276rbn35mNp0k+hlTkc5Ao1pD
         c1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o8+NAbtQaM8s0QBtxYtXps/G0x/Yv55F5vuRsn9wotI=;
        b=6bg25EkHMsMaqmUqrLDTs3dLgQSfedouGVY8EAwFYqF3xctKPRHu73owWAErT5ColP
         O7fjpR7ow0rS8J9/YUaDoem/twUb/YiW7sJYjAlsE87wpkbA3QlSHcrGnbVl1Vd7g/gR
         /QsnjpDFrqFKLP+vA1IX7yIUU1zCV9sgJMsb6nldd/5UC8aGJHplg21OBBbi9QviRDgG
         2jeKG1dhtE34CgTmvyJ7c4LwxSx1ZiFfVTAgcP3YTZarMMSEbl63RJdr6wDwC4pXsI1i
         XIr9nlQpzkFZqwYPD1UUBkrz4FU2fSG9XLyyRkhMySjVhNVy49Ftl0xf2WnN4/CFOeS0
         my9A==
X-Gm-Message-State: AOAM533xlKe0gNdZ0FGcdi/TIkveiFCibhCDDYafP7SoEHt6QN/JaSun
        5NYeokjcdpPZvUeGsLY7lEI=
X-Google-Smtp-Source: ABdhPJwxBXBS+ZQF6m1U2cdIolRn24v/xUbqgTXrq44N3GD4qPslMzYeXbDa1q+YqsmA6SmQo6F9bA==
X-Received: by 2002:adf:fe0d:0:b0:1e3:3f5e:7469 with SMTP id n13-20020adffe0d000000b001e33f5e7469mr5996025wrr.61.1645791551527;
        Fri, 25 Feb 2022 04:19:11 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id h9-20020adff189000000b001ea913352c9sm2048981wro.100.2022.02.25.04.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:19:11 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com,
        wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
        adrian.hunter@intel.com, swboyd@chromium.org, dev@lynxeye.de
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mmc: core: check the return value of wakeup_source_register()
Date:   Fri, 25 Feb 2022 04:18:58 -0800
Message-Id: <20220225121858.25638-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The function wakeup_source_register() in mmc_alloc_host() can fail, so
its return value should be checked.

Fixes: b52fb259dff8 ("mmc: core: Always allow the card detect uevent to be consumed")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mmc/core/host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index cf140f4ec864..4f1a6db10ec5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -550,6 +550,10 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
+	if (!host->ws) {
+		kfree(host);
+		return NULL;
+	}
 
 	host->parent = dev;
 	host->class_dev.parent = dev;
-- 
2.17.1


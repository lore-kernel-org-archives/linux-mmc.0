Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2FC4743C
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 07:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F148B611BF
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFWHw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFWHwY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2021 03:52:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FEC061766
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jun 2021 00:50:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11so1022078pji.5
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jun 2021 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuYPNFU9txTdGRZcF3YYQjjppc8t8coDcpnBFcAfxz8=;
        b=WxIKpIeM/n71gmq2xOQcm1GF+FSNoewHweAI8u9tn1ilb6Z4bnF0XUuGd8/t7/LeRZ
         a7QCcHayYtJ4ZTvA5afmJow0pijZ3nCmVl7d3jTmBIyM2nlIgWgPcrUzcNX9KQ8lOpl+
         UpAtQziMA6de4V3+DaNfb1kLzzRXFC4vO6YsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuYPNFU9txTdGRZcF3YYQjjppc8t8coDcpnBFcAfxz8=;
        b=uOn9DQ8QrBhC7gAaVLtMnCMrpFamfvGMD+8VFSd+OsAY1JB+Q7hifa4gf5BnPQF7vk
         CE1OybGltzOGeKr9gbQ7sDHpgFDUpF6lOw37YdUrIhVh+XpES2BNWYDyAbkKS5iSsyQz
         /DdIli3DJMJOIzqoB7oh/wdWwhvAg0gN0iJpiF5T3g/0KmqELbxCdPw52jBWKOE7KfWM
         MS0i73dgenWrZ6+lYI0SO74jCQgZf1LjIIihYnYgJQnC/2lo9+xDYRbckYliPCYqFokO
         CIYuBnp8BfE04mjhoGnJOWa0C4NlnLJfW/y0LANu0GWlfH+8JqkMvSKwIK1reyMOF/K7
         hVLg==
X-Gm-Message-State: AOAM533c8ecua2xSOsktVR1Q6xPuOzWwOk0LyUJnXlGuJWqs11G3LSEA
        JI6LUCvHcrsYS4twF1vgWmnjpA==
X-Google-Smtp-Source: ABdhPJzvs3ehbQT0RpLi7yefESHKpy37OOY0wZMYgzfaBPIITGk+1DZCKxPotLH6v3EW1BBIcWQ5TA==
X-Received: by 2002:a17:902:222:b029:11b:9cea:eea9 with SMTP id 31-20020a1709020222b029011b9ceaeea9mr25923383plc.11.1624434606079;
        Wed, 23 Jun 2021 00:50:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:afc8:33fb:90fb:4110])
        by smtp.gmail.com with ESMTPSA id m4sm4352625pjv.41.2021.06.23.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 00:50:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 2/2] mmc: core: Don't allocate IDA for OF aliases
Date:   Wed, 23 Jun 2021 00:50:02 -0700
Message-Id: <20210623075002.1746924-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210623075002.1746924-1-swboyd@chromium.org>
References: <20210623075002.1746924-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There's a chance that the IDA allocated in mmc_alloc_host() is not freed
for some time because it's freed as part of a class' release function
(see mmc_host_classdev_release() where the IDA is freed). If another
thread is holding a reference to the class, then only once all balancing
device_put() calls (in turn calling kobject_put()) have been made will
the IDA be released and usable again.

Normally this isn't a problem because the kobject is released before
anything else that may want to use the same number tries to again, but
with CONFIG_DEBUG_KOBJECT_RELEASE=y and OF aliases it becomes pretty
easy to try to allocate an alias from the IDA twice while the first time
it was allocated is still pending a call to ida_simple_remove(). It's
also possible to trigger it by using CONFIG_DEBUG_KOBJECT_RELEASE and
probe defering a driver at boot that calls mmc_alloc_host() before
trying to get resources that may defer likes clks or regulators.

Instead of allocating from the IDA in this scenario, let's just skip it
if we know this is an OF alias. The number is already "claimed" and
devices that aren't using OF aliases won't try to use the claimed
numbers anyway (see mmc_first_nonreserved_index()). This should avoid
any issues with mmc_alloc_host() returning failures from the
ida_simple_get() in the case that we're using an OF alias.

Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sujit Kautkar <sujitka@chromium.org>
Reported-by: Zubin Mithra <zsm@chromium.org>
Fixes: fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree alias")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mmc/core/host.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0b0577990ddc..8375d4381d47 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -75,7 +75,8 @@ static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
-	ida_simple_remove(&mmc_host_ida, host->index);
+	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
+		ida_simple_remove(&mmc_host_ida, host->index);
 	kfree(host);
 }
 
@@ -499,7 +500,7 @@ static int mmc_first_nonreserved_index(void)
  */
 struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
-	int err;
+	int index;
 	struct mmc_host *host;
 	int alias_id, min_idx, max_idx;
 
@@ -512,20 +513,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	alias_id = of_alias_get_id(dev->of_node, "mmc");
 	if (alias_id >= 0) {
-		min_idx = alias_id;
-		max_idx = alias_id + 1;
+		index = alias_id;
 	} else {
 		min_idx = mmc_first_nonreserved_index();
 		max_idx = 0;
-	}
 
-	err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
-	if (err < 0) {
-		kfree(host);
-		return NULL;
+		index = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
+		if (index < 0) {
+			kfree(host);
+			return NULL;
+		}
 	}
 
-	host->index = err;
+	host->index = index;
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
-- 
https://chromeos.dev


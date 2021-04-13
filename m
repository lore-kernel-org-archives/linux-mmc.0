Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE4EC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246AF61369
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 00:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhDMAgm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 20:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhDMAgm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 20:36:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D581EC061756
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 17:36:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e2so2966233plh.8
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 17:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z/gV1uw+1WUJ803DomVhy+FjKJUuyLwBV4VyAF5I0o=;
        b=QlhR4XyRBXoVjIT9WxcZrVOCSkvE10Hen14TPkIfO4d3fzTXGAOHjHjIT45GQqL10X
         IznjViCKuILs6G3Zw8lrUFf25nIrUr7Fn78ivDmmG4Lr7juzMK2vnHOWzG+7tbcWC/Ih
         MPOlU7b0l7cxkY1Jhib0gAavCqpralsRIBu2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z/gV1uw+1WUJ803DomVhy+FjKJUuyLwBV4VyAF5I0o=;
        b=DgTvJ87EE9nW4GsmCZM9KOJ6GmuQOem3ldebvNN0OV02PbCx+2geN+bOIkYgD/A8j4
         LZs3Ervy6mSVktDE40a/QtCQG6gGhGBXMvEU+M9UUeR6b7r+fXM7ckpIp4blavj725zE
         YXMesCqTrS8/FLF4kfHwClexu59aUUQVnrhlhZDqBslZFYsgXSZMRpCy7ikfzDi3MKz7
         HpxQ+vPX7LKIWL2fJs4E94GR8cctMl43guazbCFCbWKVa6elvSjF96YySyR/zRLOvLxa
         9XFm1B22LE8vCm8d0DALu7yVtlg6Pj1uzCgp/LBRXBx4O1xCnCMzFIxVVciWk99GZ0vY
         g01g==
X-Gm-Message-State: AOAM533rpF/6ebNRsExUbJWk90I+ePkg2Rt6MSw7bz03fH/9e+jXAH2n
        T97auw4wElhFTorN2Mnkg0Ssbw==
X-Google-Smtp-Source: ABdhPJwdzZ6PDjeDqmTWZdKfjvXsp2e0xNiRADLftfs8eU1VCVuMQmhkQslhZPjikMOTjTDOMZd/Cw==
X-Received: by 2002:a17:902:d78a:b029:e6:e1f:f695 with SMTP id z10-20020a170902d78ab02900e60e1ff695mr28631568ply.82.1618274183280;
        Mon, 12 Apr 2021 17:36:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id h19sm11087103pfc.172.2021.04.12.17.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 17:36:22 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH] mmc: core: Don't allocate IDA for OF aliases
Date:   Mon, 12 Apr 2021 17:36:21 -0700
Message-Id: <20210413003621.1403300-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
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
index 9b89a91b6b47..137b4a769f62 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -39,7 +39,8 @@ static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
-	ida_simple_remove(&mmc_host_ida, host->index);
+	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
+		ida_simple_remove(&mmc_host_ida, host->index);
 	kfree(host);
 }
 
@@ -444,7 +445,7 @@ static int mmc_first_nonreserved_index(void)
  */
 struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
-	int err;
+	int index;
 	struct mmc_host *host;
 	int alias_id, min_idx, max_idx;
 
@@ -457,20 +458,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
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


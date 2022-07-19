Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A3C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiGSJms (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiGSJmr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 05:42:47 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37B8327B06
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iHpJc
        ikL/0tf04tG20/PIH4KN4sANDRzJuCPKOmHtX4=; b=fGuw6NLAXHL9VaG0XvRSs
        G1s7aKctdQAJjzjqevr1HMWc+U1uww0iEox9WJKnc6hmU9CaQTqIoQ7U0GJ/1wQE
        CbQVtGVw1kxHrzk5aPCXxQVZLo4+KzgBcH06XLp+sq2V1+4DvsrJlbeVyF5doTl4
        HE6QcfGpiQuQon6jj5Cz78=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowACndDUbddZildNWHA--.55876S2;
        Tue, 19 Jul 2022 17:10:52 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, windhl@126.com
Subject: [PATCH] mmc: core: quirks: Add of_node_put() when breaking out of loop
Date:   Tue, 19 Jul 2022 17:10:51 +0800
Message-Id: <20220719091051.1210806-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowACndDUbddZildNWHA--.55876S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1xtrWDAr17Gw1kCryfJFb_yoWfKFg_CF
        1xWasruF4rZFyDWrnFvr4furyDtrsF9w1UWF4kt3yfA347Zry7XFZIvr9rX34UuFWqkFWU
        AwnrAr47ZrZ0gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRqg4PUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizg1DF18RPhVkEgAEsA
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In mmc_fixup_of_compatible_match(), we should call of_node_put()
when breaking out of for_each_child_of_node() which will increase
and decrease the refcount during one iteration.

Fixes: b360b1102670 ("mmc: core: allow to match the device tree to apply quirks")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/mmc/core/quirks.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index f879dc63d936..be4393988086 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -163,8 +163,10 @@ static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
 	struct device_node *np;
 
 	for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
-		if (of_device_is_compatible(np, compatible))
+		if (of_device_is_compatible(np, compatible)) {
+			of_node_put(np);
 			return true;
+		}
 	}
 
 	return false;
-- 
2.25.1


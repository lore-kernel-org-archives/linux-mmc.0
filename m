Return-Path: <SRS0=+qgY=A3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2308AC433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DAC20739
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ixomCN9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGPMnA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:43:00 -0400
Received: from crapouillou.net ([89.234.176.41]:48620 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMnA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jul 2020 08:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594903377; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=JtOYxXJepZlIjXy1qPF7xJcQfR1PdsqM0RsBODDedHY=;
        b=ixomCN9AwshC9ASwXo6Ec/GH9LXWIOMX490wSGerGVufLPooHfY4RRJODZf3bD8muevXGd
        jmqn04W5dXbba/ePFvNxwCyzDL56inqYc9wyBJJUSxiBXdw4j04UIoXPvT/kii5jJNQxHZ
        aUjfheP+Zm8Xps0KI32ClhNPypIOiNM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/3] PM: introduce pm_ptr() macro
Date:   Thu, 16 Jul 2020 14:42:48 +0200
Message-Id: <20200716124250.9829-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This macro is analogous to the infamous of_match_ptr(). If CONFIG_PM
is enabled, this macro will resolve to its argument, otherwise to NULL.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Notes:
    v2: Remove pm_sleep_ptr() macro
    v3: Rebase on 5.8-rc5 and add Ulf's Reviewed-by

 include/linux/pm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 121c104a4090..1f227c518db3 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -374,6 +374,12 @@ const struct dev_pm_ops name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
+#ifdef CONFIG_PM
+#define pm_ptr(_ptr) (_ptr)
+#else
+#define pm_ptr(_ptr) NULL
+#endif
+
 /*
  * PM_EVENT_ messages
  *
-- 
2.27.0


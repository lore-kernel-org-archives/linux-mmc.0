Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E46C2BA19
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE132063A
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 12:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MF7/qoYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgDMMcY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:32:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38288 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDMMcX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2020 08:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586781133; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VVfu6H9KODoFY0A3raww+c9Oss15tNQdxGds+ellWQ=;
        b=MF7/qoYvm7gxXkQzfeAA4I2UB7fq+Qkr+r1xUogxTqJYRNFRFQJ6+LZOeVCj5CWpQ9/lm6
        nIhvPDd0XX6ZT7cCH7pNX2Ngjq9etWEiu9vBm54059CwB2qvwfLOew6G/eALqWX6xRPo1Q
        QCMJ5UHSfIJDlgCH43OkG+s9yV0f+G0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     od@zcrc.me, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] PM: Make *_DEV_PM_OPS macros use __maybe_unused
Date:   Mon, 13 Apr 2020 14:32:06 +0200
Message-Id: <20200413123207.74552-2-paul@crapouillou.net>
In-Reply-To: <20200413123207.74552-1-paul@crapouillou.net>
References: <20200413123207.74552-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This way, when the dev_pm_ops instance is not referenced anywhere, it
will simply be dropped by the compiler without a warning.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 include/linux/pm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1c0eec06905d..5c9760f32d4f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -351,7 +351,7 @@ struct dev_pm_ops {
  * to RAM and hibernation.
  */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops name = { \
+const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
@@ -369,7 +369,7 @@ const struct dev_pm_ops name = { \
  * .runtime_resume(), respectively (and analogously for hibernation).
  */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-const struct dev_pm_ops name = { \
+const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
-- 
2.25.1


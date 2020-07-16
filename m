Return-Path: <SRS0=+qgY=A3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606ACC433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366FC20739
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DUq7Xnb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGPMnH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:43:07 -0400
Received: from crapouillou.net ([89.234.176.41]:48696 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMnH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jul 2020 08:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594903378; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjKImepJE6g0k1UCqOuIM6bQ4GRf7cW6YruWjxoUqzY=;
        b=DUq7Xnb6cPjBcbFvsJ6QiOEIQGVKvUzXx+dTtuR66Ib9CIkLjSAbDN18PUDrMABQIhG8el
        9VzI1Ac6IiI7DiAfZptUXbFZmHTmzSTC7AjCdusY9NAR+hakkh82uv5dWI2SaXHu+xSmAv
        K0+EgXcaUyQAyrq8EG5xfB75TKRJakg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/3] PM: Make *_DEV_PM_OPS macros use __maybe_unused
Date:   Thu, 16 Jul 2020 14:42:49 +0200
Message-Id: <20200716124250.9829-2-paul@crapouillou.net>
In-Reply-To: <20200716124250.9829-1-paul@crapouillou.net>
References: <20200716124250.9829-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This way, when the dev_pm_ops instance is not referenced anywhere, it
will simply be dropped by the compiler without a warning.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Notes:
    v2: No change
    v3: Rebase on 5.8-rc5 and add Ulf's Reviewed-by

 include/linux/pm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1f227c518db3..a30a4b54df52 100644
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
2.27.0


Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB58C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E6660F13
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbhIQGNI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbhIQGNC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 02:13:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3DAC061767
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 23:11:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso87269192qvw.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I9e6scqKSds0IiJpDE0EGiO45/93pXNyGD5DuUXEd/4=;
        b=ZGnu7bsUG8c4+ouWPO8+VzqsB82u7CgO47v+ThTR0fweLrffGOa51R5HLKqAHlRExO
         9rFAyy+PKnFjGo1z2kUYy8Xgt1bC9Qd05ttcAk+NWE7UxEwoR+EDGJannIDm56RHXct3
         UnDhbHbk1Cp+saWXfW8ErEcgjz3ZmKkqHUOtk5K0Z3bG8wPxVBaZyJYtZaNtp0ZYvP85
         a2gdZUykSMuMrgh8f5vgCTo/cG7+8s9FQLO10KmFKdcsqbnWglo/vda/DqTqJa5XDvp4
         mofUhZ7tqcMtYN5Q2FM9L9mZTp8VaY15xmD15ATeMJ+n/rm0WjR13KVVjKPW+8tdJLNP
         iDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I9e6scqKSds0IiJpDE0EGiO45/93pXNyGD5DuUXEd/4=;
        b=jjpwg6R1ubO/ayFtOKU8/xYXPn2aUJl3kBFj9Fua+yAlBQ9pD9zy+6rk3KFBq1z0bV
         TDwajMtF+fqV2Eu7tBBOQmzy3mFnSkfItevOCK5uQF/IdcM3wlFNb9XRG7kRhZIRXYSq
         RaFmeHFOJecrPVLWkGwXCTeD9FW28Y+d2wwTq9Y0AdS1+t/VzHEWyeHaghIaFQDL8CzL
         wihSjV07jy+p+eUDAdS5FLDoO/VhOYVlfr4Slu0fy8ZH+6JBI6H1LucD2T+29U0AJa2F
         75A5rnA8DMDy6DtP4GXOnpzE2Gm405dJTqJgNkc/mmWP0QmmZgmGXcr9pdffsUH+RHZM
         Uynw==
X-Gm-Message-State: AOAM530YA+audcH3ErXgiLYTZHy8KyHrDLBvyk1eaFTEHncxc96qFoPd
        3q1ZBy4XVosA0xKfgHMu40M5+7Yjs4y0Sl/oTZa19A==
X-Google-Smtp-Source: ABdhPJy9hOwDkvbV4NLyvh0qGcrMN7grCpA4gEVGgtpAr8OhFh/b/6LfxHBrVoqTc9/NxMbGI93vQBhA0PwmRN4wEK24qA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:adca:: with SMTP id
 d10mr11859759ybe.52.1631859099185; Thu, 16 Sep 2021 23:11:39 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:04 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 6/6] bitfield: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The structleak plugin causes the stack frame size to grow immensely:

lib/bitfield_kunit.c: In function 'test_bitfields_constants':
lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37c..c93c4b59af969 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -351,7 +351,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
-CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
+CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240) $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
-- 
2.33.0.464.g1972c5931b-goog


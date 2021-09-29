Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14164C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 21:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F330D61278
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346969AbhI2V3I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346928AbhI2V3D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2021 17:29:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F5C061769
        for <linux-mmc@vger.kernel.org>; Wed, 29 Sep 2021 14:27:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r5-20020a05620a298500b0045dac5fb940so11156097qkp.17
        for <linux-mmc@vger.kernel.org>; Wed, 29 Sep 2021 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GBgRPmylRP0XaI5E/LihaXT2Ir7X1xpw3ZInKRc4R50=;
        b=WHFQA+g25qkYPYFpep7vNNJTNwmmqsk9uHkMIXOXNnU9O5BPIQRfnn5cf/mGs1NaL+
         ogKT12Uh8k7K5urhYrNFdvA4MuqXpUSda3nB7WGcM7+TmYrb/KYXzXGlDr9DjrUV16I0
         rHwXYiunO8+vv1D/AhHbPY96DW0Dfw4rFl3WW3/Ie+sLyrSpeG+6nYS6+7KwC3QaTDAy
         kvG8F8Pay8skbykgIct0kmcVyTHUENlCleH7rnpjrTRQd1yF+nB+oZnvHiXisnyqj5hF
         B7JP6NY+hXsfKoG5gBkQZLzz+ZbQt1dS3slr7Wa8EFv5hkH1pcrphEZcixGC7BD/sLiC
         7jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GBgRPmylRP0XaI5E/LihaXT2Ir7X1xpw3ZInKRc4R50=;
        b=rfYllc4DZ11X0AB+yxUXHlp7CKPMdJ6QQ31Ee9pQDwKc3wKop8I9UR73hJIWrAJcev
         5y8HMk/9AzaPEtSkBxoY3Bh13Okkae0dRHkKLk7xHDNCuDx8WUdx+mm1JhWOWqcTwrmC
         pM6PcDGrBKvdUst+2iRi4LtiyH74OpirLc4EpJWOx25tBcT0GVoYOLThl3V08V/5/ktG
         TDXqIza4bqB9cqK2+BLX0dqOyWIqmAOEi2k436sU5sxHzajuhZisIvzofElvCp7mZVax
         Y9/NWRGM/HiAKx61owRrugNgqdj3H7cz/GA2Yuq16auD4BBk0iV9DaT9MTkPVU5oIqjx
         Y8Cg==
X-Gm-Message-State: AOAM532D+cb9B+timsPBojnr2txyUVuyqjCCbzPAgOMpCN72wpmjW24/
        Th7+sojj6u9+PlP7w6Fyu/O63vEQNgGqzw+NFbVV/w==
X-Google-Smtp-Source: ABdhPJyf4SNenqCX/qG/XKTasyzdp9ORUzCCpdL0aIBEMr9txfgQG0Tiw87AG132HGgvqre40Hvbdjn6vQZh3WqzsjyZdQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6214:362:: with SMTP id
 t2mr642333qvu.64.1632950841307; Wed, 29 Sep 2021 14:27:21 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:09 -0700
In-Reply-To: <20210929212713.1213476-1-brendanhiggins@google.com>
Message-Id: <20210929212713.1213476-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210929212713.1213476-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 1/5] gcc-plugins/structleak: add makefile var for disabling structleak
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

KUnit and structleak don't play nice, so add a makefile variable for
enabling structleak when it complains.

Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes since last revision:
 - None
---
 scripts/Makefile.gcc-plugins | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329a..4aad284800355 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -19,6 +19,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)		\
 		+= -fplugin-arg-structleak_plugin-byref
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
 		+= -fplugin-arg-structleak_plugin-byref-all
+ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
+    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
+endif
+export DISABLE_STRUCTLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
 
-- 
2.33.0.685.g46640cef36-goog


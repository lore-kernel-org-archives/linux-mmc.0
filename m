Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79DC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jul 2022 04:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiGOEEJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jul 2022 00:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbiGOEEE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2022 00:04:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFA4140F0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 21:04:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m5-20020a2598c5000000b0066faab590c5so3113501ybo.7
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dOShst8oggqOssAr1ulsAnblCITkep7trvJdY0C5eLU=;
        b=Of15lLAbml49VYHRN9m0VDbCfogr3SovyJGfgCQ7iaWxO2/arZgSm1JkWoAtfuWQlX
         luM3GfvnpmaLCfLXFRTXVP3skXL2hUMumL8ELP8qkLOb1o1ll5w6FN6C0XjjNbS9TDdN
         PsqVD12No9NSstS6gjWYJmxvG6m6l5eJSTmC4BXr+uKXuWjOQIM6AsEDP/qr9/oqEkP3
         zufyGVCthz1+/0+RbafqMV5x2ThixKyaYAePnveQzH/m8OkFCG4EgRf+6VnW42hlEdhv
         4dTf12NWb9TPo54ObWif+TwN/RlIsIBtA8+dlDJXCAmbeUPx84nRTKncRwJc0ouSdHDt
         eMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dOShst8oggqOssAr1ulsAnblCITkep7trvJdY0C5eLU=;
        b=6ow5p/8hI9Ce99EyGCL4OjL/KHvi3r3stat4bWrn6jbLuoAZAav9+Y5XcbKn8zEfhN
         22yBjUEMba+AyL18e5E4hFpk3JRJVQhZsjnB0J0hKpsoNG0jM3pgaiZr2uJTME+/OpoN
         am53lD6g2J8mwU5hQVI/TmXFjSK3rGg+J6Qf64ny+1bKkc/7snAnTZ/0uu1Bw3VGwNmW
         z102+O44kP/YHEWvWiGoRF/O9ds8KHpsIVeFcWG0asz3sSgSkicuqMQfJn+zX0m7BkUQ
         1QZlzl+C+AhTfWC479eN+I6QkzTizt9RoWb6UhktboXAFC+zEqgND3g3ahRIedvTfWV7
         X9Cg==
X-Gm-Message-State: AJIora8kfVip1mzHxlt6jrJOOjMb4Cb0+5t3c3fNNtxnsjf0ncZRKlkM
        bbAMxvjJGbLL926CD67BT5GQ4abg5iCV2A==
X-Google-Smtp-Source: AGRyM1vFpZrFOoq2yapQ0vGl3znNKM4Dn0ax0wtn3S4i2Fs4lp4ajUnIeHklnWD7RiS+zlb4i05wgHyYdzKpWw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a5b:bc2:0:b0:66e:4a75:e5ff with SMTP id
 c2-20020a5b0bc2000000b0066e4a75e5ffmr12004512ybr.642.1657857840574; Thu, 14
 Jul 2022 21:04:00 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:03:54 +0800
Message-Id: <20220715040354.2629856-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
when KUnit itself is being built as a module, the two together break.

This is because the KUnit tests (understandably) depend on KUnit, so a
built-in test cannot build if KUnit is a module.

Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
which only excludes this one problematic configuration.

This was reported on a nasty openrisc-randconfig run by the kernel test
robot, though for some reason (compiler optimisations removing the test
code?) I wasn't able to reproduce it locally on x86:
https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp@intel.com/T/

Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 10c563999d3d..e63608834411 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
 config MMC_SDHCI_OF_ASPEED_TEST
 	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
 	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
 	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
-- 
2.37.0.170.g444d1eabd0-goog


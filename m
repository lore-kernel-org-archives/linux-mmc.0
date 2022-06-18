Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB5C433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 18 Jun 2022 09:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiFRJEB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 18 Jun 2022 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiFRJD6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jun 2022 05:03:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94932066
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jun 2022 02:03:53 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u6-20020a17090a1d4600b001ec8200fe70so1165274pju.1
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jun 2022 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=myIlMYs7Kh5+xez48ocTcxFM1TIOp6h9g401FLEKFqU=;
        b=IEaKO/iZsLdPyJZ1LpJt4u+iLPMLa/M2HCAGnsppDn3A9MBSKBCVvZkH89wA7XifFt
         1yeZwF9Hq10m5fOKe63/QT58BXP03zeFTrKw4p9JhgTZg4In+OAHIAyVpgwcbULCBzST
         M/1jBrC/A3e2hcPWIcVx2w4pA0YHNV6h71fmSZ3XCiZASlg13Zth0fH8YOBpTpv94PKE
         QtxW4nGTlIVDFTryEGftNifeYuYFwUOm1NpslFOsMKptUqou0b5sA858ijDk7sR32+rj
         Mty1Gy1+ge2JfBX2XdqstVojlDrq1BzN9RZcgEo0YyHajWndO946UT7fQUxblM36JnP7
         /1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=myIlMYs7Kh5+xez48ocTcxFM1TIOp6h9g401FLEKFqU=;
        b=kL1HdbfPav3CqyyN5l94HD1dVb7H5qa5gZYqWSqKyXQRHGMc8SDb9YzYKteUMNgjGy
         9lvNBHSVwE2qAuPBBtU3ShkxvPYnFd8GV7AfVlNyxCpll5qiaEBvXSAWfdjjfaXmFi7b
         IfKMSBM3ity/7Q8Oizvv/r2xF+uR42OVHUcy6iVPFj0PsyeEDH7sq8Fx8xl6ht6gbD3Q
         F3Vog54REXmBPro6HfhrH5ff1T7M+hRMglpK1zLBUzazmnaHGPjrd/AHtz0Bqgsevr+S
         dArkc5MPlZZmu8mV6h/Oh2sJQ1+RpxESx0gQR++k6LQAlNs/hM5uv/Dcx+Y6WhaX3OKI
         1sXA==
X-Gm-Message-State: AJIora8OS4cT0+0xWNZ1qgw/WpNbvJyFmXthrFs5QNFqu2+XnXEIbgbz
        mtIKizt9GueqxtVZ3Ac7oKLv/NObSHLQKg==
X-Google-Smtp-Source: AGRyM1t9gG0ITBwjDzCGfVnRzUa4o4t3RyG/S7Wdnx7K6hex62KCdZbIOx7EIntyed7oeD+RzX1j54h7Te2odg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:4c0e:b0:1e8:859c:6b56 with SMTP
 id na14-20020a17090b4c0e00b001e8859c6b56mr25861123pjb.121.1655543033024; Sat,
 18 Jun 2022 02:03:53 -0700 (PDT)
Date:   Sat, 18 Jun 2022 17:03:10 +0800
In-Reply-To: <20220618090310.1174932-1-davidgow@google.com>
Message-Id: <20220618090310.1174932-6-davidgow@google.com>
Mime-Version: 1.0
References: <20220618090310.1174932-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 5/5] mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The kunit_test_suite() macro is no-longer incompatible with module_add,
so its use can be reinstated.

Since this fixes parsing with builtins and kunit_tool, also enable the
test by default when KUNIT_ALL_TESTS is enabled.

The test can now be run via kunit_tool with:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_OF=y --kconfig_add CONFIG_OF_ADDRESS=y \
	--kconfig_add CONFIG_MMC=y --kconfig_add CONFIG_MMC_SDHCI=y \
	--kconfig_add CONFIG_MMC_SDHCI_PLTFM=y \
	--kconfig_add CONFIG_MMC_SDHCI_OF_ASPEED=y \
	'sdhci-of-aspeed'

(It may be worth adding a .kunitconfig at some point, as there are
enough dependencies to make that command scarily long.)

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/mmc/host/Kconfig                |  5 +++--
 drivers/mmc/host/sdhci-of-aspeed-test.c |  8 +-------
 drivers/mmc/host/sdhci-of-aspeed.c      | 27 -------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d6144978e32d..10c563999d3d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -169,8 +169,9 @@ config MMC_SDHCI_OF_ASPEED
 	  If unsure, say N.
 
 config MMC_SDHCI_OF_ASPEED_TEST
-	bool "Tests for the ASPEED SDHCI driver"
-	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
+	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
+	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
 	  option only if you will boot the kernel for the purpose of running
diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index 1ed4f86291f2..ecb502606c53 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -96,10 +96,4 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
 	.test_cases = aspeed_sdhci_test_cases,
 };
 
-static struct kunit_suite *aspeed_sdc_test_suite_array[] = {
-	&aspeed_sdhci_test_suite,
-	NULL,
-};
-
-static struct kunit_suite **aspeed_sdc_test_suites
-	__used __section(".kunit_test_suites") = aspeed_sdc_test_suite_array;
+kunit_test_suite(aspeed_sdhci_test_suite);
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6..c10367946bc7 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -606,25 +606,6 @@ static struct platform_driver aspeed_sdc_driver = {
 
 #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
 #include "sdhci-of-aspeed-test.c"
-
-static inline int aspeed_sdc_tests_init(void)
-{
-	return __kunit_test_suites_init(aspeed_sdc_test_suites);
-}
-
-static inline void aspeed_sdc_tests_exit(void)
-{
-	__kunit_test_suites_exit(aspeed_sdc_test_suites);
-}
-#else
-static inline int aspeed_sdc_tests_init(void)
-{
-	return 0;
-}
-
-static inline void aspeed_sdc_tests_exit(void)
-{
-}
 #endif
 
 static int __init aspeed_sdc_init(void)
@@ -639,12 +620,6 @@ static int __init aspeed_sdc_init(void)
 	if (rc < 0)
 		goto cleanup_sdhci;
 
-	rc = aspeed_sdc_tests_init();
-	if (rc < 0) {
-		platform_driver_unregister(&aspeed_sdc_driver);
-		goto cleanup_sdhci;
-	}
-
 	return 0;
 
 cleanup_sdhci:
@@ -656,8 +631,6 @@ module_init(aspeed_sdc_init);
 
 static void __exit aspeed_sdc_exit(void)
 {
-	aspeed_sdc_tests_exit();
-
 	platform_driver_unregister(&aspeed_sdc_driver);
 	platform_driver_unregister(&aspeed_sdhci_driver);
 }
-- 
2.36.1.476.g0c4daa206d-goog


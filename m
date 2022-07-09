Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E92CC43334
	for <linux-mmc@archiver.kernel.org>; Sat,  9 Jul 2022 03:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGIDUp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jul 2022 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiGIDU2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2022 23:20:28 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD97E82E
        for <linux-mmc@vger.kernel.org>; Fri,  8 Jul 2022 20:20:20 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so311279pgc.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2022 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3UgqiERe4708PPmUCP4gASuMkT8EzAEhHtaVeGThrRE=;
        b=HrDQnG8us26mJ2YAoor+6KrTHMLNjUfKeb1RpTwQrywreVTSsr7GQrBYn4UXAQNlJ3
         oC6ykm4IvasRmUg8ADqyzsFpPSqwc0keB9rk5G/FJ2ieTx1MhxcR3oQs5bDudDxQcxJR
         89wVur6V4Q3ZE+hWcNAquew/0kLJJeyC6pXgHduTz816x77g/UJn3hV9FYC3GeWublXe
         wVQi6oSvR9trf2SPwZAhedaKnxmoMp6Ou2k1SRyLSTj2+CEzRAcVB13DPonVk9ix7/8L
         oyrqxyqwmG9daewfXZkx5D+E2m/2iEf9FxvENuwl2PgCfMt36QB5e3F1RXIfesUIEPVx
         o5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UgqiERe4708PPmUCP4gASuMkT8EzAEhHtaVeGThrRE=;
        b=Yr6w4LvgQjdCZTn9S/NncFnc60nRxUf88MpgsxPzeTmFvKOEClQaHMax9Q8DrfRVDx
         8ol8pWlvpIbIw7CDGLZE3V+SycDLen2FW7vUWrKEeTr7A5EMKlSSwO3C7bUSgbS89Uoe
         YbTQQLJOg0Q/OyKEdju5rTDZc1G3LC6EdwGJzdceARxX7I54QXI2jLFyZW0BW3vjMSSY
         EMYgIU8NwLs3PNDmIFICveM127aG9uAcji0jbDvlVz3QF2Tpla4/fTs+7Rp7B0984BRG
         R2d/HlHlhs8cuZMDNR6ced+F4+hGlmR9EfoiftIEO1d7XRuSXQIoYA05EMIoWk5Xtkby
         e3XA==
X-Gm-Message-State: AJIora++k5wEgNMqkDq3ZBm5xXKeGdR+71gJ7ARzmRE8+t49AGWW/Q8g
        X+LfZgFQfEBpPpFHCYOz0C9bRcDEsR8JNA==
X-Google-Smtp-Source: AGRyM1vKvq6yqyd6aJtlfnt1xgtTYaUqbYA51L/d3teKgb9KIKerezki/TfB587ENKF0KEBSJ6QDvuCNlkgzkA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:896:b0:1ef:935c:f326 with SMTP id
 bj22-20020a17090b089600b001ef935cf326mr3462419pjb.193.1657336819983; Fri, 08
 Jul 2022 20:20:19 -0700 (PDT)
Date:   Sat,  9 Jul 2022 11:19:59 +0800
In-Reply-To: <20220709032001.819487-1-davidgow@google.com>
Message-Id: <20220709032001.819487-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220709032001.819487-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 3/5] thunderbolt: test: Use kunit_test_suite() macro
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
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

The new implementation of kunit_test_suite() for modules no longer
conflicts with module_init, so can now be used by the thunderbolt tests.

Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
enabled.

This means that kunit_tool can now successfully run and parse the test
results with, for example:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
	'thunderbolt'

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20220625050838.1618469-4-davidgow@google.com/
- Rebase on top of the TAINT_TEST patch series. This should now apply
  cleanly on top of the kunit branch:
  https://lore.kernel.org/linux-kselftest/20220708044847.531566-1-davidgow@google.com/T/#u
- Add Brendan's Acked-by tag.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220621085345.603820-4-davidgow@google.com/
- Don't permit USB4_KUNIT_TESTS to be enabled when USB4=y and KUNIT=m
  i.e., add a dependency on (USB4=m || KUNIT=y)
  This would result in undefined kunit symbols being used, otherwise.
- Add Daniel's Acked-by

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-4-davidgow@google.com/
- Actually include the Kconfig changes, which were mistakenly added to
  the next patch in the series in v1.
- Add Acked-by tag from Mika Westerberg

---
 drivers/thunderbolt/Kconfig  |  6 ++++--
 drivers/thunderbolt/domain.c |  3 ---
 drivers/thunderbolt/tb.h     |  8 --------
 drivers/thunderbolt/test.c   | 12 +-----------
 4 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index 4bfec8a28064..e76a6c173637 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -28,8 +28,10 @@ config USB4_DEBUGFS_WRITE
 	  this for production systems or distro kernels.
 
 config USB4_KUNIT_TEST
-	bool "KUnit tests"
-	depends on KUNIT=y
+	bool "KUnit tests" if !KUNIT_ALL_TESTS
+	depends on (USB4=m || KUNIT=y)
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config USB4_DMA_TEST
 	tristate "DMA traffic test driver"
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 2889a214dadc..99211f35a5cd 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -872,7 +872,6 @@ int tb_domain_init(void)
 {
 	int ret;
 
-	tb_test_init();
 	tb_debugfs_init();
 	tb_acpi_init();
 
@@ -890,7 +889,6 @@ int tb_domain_init(void)
 err_acpi:
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 
 	return ret;
 }
@@ -903,5 +901,4 @@ void tb_domain_exit(void)
 	tb_xdomain_exit();
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 4602c69913fa..a831faa50f65 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1271,12 +1271,4 @@ static inline void tb_service_debugfs_init(struct tb_service *svc) { }
 static inline void tb_service_debugfs_remove(struct tb_service *svc) { }
 #endif
 
-#ifdef CONFIG_USB4_KUNIT_TEST
-int tb_test_init(void);
-void tb_test_exit(void);
-#else
-static inline int tb_test_init(void) { return 0; }
-static inline void tb_test_exit(void) { }
-#endif
-
 #endif
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index ee37f8b58f50..24c06e7354cd 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2817,14 +2817,4 @@ static struct kunit_suite tb_test_suite = {
 	.test_cases = tb_test_cases,
 };
 
-static struct kunit_suite *tb_test_suites[] = { &tb_test_suite, NULL };
-
-int tb_test_init(void)
-{
-	return __kunit_test_suites_init(tb_test_suites);
-}
-
-void tb_test_exit(void)
-{
-	return __kunit_test_suites_exit(tb_test_suites);
-}
+kunit_test_suite(tb_test_suite);
-- 
2.37.0.rc0.161.g10f37bed90-goog


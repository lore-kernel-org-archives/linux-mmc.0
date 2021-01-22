Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE8C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 03:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3E2388E
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 03:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAVDYw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 22:24:52 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35509 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbhAVDYv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 22:24:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5266C5C0243;
        Thu, 21 Jan 2021 22:23:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Jan 2021 22:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=uHl38MxIF2SnkIQDM+hVwSbWSG
        wnRbserqxthYXHezg=; b=KO663zyD/3pyTPh3b/pPhr2bd0HVJGuaA/lBksmvQP
        cN7tshvTGCOBs74DqkOpfZYANgKwKcUeUYvmuBbqAFtKH4xTWy2iD4VazUiR9g+5
        kv6nHUj2LfapSc2zvx30tZI2qQPCBHM529Bm305pWWAFYLdL2r0JBXpIAQWfOCyw
        Q+WRtuNapGdfuvyAdVA/oLQEHA0GEjg128g/XxThHUfo/W496wd74hUpFN9/QX3A
        yHVagsSc0U+NCNwOpMOvnuoAgmB2XU+QYOXXIa962+GgZ4P8gPtjjIk5mXQgPdji
        KLqLG9oC7UB5Ie2k0bzl/5MGdCpQpqsqWbThHjZXP3IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uHl38MxIF2SnkIQDM
        +hVwSbWSGwnRbserqxthYXHezg=; b=WSeMlxF1oXVSNgcZDTUxOWVIAYmq1AsvW
        jFQK6rSVcs6L0Bw4ty3WcmVdMKK3nCjB3tQT0Xs+mAnIcwD7toxnTYAGLa6E2JxN
        4W4/pm/psWfs5JRczaAzV1D1woDgpIsINAfIsXiJ2r/Mcw6HtcUdk9rU5r6NNQ58
        5o2dlDqdo1EPptEMyUqrY8FQGyeenIC7UfQKVb+pDQX2k5E/Kg8KXXkDJm/iVUCD
        J8P4L9TwLdCBiKrFeHWc7lROX6qVquG/nW40v2UFIDRQ4tyyDB31bbcjfiwEUzi0
        lESx1AQrUC0C9AHFS/9ogsiCaC7NWrWJHWGB5ZkFe+pAD2hI6y07w==
X-ME-Sender: <xms:QEUKYJyc6CbyUv3awMdvv0LNWORLguNfMmdDrRZ-s1zM-37iJmHNmA>
    <xme:QEUKYJTyhH1jk28biAY-hiBLs7VFZ7O3a6CpDrLg5vE5bdWRlNRMwTGgU6RgnFQEL
    vNpv-xAMT0SFXrLig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehnughrvgifucfl
    vghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrfgrthhtvghrnh
    epkefhieffjeevfeevhedtieeihfefvdejledvvddthefftedujeethfeuueelfedtnecu
    kfhppedvtdefrdehjedrvdduhedrvdefvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:QEUKYDWZXNOR00_aI5j5h4cLuEyFG-pL4V4JPLLRhu7TMS2vvpc9cg>
    <xmx:QEUKYLhF0qcRZvlA0u0ovt2DjashUHeqCF_WlBjdt2zlwH731KztOg>
    <xmx:QEUKYLDDDnEObcm_XFFZRNuxWNMUfmceVsFJFRYdvigpNkP5eWSXnA>
    <xmx:QUUKYN1gZtQkgD50r8vFTGT-SdopDqRQhKkdL-_aGCzkDnMZaTx5Ng>
Received: from localhost.localdomain (203-57-215-232.dyn.iinet.net.au [203.57.215.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18841108005B;
        Thu, 21 Jan 2021 22:23:40 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mmc: sdhci-of-aspeed: Fix kunit-related build error
Date:   Fri, 22 Jan 2021 13:53:34 +1030
Message-Id: <20210122032334.3663056-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Randy found that with the following Kconfig settings we have duplicate
definitions (e.g. __inittest()) in sdhci-of-aspeed due to competing
module_init()/module_exit() calls from kunit and driver the itself.

```
CONFIG_MMC_SDHCI_OF_ASPEED=m
CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
```

Conditionally open-code the kunit initialisation to avoid the error.

Fixes: 7efa02a981d6 ("mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed-test.c |  9 ++++++++-
 drivers/mmc/host/sdhci-of-aspeed.c      | 27 ++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index 34070605b28b..e5edda6c6e60 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -95,4 +95,11 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
 	.name = "sdhci-of-aspeed",
 	.test_cases = aspeed_sdhci_test_cases,
 };
-kunit_test_suite(aspeed_sdhci_test_suite);
+
+static struct kunit_suite *aspeed_sdhci_test_suite_array[] = {
+	&aspeed_sdhci_test_suite,
+	NULL,
+};
+
+static struct kunit_suite **aspeed_sdhci_test_suites
+	__used __section(".kunit_test_suites") = aspeed_sdhci_test_suite_array;
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 3b0d381e1215..1446f23a2bfb 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -556,6 +556,10 @@ static struct platform_driver aspeed_sdc_driver = {
 	.remove		= aspeed_sdc_remove,
 };
 
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+#include "sdhci-of-aspeed-test.c"
+#endif
+
 static int __init aspeed_sdc_init(void)
 {
 	int rc;
@@ -566,7 +570,20 @@ static int __init aspeed_sdc_init(void)
 
 	rc = platform_driver_register(&aspeed_sdc_driver);
 	if (rc < 0)
-		platform_driver_unregister(&aspeed_sdhci_driver);
+		goto cleanup_sdhci;
+
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+	rc = __kunit_test_suites_init(aspeed_sdhci_test_suites);
+	if (rc < 0) {
+		platform_driver_unregister(&aspeed_sdc_driver);
+		goto cleanup_sdhci;
+	}
+#endif
+
+	return 0;
+
+cleanup_sdhci:
+	platform_driver_unregister(&aspeed_sdhci_driver);
 
 	return rc;
 }
@@ -574,15 +591,15 @@ module_init(aspeed_sdc_init);
 
 static void __exit aspeed_sdc_exit(void)
 {
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+	__kunit_test_suites_exit(aspeed_sdhci_test_suites);
+#endif
+
 	platform_driver_unregister(&aspeed_sdc_driver);
 	platform_driver_unregister(&aspeed_sdhci_driver);
 }
 module_exit(aspeed_sdc_exit);
 
-#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
-#include "sdhci-of-aspeed-test.c"
-#endif
-
 MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
 MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-- 
2.27.0


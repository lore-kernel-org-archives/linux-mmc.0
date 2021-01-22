Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019FAC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B184D235F9
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 11:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAVLuY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 06:50:24 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59773 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727744AbhAVLuQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 06:50:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CC1C55C0136;
        Fri, 22 Jan 2021 06:49:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Jan 2021 06:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=Aur+84y6XjXo9NANGg4GxQPeSB
        LTSsh+b06q0PumXRo=; b=B/ZwTxPhfBRlLmStrbjvZaaD7Mg6w4qzJ8bXbu65KU
        3jMjIufM/Svx78Hrq3gvPtO3i1tTYYVrQiWcOiE3HYt4mknJbaTB1xrODEvGl8hm
        2T/O0iFeuzI7MA8qNSUT6s6hZRlnKHwJUbC5nNWLlJD2zz8iTW+V9tbqxkYMS2WC
        uJpVLCykxEbPaVo+0ia+S9vQzldlvC/LxKM6uMO/xntV9uPSnDv409y/LMBdixsy
        G3jJkaqbPvUMI49gTUL8jikPH8+IGBlOHNgGbH72BJl18CiF7aDJPkhDuBVCxp38
        KsI1iQkCUh3562uAHcxFVBV+/a7DKHNo9XVz95LCfETg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Aur+84y6XjXo9NANG
        g4GxQPeSBLTSsh+b06q0PumXRo=; b=BTZwdDg5goBiKkL5JBhrbjTMzetVczF1G
        TFmHprbqtWhp4v/Exo15rlz9xYnpAk7DpUk0yP2IuHqpdCziYtlFHsOjjjlWrZrD
        7lOsJM/wzvoyoo2n1lBOD1nYzGeSrr1IvQu3XNq9bilYyrvBIVvyf/k2H/PnAYJ8
        AlXV34P3q6/OjBEhnveifvq9TgZp8pTeRrV/Ty6N/AYp31PdGcLc1BWL28e6fxdX
        ECQnDdNfm1bD6tlDPe7awZVSxr6GDh0ATR434iUkjyXD/2fvuqC7nWaUWqddFub+
        B0AfmSSbXrGwEJVdt5AuITZumwc7EQwU2hUmrpqNLZCAqQyC6YNRg==
X-ME-Sender: <xms:sLsKYFTsNfHLxZXowxy_4GKEGa9aUE2WehOfEdjs7mn5SKkcC96NJw>
    <xme:sLsKYO6YSuYBcfBGfSarQgc34lQNvZs0UrR9fxILnGlKoKXYsE9X51RbE54wW7Apv
    kTuqBjYKHcArSbrRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehnughrvgifucfl
    vghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrfgrthhtvghrnh
    epkefhieffjeevfeevhedtieeihfefvdejledvvddthefftedujeethfeuueelfedtnecu
    kfhppedvtdefrdehjedrvdduhedrvdefvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:sLsKYCz7Y-Cdu2hE8WcTCdq7xt_lCadrhHnN-HsDrfSyFKxQAIjJ1A>
    <xmx:sLsKYFQ6-nXemAWFYWUKdKvQikIOTXTYoA-_u71_Xh7l5hWlMMkPwg>
    <xmx:sLsKYJVbTBeCUNF5pb8XLNXYZaVxe_jGc8sgdhRkgRA5pZweczZROw>
    <xmx:sbsKYLY2NGAXoGCXdsz3yIDGZCw3WO53noSAxjhKRuFMM7rq5J_vrA>
Received: from localhost.localdomain (203-57-215-232.dyn.iinet.net.au [203.57.215.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEB9124005C;
        Fri, 22 Jan 2021 06:49:00 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] mmc: sdhci-of-aspeed: Fix kunit-related build error
Date:   Fri, 22 Jan 2021 22:18:52 +1030
Message-Id: <20210122114852.3790565-1-andrew@aj.id.au>
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

v2:
* Collapse the #ifdef-ery

 drivers/mmc/host/sdhci-of-aspeed-test.c |  9 +++++-
 drivers/mmc/host/sdhci-of-aspeed.c      | 42 ++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index 34070605b28b..bb67d159b7d8 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -95,4 +95,11 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
 	.name = "sdhci-of-aspeed",
 	.test_cases = aspeed_sdhci_test_cases,
 };
-kunit_test_suite(aspeed_sdhci_test_suite);
+
+static struct kunit_suite *aspeed_sdc_test_suite_array[] = {
+	&aspeed_sdhci_test_suite,
+	NULL,
+};
+
+static struct kunit_suite **aspeed_sdc_test_suites
+	__used __section(".kunit_test_suites") = aspeed_sdc_test_suite_array;
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 3b0d381e1215..7d8692e90996 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -556,6 +556,29 @@ static struct platform_driver aspeed_sdc_driver = {
 	.remove		= aspeed_sdc_remove,
 };
 
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+#include "sdhci-of-aspeed-test.c"
+
+static inline int aspeed_sdc_tests_init(void)
+{
+	return __kunit_test_suites_init(aspeed_sdc_test_suites);
+}
+
+static inline void aspeed_sdc_tests_exit(void)
+{
+	__kunit_test_suites_exit(aspeed_sdc_test_suites);
+}
+#else
+static inline int aspeed_sdc_tests_init(void)
+{
+	return 0;
+}
+
+static inline void aspeed_sdc_tests_exit(void)
+{
+}
+#endif
+
 static int __init aspeed_sdc_init(void)
 {
 	int rc;
@@ -566,7 +589,18 @@ static int __init aspeed_sdc_init(void)
 
 	rc = platform_driver_register(&aspeed_sdc_driver);
 	if (rc < 0)
-		platform_driver_unregister(&aspeed_sdhci_driver);
+		goto cleanup_sdhci;
+
+	rc = aspeed_sdc_tests_init();
+	if (rc < 0) {
+		platform_driver_unregister(&aspeed_sdc_driver);
+		goto cleanup_sdhci;
+	}
+
+	return 0;
+
+cleanup_sdhci:
+	platform_driver_unregister(&aspeed_sdhci_driver);
 
 	return rc;
 }
@@ -574,15 +608,13 @@ module_init(aspeed_sdc_init);
 
 static void __exit aspeed_sdc_exit(void)
 {
+	aspeed_sdc_tests_exit();
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


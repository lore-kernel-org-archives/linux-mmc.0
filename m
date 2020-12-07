Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC06C4361B
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6833C235DD
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLGO1L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:27:11 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40249 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgLGO1L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 09:27:11 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E28325C011C;
        Mon,  7 Dec 2020 09:26:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Dec 2020 09:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jXa4aKo3nx/dV
        s37gK3g9kjteXpswH4afUKCgGV0MKg=; b=FGrw06NMzEk19w5OLMVmyeabRqty8
        bULlhTKWlNRmDB7KuXYfiqws/AWwof9/H84cebJ4bYqjfB/cLZUdsUXKxI73RINl
        sSCxHWlrUkGYv+I/zBo3MapMP+Tz+lCeNwapAvpiSgGUbHd8xorA94E1qJZhHngg
        Q81tjHb4k4c6cjTxtb2Ru53Mc2IRQbemgipwIuNPGP2j+nOVKT5ySp/9KJjHeOaU
        mCp2T/bZ5talA8aAooG2ovmjjm2JZiNDGErIrHs7r1ifG0iSCWjxf8mZC9nAxaw8
        yBOIfSjpsuaX7QZq8mLPrHGBlsWjaF4XZvaMLSSiTY+cvQ/tWYIQPDGEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jXa4aKo3nx/dVs37gK3g9kjteXpswH4afUKCgGV0MKg=; b=Q23Zjskl
        okBRu4lhBypfrEZ4g43WzZjAPSDpH0htXLSolWuPZ2XhIhb4JfZZCK/VQTwKwfxr
        uk129XcfFI8WuG+qa2n2opwZbVJeMLYmiouBf/XblH1er54j0niMxIKmSd7Q0X0x
        FcIg8JzJNy+xTi4JA8SdKRTZv6wI+2vXyz0ZXed5V3C8nx6Ibn9pv1k9K+Lm5VYk
        GlYFHD6acSkw354WiL9FyTQJlxYL1B+rQslk4vRFxxevXH4HG/z843aonHDAaCuI
        1yxY/SKKqf1ri3EOxSUxqsIGRPrCgF4f+L5j1yRW3FSb1UVSwWNIAuuU3d1oQTHH
        AJMco1EMNaSR/Q==
X-ME-Sender: <xms:kDvOX1gFv6Gw9Hc9P7hXmnXR9VWQ-Ii2ThVoUvRCA43PwSxPYVCBDg>
    <xme:kDvOX6rGJRtB1tyC9dszq72d65acWbPMcmLJ8W_fylm5OXnDKswILPMJHfmt-XLAe
    Nd77K1IcvacifxhNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:kDvOXwMi3GZDS74QkTXYUVObxb0gU-lr6UOsUR5qyoKgbi3ZpsU7EA>
    <xmx:kDvOX-03uKEKyrXC7KPe9yOY2pv5t84PZ_ArKWlseydicsEldGOxng>
    <xmx:kDvOX2od3iWVZlHlkU8zPSfnf0848apb7zkMMoyADwEf6oEWDC2ayQ>
    <xmx:kDvOXxUrRL3RGitq8fmhQLeW5OhftKgqzabY0s3VWWG-qFnrzdW0qA>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD0C3108005C;
        Mon,  7 Dec 2020 09:26:20 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v4 4/6] mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
Date:   Tue,  8 Dec 2020 00:55:54 +1030
Message-Id: <20201207142556.2045481-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201207142556.2045481-1-andrew@aj.id.au>
References: <20201207142556.2045481-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Converting degrees of phase to logic delays is irritating to test on
hardware, so lets exercise the function using KUnit.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/Kconfig                |  14 ++++
 drivers/mmc/host/Makefile               |   1 +
 drivers/mmc/host/sdhci-of-aspeed-test.c | 100 ++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 596f32637315..9f910655d6ea 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -168,6 +168,20 @@ config MMC_SDHCI_OF_ASPEED
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_ASPEED_TEST
+	bool "Test for the ASPEED SDHCI controller"
+	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	help
+	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
+	  option only if you will boot the kernel for the purpose of running
+	  unit tests (e.g. under UML or qemu).
+
+	  The KUnit tests generally exercise parts of the driver that do not
+	  directly touch the hardware, for example, the phase correction
+	  calculations.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_OF_AT91
 	tristate "SDHCI OF support for the Atmel SDMMC controller"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 451c25fc2c69..3ee59d5802cf 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
 obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
+obj-$(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)	+= sdhci-of-aspeed-test.o
 obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
new file mode 100644
index 000000000000..fb79b278fb81
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2020 IBM Corp. */
+
+#include <kunit/test.h>
+
+#include "sdhci-of-aspeed.c"
+
+static void aspeed_sdhci_phase_ddr52(struct kunit *test)
+{
+	int rate = 52000000;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 0));
+	KUNIT_EXPECT_EQ(test, 0,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 1));
+	KUNIT_EXPECT_EQ(test, 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 2));
+	KUNIT_EXPECT_EQ(test, 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 3));
+	KUNIT_EXPECT_EQ(test, 2,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 4));
+	KUNIT_EXPECT_EQ(test, 3,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 5));
+	KUNIT_EXPECT_EQ(test, 14,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 23));
+	KUNIT_EXPECT_EQ(test, 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 24));
+	KUNIT_EXPECT_EQ(test, 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 25));
+
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 180));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 181));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 182));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 183));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 184));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 185));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 203));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 204));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 205));
+}
+
+static void aspeed_sdhci_phase_hs200(struct kunit *test)
+{
+	int rate = 200000000;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 0));
+	KUNIT_EXPECT_EQ(test, 0,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 5));
+	KUNIT_EXPECT_EQ(test, 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 6));
+	KUNIT_EXPECT_EQ(test, 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 7));
+	KUNIT_EXPECT_EQ(test, 14,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 89));
+	KUNIT_EXPECT_EQ(test, 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 90));
+	KUNIT_EXPECT_EQ(test, 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 91));
+	KUNIT_EXPECT_EQ(test, 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 96));
+
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 180));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 185));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 186));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 187));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 269));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 270));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 271));
+	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+			aspeed_sdhci_phase_to_tap(NULL, rate, 276));
+}
+
+static struct kunit_case aspeed_sdhci_test_cases[] = {
+	KUNIT_CASE(aspeed_sdhci_phase_ddr52),
+	KUNIT_CASE(aspeed_sdhci_phase_hs200),
+	{}
+};
+
+static struct kunit_suite aspeed_sdhci_test_suite = {
+	.name = "sdhci-of-aspeed",
+	.test_cases = aspeed_sdhci_test_cases,
+};
+kunit_test_suite(aspeed_sdhci_test_suite);
-- 
2.27.0


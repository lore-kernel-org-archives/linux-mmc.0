Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3EC433E9
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1BD235FA
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhANDPr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 22:15:47 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37269 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbhANDPq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 22:15:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9797A5C01EF;
        Wed, 13 Jan 2021 22:14:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Jan 2021 22:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ktBCKi+jUj0gt
        3Epu2Bu08gNzdGJ5hXrCRAOgWSc5t4=; b=UzVoNnS2aPuyzVsDxYNj846XDyltG
        LZPJXiUy75PZAOQ6Wkps8EDQMwPmU3IISerd82dRa10fLHoo12lUrqKCkW9s/Bx5
        3+vC0Fxm0JDlcQVr/btALCOHhq5gTaDMIeuKyCZ4Ka2pJw4uFNFcs+D1pC5pwLXp
        Xsw2g+aM/ShZbAbDKaC3fxoCN0xciPluE0EH6ckPa09ehpyr68NH/eGQInTNVx1p
        IRpaCK5wcVO3HVDun2sD57lZimvhMNi8mOVxNi4b9QtavxuhwDVGQx5FXMkheZ3p
        GjATKVno70b8I3Xw3AIfd4J8UlvQhVbU7rClmGyAccijVb6SGgEgtY05w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ktBCKi+jUj0gt3Epu2Bu08gNzdGJ5hXrCRAOgWSc5t4=; b=iFDU7uX8
        Vyrlo5F/5czvCzBbCfYO7yOHmjdgMiaVtT3koHt3CiQZEPfw+n8gMhRjBT9/W1Xw
        DYW13JEqDGm2BQyft+2TEt103WVU+FTgGwSRBOgM91mRci0NmgEMYkr3FZNEN4lz
        EM9FrBQM/Uw86thdChOzbMI7DSpzz1sjYRyOFsE6Ggk7QvNvdc34mQfInXRdvCkJ
        c6cCzq/5oj+J+yrI68a9T6ow+Mpe5eROPYFsQxm7k0/nwDWcPkUNpAPFVXG3dtqj
        8zYNrxQ3Xee8birKUY12+VPaX75rvhld56uVRed/vugIG6UTNX1wJJawCLoWFL++
        qI4+FfuIG3yI+Q==
X-ME-Sender: <xms:M7f_X7jRG2EqHkHTn5DFckC0-eL4kXiYuoaftWRzeiOu0MdaawIwPw>
    <xme:M7f_X4C32YRlnolL4epfmoeqi1Zz7QptrGoJRlcLLBq92ixOZJfTrAfcY2lQEOba9
    dRqdYEG1v7RvQx_rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrudejfedrgeek
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:M7f_X7F58Exc8JrSciw4Siuk-ss_EXNwu_4bef1Z0FWu-bAYR6JFJw>
    <xmx:M7f_X4RCyME2Bd83Lyed0ga7AxEcHqjGT1YEydV6qpWqf5bWqvCxNQ>
    <xmx:M7f_X4yu-nOMJOTm-FE2MhaiUhilXHeJguqYwcH_tzA6WzSpFTTIxg>
    <xmx:M7f_X7whIIdeG2jToXvizZS2CyHIgpu0D-0LZWNCdNIKGRPusYsZxQ>
Received: from localhost.localdomain (ppp118-210-173-48.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.48])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55CCF24005E;
        Wed, 13 Jan 2021 22:14:56 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v7 4/6] mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
Date:   Thu, 14 Jan 2021 13:44:31 +1030
Message-Id: <20210114031433.2388532-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114031433.2388532-1-andrew@aj.id.au>
References: <20210114031433.2388532-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Converting degrees of phase to logic delays is irritating to test on
hardware, so lets exercise the function using KUnit.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/Kconfig                | 14 ++++
 drivers/mmc/host/sdhci-of-aspeed-test.c | 98 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c      |  4 +
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 596f32637315..d6f00d1d6251 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -168,6 +168,20 @@ config MMC_SDHCI_OF_ASPEED
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_ASPEED_TEST
+	bool "Tests for the ASPEED SDHCI driver"
+	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
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
diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
new file mode 100644
index 000000000000..34070605b28b
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2020 IBM Corp. */
+
+#include <kunit/test.h>
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
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4b30f6a1178e..3b0d381e1215 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -579,6 +579,10 @@ static void __exit aspeed_sdc_exit(void)
 }
 module_exit(aspeed_sdc_exit);
 
+#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
+#include "sdhci-of-aspeed-test.c"
+#endif
+
 MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
 MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
-- 
2.27.0


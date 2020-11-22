Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE84C5519F
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Nov 2020 12:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6501A2173E
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Nov 2020 12:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5YD5yth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKVMBB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Nov 2020 07:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVMBB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Nov 2020 07:01:01 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5C320760;
        Sun, 22 Nov 2020 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606046461;
        bh=I3DWUk0+LK+ydDC0aqmE7JEsQMt1l8GP+vkzk6BY8RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=O5YD5ythL2AleZsH8SsIXqhZZ+oidLXKa1/eONV0YqDFU31Zv6RoqnIzUCXCx8GKB
         ZzB2wJrRy5b74D2az5OWzU3TzBUIqBkF6VeCUfU6lVC3ykx72vfrT8HT1JLuzaR60I
         oxcPswxkO0UssD1+VWjpIolRK7koq3kZBJXEz178=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: mediatek: depend on COMMON_CLK to fix compile tests
Date:   Sun, 22 Nov 2020 13:00:56 +0100
Message-Id: <20201122120056.100045-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MFD_OMAP_USB_HOST uses Common Clock Framework thus it cannot be
built on platforms without it (e.g. compile test on MIPS with LANTIQ):

    mips-linux-ld: drivers/mmc/host/mtk-sd.o: in function `msdc_ops_set_ios':
    mtk-sd.c:(.text+0x2bbc): undefined reference to `clk_get_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 310e546e5898..bfe912ec8955 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1023,6 +1023,7 @@ config MMC_BCM2835
 config MMC_MTK
 	tristate "MediaTek SD/MMC Card Interface support"
 	depends on HAS_DMA
+	depends on COMMON_CLK
 	select REGULATOR
 	select MMC_CQHCI
 	help
-- 
2.25.1


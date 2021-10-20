Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E38C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E3761359
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTJIM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Oct 2021 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJTJIL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2021 05:08:11 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76379C06161C
        for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2021 02:05:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b4c3:ba80:54db:46f])
        by michel.telenet-ops.be with bizsmtp
        id 895u2600S12AN0U0695uCd; Wed, 20 Oct 2021 11:05:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1md7Xn-006Fys-BB; Wed, 20 Oct 2021 11:05:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1md77m-00FOga-L5; Wed, 20 Oct 2021 10:39:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] mmc: sdhci-omap: Remove forward declaration of sdhci_omap_context_save()
Date:   Wed, 20 Oct 2021 10:39:02 +0200
Message-Id: <20211020083902.3669769-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If CONFIG_PM_SLEEP=n:

    drivers/mmc/host/sdhci-omap.c:1213:13: error: ‘sdhci_omap_context_save’ declared ‘static’ but never defined [-Werror=unused-function]
     1213 | static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host);
	  |             ^~~~~~~~~~~~~~~~~~~~~~~

The referenced commit added an unrelated forward declaration of
sdhci_omap_context_save(), which is unneeded in general, and unused when
CONFIG_PM_SLEEP=n.

Fixes: f433e8aac6b94218 ("mmc: sdhci-omap: Implement PM runtime functions")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/sdhci-omap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 0dec2f849b81e242..a4a1734dcb84e9cf 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1210,8 +1210,6 @@ static const struct soc_device_attribute sdhci_omap_soc_devices[] = {
 	}
 };
 
-static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host);
-
 static int sdhci_omap_probe(struct platform_device *pdev)
 {
 	int ret;
-- 
2.25.1


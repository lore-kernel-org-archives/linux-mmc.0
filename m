Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12477C2D0CE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85022522
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 11:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YAhc267x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAUL1b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:27:31 -0500
Received: from condef-02.nifty.com ([202.248.20.67]:60884 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAUL1b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2020 06:27:31 -0500
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 06:27:30 EST
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-02.nifty.com with ESMTP id 00LAxSIX021830
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jan 2020 19:59:28 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 00LAx2Et000324;
        Tue, 21 Jan 2020 19:59:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 00LAx2Et000324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579604343;
        bh=O0rwpxOwq8LxYhFm+t57LbOcUgdP5n3Hsdr+/zEidLU=;
        h=From:To:Cc:Subject:Date:From;
        b=YAhc267xJhnOyYuuqDdZx1vZOB3t4vc0AdoWxOa6r4ahRcpFOB/PpD5f3ygjN2IXp
         /EB14JcIhE8A64LBaI8+ZuRZrQqAvYwFW7S5hajGSxfujlyVKMfYlVeijBjhZZ9EPI
         WWS1l4IsoE49V+R9oDi5YKM9Zqg3gNy+Gdk/ob6q40BQ/jVC5Q7G6M9y04jPc99YoI
         NVpNY/K+aZph3kk4ifFM8eKr5vRZIf4G/AT3gRU1lCaPDZUPPLRrBUe/wjjQXsGoOU
         rsgcxkH6OikTgeKM+O/u7ZJ4MgcKY6cuz26sr4JZS7KbpAP64pFWwCHHhEFR4c6TrW
         nObHI2LhMQi8w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: remove unneeded 'inline' marker
Date:   Tue, 21 Jan 2020 19:58:58 +0900
Message-Id: <20200121105858.13325-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

'static inline' in .c files does not make much sense because
functions may or may not be inlined irrespective of the 'inline'
marker. It is just a hint.

This function is quite small, so very likely to be inlined by the
compiler's optimization (-O2 or -Os), but it is up to the compiler
after all.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index ae0ec27dd7cc..5827d3751b81 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -158,7 +158,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
 	return 0;
 }
 
-static inline void *sdhci_cdns_priv(struct sdhci_host *host)
+static void *sdhci_cdns_priv(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
-- 
2.17.1


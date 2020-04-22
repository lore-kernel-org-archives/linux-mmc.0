Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26393C55185
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE88B2076E
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EI1FRHPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDVPgQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:36:16 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:27616 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDVPgP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 11:36:15 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 03MFYGMY002287;
        Thu, 23 Apr 2020 00:34:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 03MFYGMY002287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587569657;
        bh=rwMSy1LovyBoYlWhrHE4Cpvn0tJcHVV/wU2hEdyXFiw=;
        h=From:To:Cc:Subject:Date:From;
        b=EI1FRHPm3J416v+tdT2D5RbGqEs7FhDqvNK4DzULdSb9NlSZaIAhw/ZYeKyFUVpnE
         vpCTByjQopJcNJeiyOmoc1Qp+U31tMmEYeA3c5VJWqlhwzygRCkeDv+nUtM2iCrDRm
         ZAeNzsRN80GsVjJm5hbqceL1Cs0/Zn8VaCKTNDrlqAjCkVIPMl6HWt8XOZ4folNF+K
         3JYoc8kO5649Pz1pr3TgxIu03dbITTrUsr2xwHaZHR5AjTr6qPK1wIF5mVEehsMDpq
         /8URmxYIb1yHn/t2QfsUhht2vrXqyPfX8h86cjgT19fevnhpwIkko9E56hgkp5XMVL
         PE01Adq/kqq7Q==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-at91: make MMC_SDHCI_OF_AT91 depend on HAVE_CLK
Date:   Thu, 23 Apr 2020 00:34:01 +0900
Message-Id: <20200422153401.7913-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If sdhci-of-at91.c is compiled without CONFIG_HAVE_CLK, the line

  caps1 |= FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);

... emits "FIELD_PREP: value too large for the field" warning.

The compiler seems to decide clk_mul is constant (unsigned int)-1,
because clk_get_rate() returns 0 when CONFIG_HAVE_CLK is disabled.

Add HAVE_CLK to the depenency since this driver does not work without
the clock APIs anyway.

Link: https://lkml.org/lkml/2020/4/17/613
Fixes: linux-next ("mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Ulf,

I do not know how to fill the Fixes tag.
It is currently 8da1ff4f68a2 in linux-next, but I am not sure it is
stable. I just added 'linux-next'.

If you have a preferred way, please modify it.





 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 462b5352fea7..2aee844722d6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -171,7 +171,7 @@ config MMC_SDHCI_OF_ASPEED
 config MMC_SDHCI_OF_AT91
 	tristate "SDHCI OF support for the Atmel SDMMC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on OF
+	depends on OF && HAVE_CLK
 	help
 	  This selects the Atmel SDMMC driver
 
-- 
2.25.1


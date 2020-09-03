Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA2C433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 05:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6853B207EA
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 05:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599111822;
	bh=bVGHzeaQ+zZ2rlm9O/+KZJBG/FaDbOPzPAd0MPbfmhY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B1aYbGI1D+5WSbw4NcGElCrGXbhQJIzB/pJmZg+cSXBmMDlCjcpuMPxMV51mmqX1r
	 d/ZlBuxULtiOmGb0mHp0cgqkixprKyCqMrbubUldY0iaPRpweDAqLbqDYbEp6qbrLj
	 uIvLtC9NRBVYON4xA/gLgKg8oa5DkrbqE90kcxxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgICFnm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgICFnl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Sep 2020 01:43:41 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8AF2071B;
        Thu,  3 Sep 2020 05:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599111821;
        bh=bVGHzeaQ+zZ2rlm9O/+KZJBG/FaDbOPzPAd0MPbfmhY=;
        h=From:To:Cc:Subject:Date:From;
        b=sEglWioFqagWCPvGthokN5gicayXpn8RQmnujvYNxeYwh66BODsXrI1N+657nwPCG
         NZ0UPaNrAqRwQRAokUsdxkJHVKHrVb7QihDiee01s0qq9PZdyuFPmTOrfbNax4RzG+
         ldUGAj1r71Y2pABIL/HdntnAAjoqmXhZ6nw6hbQU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ben Dooks <ben-linux@fluff.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: s3cmci: Drop unused variables in dbg_dumpregs
Date:   Thu,  3 Sep 2020 07:43:33 +0200
Message-Id: <20200903054333.18331-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 'imask' and 'bsize' are not used in dbg_dumpregs:

  drivers/mmc/host/s3cmci.c:149:36: warning: variable 'imask' set but not used [-Wunused-but-set-variable]
  drivers/mmc/host/s3cmci.c:148:63: warning: variable 'bsize' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index ac94f926624d..40329aeacfdf 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -145,8 +145,8 @@ static void s3cmci_reset(struct s3cmci_host *host);
 
 static void dbg_dumpregs(struct s3cmci_host *host, char *prefix)
 {
-	u32 con, pre, cmdarg, cmdcon, cmdsta, r0, r1, r2, r3, timer, bsize;
-	u32 datcon, datcnt, datsta, fsta, imask;
+	u32 con, pre, cmdarg, cmdcon, cmdsta, r0, r1, r2, r3, timer;
+	u32 datcon, datcnt, datsta, fsta;
 
 	con 	= readl(host->base + S3C2410_SDICON);
 	pre 	= readl(host->base + S3C2410_SDIPRE);
@@ -158,12 +158,10 @@ static void dbg_dumpregs(struct s3cmci_host *host, char *prefix)
 	r2 	= readl(host->base + S3C2410_SDIRSP2);
 	r3 	= readl(host->base + S3C2410_SDIRSP3);
 	timer 	= readl(host->base + S3C2410_SDITIMER);
-	bsize 	= readl(host->base + S3C2410_SDIBSIZE);
 	datcon 	= readl(host->base + S3C2410_SDIDCON);
 	datcnt 	= readl(host->base + S3C2410_SDIDCNT);
 	datsta 	= readl(host->base + S3C2410_SDIDSTA);
 	fsta 	= readl(host->base + S3C2410_SDIFSTA);
-	imask   = readl(host->base + host->sdiimsk);
 
 	dbg(host, dbg_debug, "%s  CON:[%08x]  PRE:[%08x]  TMR:[%08x]\n",
 				prefix, con, pre, timer);
-- 
2.17.1


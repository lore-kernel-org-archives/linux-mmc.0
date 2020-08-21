Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A5C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309BD2078D
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Fj+Ksulr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHUIRA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:17:00 -0400
Received: from www.zeus03.de ([194.117.254.33]:37038 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgHUIQ7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 04:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=goFjW29c4qAtiC9urPtHEqFBkLU
        1WnIEHmuGrVQA9MY=; b=Fj+KsulrkriHtAV5q8wwYnvLMvlsArBpLZ3LNJMEdHt
        TNVSAM+P3NVka9O2ZvJBz5nLWLs26M7emOQSKxw9UX8xDgQB2Q9c48KKoBIvH2NF
        ptqyhZ5j3xEUn1HodPYkUmnDPIxwR5X38SVDtL7AMDzyELM1Vdk3KWkyO8IlcQkw
        =
Received: (qmail 798577 invoked from network); 21 Aug 2020 10:16:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2020 10:16:56 +0200
X-UD-Smtp-Session: l3s3148p1@7h803F6tlqogAwDPXweWAG48P/WlTOIM
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT] mmc: tmio: reset device on timeout, too
Date:   Fri, 21 Aug 2020 10:16:54 +0200
Message-Id: <20200821081654.28280-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When a command response times out, the TMIO driver has been resetting
the controller ever since. However, this means some initialization like
bus width or tuning settings will be forgotten. To ensure proper working
in all code paths, we will enforce a reset of the remote device, too.
Many thanks to the Renesas BSP team for the detailed description of the
problem.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This patch depends on the TMIO reset refactorization:

[RFT 0/6] mmc: refactor reset callbacks

Looking also for tests here. Thanks!

 drivers/mmc/host/tmio_mmc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ab910043808f..0d64308c619f 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -220,6 +220,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	tmio_mmc_reset(host);
+	mmc_hw_reset(host->mmc);
 
 	/* Ready for new calls */
 	host->mrq = NULL;
-- 
2.20.1


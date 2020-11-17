Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B194C63798
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 13:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161EE246BB
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 13:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GQqqV4DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgKQNOB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 08:14:01 -0500
Received: from www.zeus03.de ([194.117.254.33]:53214 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbgKQNOB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Nov 2020 08:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=owpNZwuLqgi7IGeMqAlN/X0uPN5
        jh0OF1TSotPN9w1U=; b=GQqqV4DMgGB7v6URdzOa0kaEOMSSkU/vMqZM0CNezCm
        HwSaJ+UWMV7oTuXPnni6rZ/Y8o3fRfIBNnpK8c66V9kROklBSa1ips6LGhgo8J1W
        pR5/FyWpNXJaeoHwq+gCsBSv2HH1yGbVPLtdqMemiBEuWaB9eoSMJSNzs1nOaR4Y
        =
Received: (qmail 296406 invoked from network); 17 Nov 2020 14:13:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Nov 2020 14:13:58 +0100
X-UD-Smtp-Session: l3s3148p1@NqGBRE20pIUgAwDPXxaWAHZio88zPEfF
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: Fix command error processing
Date:   Tue, 17 Nov 2020 14:13:37 +0100
Message-Id: <20201117131337.35307-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

If some errors are detected at the same time as the access end
interrupt, the access end interrupt was not cleared. Especially with
DMA, because then the access end interrupt was never enabled and, thus,
never cleared. Clear the interrupt register always when a command error
occurs.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
[saito: rebase to v5.4]
Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[wsa: rebase and extension of the commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Because the test case is hard to reproduce (lots of radio noise and
temperature changes), I trust the BSP team here. But the reasoning makes
a lot of sense to me. I verified that there are no regressions with the
test cases I usually do. The patch is based on mmc/next as of today,
i.e. with all previous series included.

 drivers/mmc/host/tmio_mmc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index cb4149fd12e0..7f4a28125010 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -796,8 +796,10 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (mrq->cmd->error || (mrq->data && mrq->data->error))
+	if (mrq->cmd->error || (mrq->data && mrq->data->error)) {
+		tmio_mmc_ack_mmc_irqs(host, TMIO_MASK_IRQ); /* Clear all */
 		tmio_mmc_abort_dma(host);
+	}
 
 	/* Error means retune, but executed command was still successful */
 	if (host->check_retune && host->check_retune(host))
-- 
2.28.0


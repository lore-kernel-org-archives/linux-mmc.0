Return-Path: <SRS0=e9Nt=6Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97A1C47255
	for <linux-mmc@archiver.kernel.org>; Mon, 11 May 2020 06:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63EE2080C
	for <linux-mmc@archiver.kernel.org>; Mon, 11 May 2020 06:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VxSEeN8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEKGXP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 May 2020 02:23:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:52770 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgEKGXP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2020 02:23:15 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 04B6M5C5023979;
        Mon, 11 May 2020 15:22:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 04B6M5C5023979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589178126;
        bh=lWEEk/UB9W3ReMXixlbRZ9stMPWNA/9DV2LRsKm7SiI=;
        h=From:To:Cc:Subject:Date:From;
        b=VxSEeN8BYA9+zhkFuXUrgVQ7dqnZw4w133yzIG24bjpADHkLL5yVEsPF1l1BvqQWA
         bHB4u40jjq8xa3TaIYpFcpv/9fL7K21qUSBeli/9UE7P/OVemWihFEBXnKhMYRe3PO
         8625aMG6dnE6z/H8Ao4kqKx3fEb2jIiHPngGjfphMX8qi73WUuB3dcqorB4bw3iKXq
         82/FUlPlzxJogQWBx2NM2F+Btq/FWsZj+/Y6V7wOKbyCPgHSXNi72qjr+VN5VyX8dS
         BpUeu11FFNsADGIcHgVaiQEr62rmrSmRA0QOzzilExU8iz0Yes0AiYGkXaQ/o+bagT
         eN6YzL3IzO59Q==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: uniphier-sd: call devm_request_irq() after tmio_mmc_host_probe()
Date:   Mon, 11 May 2020 15:21:58 +0900
Message-Id: <20200511062158.1790924-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently, tmio_mmc_irq() handler is registered before the host is
fully initialized by tmio_mmc_host_probe(). I did not previously notice
this problem.

The boot ROM of a new Socionext SoC unmasks interrupts (CTL_IRQ_MASK)
somehow. The handler is invoked before tmio_mmc_host_probe(), then
emits noisy call trace.

Move devm_request_irq() below tmio_mmc_host_probe().

Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/uniphier-sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index a1683c49cb90..f82baf99fd69 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -610,11 +610,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
-			       dev_name(dev), host);
-	if (ret)
-		goto free_host;
-
 	if (priv->caps & UNIPHIER_SD_CAP_EXTENDED_IP)
 		host->dma_ops = &uniphier_sd_internal_dma_ops;
 	else
@@ -642,8 +637,15 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
+	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
+			       dev_name(dev), host);
+	if (ret)
+		goto remove_host;
+
 	return 0;
 
+remove_host:
+	tmio_mmc_host_remove(host);
 free_host:
 	tmio_mmc_host_free(host);
 
-- 
2.25.1


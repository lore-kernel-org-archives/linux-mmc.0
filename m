Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A48C43381
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17DC20760
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 09:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgLWJH7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:07:59 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36012 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgLWJH6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 04:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608714306;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=ckSdKgJk3+oy3TeIeqOqAQsl5E4t5wchiiXSlOiigPI=;
        b=Iddma3lVm/ApaXBg5LOPmaqsLlriokrzh/3UIx6y2EpC6a63BFlZe+GWDC7LtY3cqa
        vBul3SpUTEIv0Y1htwxO65rYWFU5Ohm4meurJFeWaCjKAQyteoN7TX6vcwaF71y0Bt5K
        5Mv/nselQ6Xn5gjVy2+NTjY8/Kl48AKur54NVT+y7bJ+3OweGSe2mx/y1FhPTV3aIBMl
        ieLRYiJpP0lEVpRXTtC3RYPwvgxKoDqXuKt6nQH2af+E0Yt38/7eaF0hy/LZNyJC5W2w
        GZZM6KhJWIVqY4xO+dYxjKd+o+iBHCz5t9iMV1E8X0Dx1Ml5rqsA3NNuHSoM6RTBKfXX
        52rA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH7FjJ5/fxd"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 47.10.6 DYNA|AUTH)
        with ESMTPSA id U05a81wBN91q1Lu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 23 Dec 2020 10:01:52 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: [PATCH 1/2] mmc: jz4740: remove unused struct component card_detect_irq
Date:   Wed, 23 Dec 2020 10:01:50 +0100
Message-Id: <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608714110.git.hns@goldelico.com>
References: <cover.1608714110.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I have not found any user for this struct component.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/host/jz4740_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index a1f92fed2a55b7..b3c636edbb4610 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -152,7 +152,6 @@ struct jz4740_mmc_host {
 	enum jz4740_mmc_version version;
 
 	int irq;
-	int card_detect_irq;
 
 	void __iomem *base;
 	struct resource *mem_res;
-- 
2.26.2


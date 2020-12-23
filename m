Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E31C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0ED02247F
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 09:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgLWJK6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:10:58 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:29233 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgLWJK6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 04:10:58 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2020 04:10:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608714486;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=bWfFA+3erMRdRT1G93Zujqalh9NeqGq0TkUqH4YyCfU=;
        b=R3o7fvUF08xvnK93wDu+YG3wZAwF35bYOGZqqHqkuEIGfXBB5IGfRnDJQpj+UpBCQh
        r77/SQ+Co5/5GW+B4RHAKe5qEqH/5Y4SC3bJAzf+NqNn0YKoKIfXNbSAz9aVCYoi4jWS
        irT41h8AmWyUelwaw3MJ4b0ATjK40v3aPC4uDc/4nnNwspmROCobNC0p2yvM/+1ymRWw
        2kAoTjvQjWM/ZCRrN6pg0XBfv1FnC9wldXySWx0Nb2dfvRWUDb7uSKVelTpTaxsN9aGC
        SMBciDi5ITZiLKM4rRFtQNERWO/7WmPE9dn0pQLiigSfxlJYbOuwgd+ioWWok4S9pZmf
        R2LA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH7FjJ5/fxd"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 47.10.6 DYNA|AUTH)
        with ESMTPSA id U05a81wBN91q1Lv
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
Subject: [PATCH 2/2] mmc: omap: remove unused struct component card_detect_irq
Date:   Wed, 23 Dec 2020 10:01:51 +0100
Message-Id: <b6f2168b863e4273c6bca5a22fbd4a3a8ddf68d6.1608714110.git.hns@goldelico.com>
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
 include/linux/platform_data/mmc-omap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index f0b8947e6b07d8..91051e9907f34e 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -108,8 +108,7 @@ struct omap_mmc_platform_data {
 		const char *name;
 		u32 ocr_mask;
 
-		/* Card detection IRQs */
-		int card_detect_irq;
+		/* Card detection */
 		int (*card_detect)(struct device *dev, int slot);
 
 		unsigned int ban_openended:1;
-- 
2.26.2


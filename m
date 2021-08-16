Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36770C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 15:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FA760EE4
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 15:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhHPPbf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:31:35 -0400
Received: from smtp1.axis.com ([195.60.68.17]:19682 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhHPPbf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 11:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629127864;
  x=1660663864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BI34tEbJwrZR942+eD6h2RtVhZSp7r5K9TjHl+NAtCw=;
  b=jnkRJrF4g+5ku6cZoErHJ2IHl0LllZmpOR2mjwscKJsG5uPve0QKIrjN
   +PFo4XISM0hWgbYOPyyLqv6RPBo0Z5Yn651tS2ithy0XJm8VNadH+Wk5s
   hF9YGQLXdZOvMYpYpSI0iaXtWGCyFJoJu6OHv2IDwOo29aYQ94mVsrIG6
   McU9jRhPQknqghULn7yf13FpMvp6QHik9xI74AGAEffhOywOoMlu/XCmr
   LvRhJxvfCkRfFibA93F2S3nzl4+1Sx8Gri/KNtDo95W/V9iYIUm/HLbri
   1Mh+iWeG3plZkUo/icCUc7BIB9uHX/xWK8+gDF9wQM62rhJ98nRu3iMy+
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] mmc: host: Update card_busy callback info
Date:   Mon, 16 Aug 2021 17:30:54 +0200
Message-ID: <20210816153054.24082-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to SD specification checking state of DAT0 only is enough for
polling card busy signal. Header file comment says DAT[0:3]. Fix this.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 include/linux/mmc/host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0abd47e9ef9b..ff1a251bb0bc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -153,7 +153,7 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 
-	/* Check if the card is pulling dat[0:3] low */
+	/* Check if the card is pulling dat[0] low */
 	int	(*card_busy)(struct mmc_host *host);
 
 	/* The tuning command opcode value is different for SD and eMMC cards */
-- 
2.20.1


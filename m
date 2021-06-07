Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5872C47082
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 09:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0D5611AB
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 09:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhFGJVU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:21:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:48406 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGJVU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2021 05:21:20 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id B6FA9D1D45
        for <linux-mmc@vger.kernel.org>; Mon,  7 Jun 2021 17:18:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3122T139987246892800S1623057499015223_;
        Mon, 07 Jun 2021 17:18:19 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7573b093491a8b1d8a152d0b19272998>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-RCPT-COUNT: 3
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: block: Use .card_busy() to detect busy state in card_busy_detect
Date:   Mon,  7 Jun 2021 17:18:15 +0800
Message-Id: <1623057495-63363-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

No need to send CMD13 if host driver supports .card_busy().

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88f4c215..23623a9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -417,10 +417,17 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
 	u32 status;
+	bool busy;
 
 	do {
 		bool done = time_after(jiffies, timeout);
 
+		if (card->host->ops->card_busy) {
+			busy = card->host->ops->card_busy(card->host);
+			status = busy ?	0 : R1_READY_FOR_DATA | R1_STATE_TRAN << 9;
+			goto cb;
+		}
+
 		err = __mmc_send_status(card, &status, 5);
 		if (err) {
 			dev_err(mmc_dev(card->host),
@@ -442,6 +449,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 				 __func__, status);
 			return -ETIMEDOUT;
 		}
+cb:
 	} while (!mmc_ready_for_data(status));
 
 	return err;
-- 
2.7.4




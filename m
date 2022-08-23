Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B5C32772
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Aug 2022 16:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbiHWQrE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245703AbiHWQpv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2022 12:45:51 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F47AA342;
        Tue, 23 Aug 2022 07:30:48 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661265042t62a3cxi
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:30:41 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: KvvwR/hcPA3abwpyHORIvU+GPKhg501QjpAUzHteP4ReqEort98uP1AcDLsAq
        WrVaTVus6AHMZJEmoAujqBdTZJ0RFZ+bJ2Zt3MlpYFfKEESwyGI2aJ8x80REhyPsJF/MAWb
        zJ+nCXQxKj51ESiPmZK1zaLAFq7duUvYB7yuqYNP25ZCj3srr0WxA9PSFbw0d6PIDrgYVjQ
        E4NMkkhlwxegOvvAkGnza3o+PKceB9/RI0SYxIizqUFAC93Klrkogo0Ec9Ffq5cCBDOS45Q
        H8lmogKb0vbhADXBrc3xEKIQsTHLv9M/vSXKY/PJCNEUDMrUUya7mqVobbRfyFoBOZd3iDr
        z4zuufJ2wcOwOkZUJZzvAr3tDGTA/bXmdyL+ABlApIAvgvMpc8PGwG3aOafNgRMP17DGWnF
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mmc/host: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:30:34 +0800
Message-Id: <20220823143034.20543-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 581614196a84..7f00d7d7e35e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		 * is just about to roll over.
 		 *
 		 * We do this whole thing under spinlock and only if the
-		 * command hasn't already completed (indicating the the irq
+		 * command hasn't already completed (indicating the irq
 		 * already ran so we don't want the timeout).
 		 */
 		spin_lock_irqsave(&host->irq_lock, irqflags);
-- 
2.36.1


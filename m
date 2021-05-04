Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A192C433ED
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B93613C5
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 20:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhEDUd2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 May 2021 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhEDUd2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 16:33:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59322C061574;
        Tue,  4 May 2021 13:32:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y7so15165330ejj.9;
        Tue, 04 May 2021 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+WAhzdP859cnPeCIedjnSWgh7wM+d3lJE1B2lOJ2lo=;
        b=fAWK10XbeBYU/CZ0BaOeCT3j6uYBMt0KmSpmDHgQidw3BXFZ/WFSuwTT88Mp/48Wbw
         7eJsDuXTCNPl298XAikPJvylbL2Mf7EaHrpNsQ+LsugWbIyeQt9rwxS9xuUIil15TnQx
         R5Fblfvkg9/xhdcO+t0IbZsOpT+ZHtEjCC2BDdW8TVFzD2BrnyeeUeCU5zcscY+GDZSt
         5h1WOG9M+aJDT6pumDSg2cAZKIzsy8vUhOVw8ayVY71LkDLX9GcjRSf5aLB55d/gdFIy
         dmJUmK6GC8aABTb7xnHI50u6YT9qv6ocJ09KvtqVOYbeTPgd/vBX2Zjlg7N5fvM45KBu
         FgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+WAhzdP859cnPeCIedjnSWgh7wM+d3lJE1B2lOJ2lo=;
        b=kWbNKa5j08oVeaTnjTp/ttQaUhjlxlTXw88HFq/bkti+8AUTCOk9ylAdaaBBtu8iw3
         e9xu0f4n4u/0RhwO10ekVe03qVFYZlSJAmSPD4pW4+fEtgAcbUPfbCCJVEA0voP9Rtf3
         NUb5rRfr9cjceAUSrIjK0/H5NfpOo6KBxLrTpdPAkyGsZVdkBFfV5T4bYD8wxDtB69Tv
         2DoJt4eTwf0MsmiC/6hpYYUiFZJFZIASqsNkslZeY9OKT0P6I6rhx5kYscGI31h92Gxs
         OBe7PSXNLUjCwtykULKZtCIwbezr/hcvKCOV4DsiTK8zQ0yYaYBEOmrPL8MVqO8JSvTD
         JQRw==
X-Gm-Message-State: AOAM5335xFQ9O7+LIn0jjWxRWt8wEDOOU4L+fYriz3xuLZGcew5FkOyl
        9+mIFnk9Nk3SRHCVqh6QLNc=
X-Google-Smtp-Source: ABdhPJx9On1jC6rFO4wd0vFLnNAciS9RSj7Lc8RO1FGa8X7kp0YHt09XfZVspyjEYQjnH/lIY9TN6Q==
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr23426834ejf.341.1620160351157;
        Tue, 04 May 2021 13:32:31 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id cw6sm1900613ejb.32.2021.05.04.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:32:30 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>,
        Michael Brunner <Michael.Brunner@kontron.com>
Subject: [PATCH v1] mmc: block: Disable CMDQ on the ioctl path
Date:   Tue,  4 May 2021 22:32:09 +0200
Message-Id: <20210504203209.361597-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

According to the eMMC Spec:
"When command queuing is enabled (CMDQ Mode En bit in CMDQ_MODE_EN
field is set to ‘1’) class 11 commands are the only method through
which data transfer tasks can be issued. Existing data transfer
commands, namely CMD18/CMD17 and CMD25/CMD24, are not supported when
command queuing is enabled."
which means if CMDQ is enabled, the FFU commands will not be supported.
To fix this issue, just simply disable CMDQ on the ioctl path, and
re-enable CMDQ once ioctl request is completed.

Tested-by: Michael Brunner <Michael.Brunner@kontron.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..21fb99883b1e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1004,6 +1004,11 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 
 	switch (mq_rq->drv_op) {
 	case MMC_DRV_OP_IOCTL:
+		if (card->ext_csd.cmdq_en) {
+			ret = mmc_cmdq_disable(card);
+			if (ret)
+				break;
+		}
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
@@ -1014,6 +1019,8 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		/* Always switch back to main area after RPMB access */
 		if (rpmb_ioctl)
 			mmc_blk_part_switch(card, 0);
+		else if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
+			mmc_cmdq_enable(card);
 		break;
 	case MMC_DRV_OP_BOOT_WP:
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
-- 
2.25.1


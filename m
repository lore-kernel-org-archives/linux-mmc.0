From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 4/6] mmc: add FFU support to card/block.c
Date: Wed, 13 Apr 2016 15:33:42 -0700
Message-ID: <1460586824-40688-5-git-send-email-gwendal@chromium.org>
References: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34749 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbcDMWeZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 18:34:25 -0400
Received: by mail-pf0-f171.google.com with SMTP id c20so39264195pfc.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 15:34:24 -0700 (PDT)
In-Reply-To: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, Alex.Lemberg@sandisk.com, avi.shchislowski@sandisk.com, yaniv.agman@sandisk.com, holgerschurig@gmail.com, chris@printf.net, baolin.wang@linaro.org
Cc: linux-mmc@vger.kernel.org

From: Grant Grundler <grundler@google.com>

Add special case in MMC_IOC_CMD to process FFU command from mmc tool.
A FFU command is similar to a multi command, but it also require loading
firmware and maybe reset the device.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/card/block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c543dd9..dd266c0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -610,6 +610,11 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		goto cmd_done;
 	}
 
+	if (idata->ic.opcode == MMC_FFU_INVOKE_OP) {
+		err = mmc_ffu_invoke(card, (struct mmc_ffu_args *)idata->buf);
+		goto cmd_done;
+	}
+
 	mmc_get_card(card);
 
 	ioc_err = __mmc_blk_ioctl_cmd(card, md, idata);
-- 
2.8.0.rc3.226.g39d4020


From: Yong Li <sdliyong@gmail.com>
Subject: patch to disable reliable write if no CMD23 support
Date: Wed, 25 Apr 2012 13:27:50 +0800
Message-ID: <CADO9-pcOFfvisYd4eRHobu+QiwLkiXotNOQ+zwySEi1btm9ZtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53659 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab2DYF2N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 01:28:13 -0400
Received: by obbta14 with SMTP id ta14so2192411obb.19
        for <linux-mmc@vger.kernel.org>; Tue, 24 Apr 2012 22:28:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

Hi All,

Please check the below patch, For some eMMC, we disable the CMD23 for
performance, and it will disable the reliable write too

index dabec55..ea491d1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1113,7 +1113,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
        bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
                          (req->cmd_flags & REQ_META)) &&
                (rq_data_dir(req) == WRITE) &&
-               (md->flags & MMC_BLK_REL_WR);
+               (md->flags & MMC_BLK_REL_WR) &&
+               !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);

        memset(brq, 0, sizeof(struct mmc_blk_request));
        brq->mrq.cmd = &brq->cmd;

Thanks,
Yong Li

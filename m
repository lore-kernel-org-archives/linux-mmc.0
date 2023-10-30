Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D25C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Oct 2023 09:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjJ3JJ2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Oct 2023 05:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjJ3JJ1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Oct 2023 05:09:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62914DE
        for <linux-mmc@vger.kernel.org>; Mon, 30 Oct 2023 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698656965; x=1730192965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o03i99xVc8QsCbapwxniTwGQnhmBZ4RhcvPzoIpy8G0=;
  b=AsVKMewSXtKPioYvxJ8pucuA6RFtQEfMFILffk807aWB11s8bfVSLUjY
   Q8c9al0eVSxMhGiwvAbVnk9MvNE5yWYJSbZQL8ANko3SP4UVdvAhMKA39
   6fa8v3CdNHnkR2AT1WNGTRrrwX6+H8uim5niJ6SKZfO2B7yjQZ20F2+oz
   BIwz+WDGa+axXftx08QD0AnZfpx+K49CcSE9l+o9sxXIl26riIxwsg9HT
   g8DkpH8XhT4wEKh0a/sXLfrtDtlrh99hS+KkbNWIzugrrAn0/zoOonc4r
   j1+PBQXJaMt2mdVZBmvDMB0st9kAFQwWLQ3kUkvFpZAwBAgKtOhfu4E9I
   A==;
X-CSE-ConnectionGUID: 3XEiIz7QTvWPtoiV7Rg5Cg==
X-CSE-MsgGUID: Tmml7REYRGSqp3MVaLsbWw==
X-IronPort-AV: E=Sophos;i="6.03,263,1694707200"; 
   d="scan'208";a="1047125"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2023 17:09:24 +0800
IronPort-SDR: wHWwmGljlKb4yvBioC0yzN6ZgGzCCELUk2jTUkuQebolY7qx1JUPio4R18fRUszkkbg6LRZys7
 ynsGeU0ORCGUHH4YIxiQg3uA1yEevfN6q8zeFcQGbcUKoUjiIs3C14hcn/QuS+K2z4D90xHm1N
 cQ0oVYiQ42S7izz9bEq5haXD8fslFHZxkwc4wSH2p0DYTw1ZQNfvzg6/p7+iam59AJ19EIBtLM
 f1WqhNBicnkEehNKiAHBj0/k+5xI/4dU754f+/VyurqEd84/PV7SCig7GrSpAKc0BM4+yVcbq2
 SLo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 01:15:30 -0700
IronPort-SDR: 3dR2YDyjjjGDeZbQyYLymra7h8FkvvG6a9nsz4TSHXlivyxofImGdzcuQ+1hEbUblg7Jb6Xgom
 weHVWKU0+qnleBwZYOVlMBoGfPZMtwvkY/a890hXZew9Z5benyzTccY8XFRNWAbxMa+n/wkTr7
 Ezk/IGYECbMkzXtC83zCB/2qHj0dSXXZnwnEaUo6Cu/pmxtlW9/qM9Krq51v+xynzZIx7jA6MR
 +jAIpxco7kr1Uu2ihAt9G4PkAltVvlVVZAQY7507RhGH1vLWPUWWz+ix+FoM2JopqK3KB5GebV
 jYw=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Oct 2023 02:09:22 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc: core: Use mrq.sbc in close-ended ffu
Date:   Mon, 30 Oct 2023 11:09:06 +0200
Message-Id: <20231030090906.1897035-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode. So for the close-ended case, it
will be: cmd6->cmd23-cmd25-cmd6.

Some host controllers however, get confused when multi-block rw is sent
without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.

Instead of a quirk, or hooking the request function of the msm ops,
it would be better to fix the ioctl handling and make it use mrq.sbc
instead of issuing SET_BLOCK_COUNT separately.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 41 ++++++++++++++++++++++++++++++++++++++--
 include/linux/mmc/mmc.h  |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..6d94617ef206 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
 	struct mmc_ioc_cmd ic;
 	unsigned char *buf;
 	u64 buf_bytes;
+	unsigned int flags;
+#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
+#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
+
 	struct mmc_rpmb_data *rpmb;
 };
 
@@ -479,6 +483,9 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (!card || !md || !idata)
 		return -EINVAL;
 
+	if (idata->flags & MMC_BLK_IOC_DROP)
+		return 0;
+
 	/*
 	 * The RPMB accesses comes in from the character device, so we
 	 * need to target these explicitly. Else we just target the
@@ -532,14 +539,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			return err;
 	}
 
-	if (idata->rpmb) {
+	if (idata->rpmb || (idata->flags & MMC_BLK_IOC_SBC)) {
+		u32 sbc_arg = data.blocks;
+
 		sbc.opcode = MMC_SET_BLOCK_COUNT;
 		/*
 		 * We don't do any blockcount validation because the max size
 		 * may be increased by a future standard. We just copy the
 		 * 'Reliable Write' bit here.
 		 */
-		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		if (idata->rpmb)
+			sbc_arg |= (idata->ic.write_flag & BIT(31));
+
+		sbc.arg = sbc_arg;
 		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		mrq.sbc = &sbc;
 	}
@@ -1032,6 +1044,28 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 	md->reset_done &= ~type;
 }
 
+/* close-ended ffu */
+static void mmc_blk_check_ce_ffu(struct mmc_queue_req *mq_rq)
+{
+	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
+
+	if (mq_rq->ioc_count != 4)
+		return;
+
+	if (idata[0]->ic.opcode != MMC_SWITCH)
+		return;
+
+	if (MMC_EXTRACT_INDEX_FROM_ARG(idata[0]->ic.arg) !=
+			EXT_CSD_MODE_CONFIG)
+		return;
+
+	if (idata[1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
+	    idata[2]->ic.opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+		idata[1]->flags |= MMC_BLK_IOC_DROP;
+		idata[2]->flags |= MMC_BLK_IOC_SBC;
+	}
+}
+
 /*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
@@ -1059,6 +1093,9 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 			if (ret)
 				break;
 		}
+
+		mmc_blk_check_ce_ffu(mq_rq);
+
 		fallthrough;
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 6f7993803ee7..d4d10cabaa57 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -254,6 +254,7 @@ static inline bool mmc_ready_for_data(u32 status)
  */
 
 #define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
+#define EXT_CSD_MODE_CONFIG		30	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
-- 
2.42.0


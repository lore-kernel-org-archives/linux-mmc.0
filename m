Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD09C4332F
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Nov 2023 09:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjKGJzc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Nov 2023 04:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjKGJzQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2023 04:55:16 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EA126
        for <linux-mmc@vger.kernel.org>; Tue,  7 Nov 2023 01:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699350898; x=1730886898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RQG+uSZEZG15J4RORh2jr7FQxdpSHYItPpWCswgkD6s=;
  b=pz0ejKcrSo9lERTbe8zrTf9xW/cUqWBdUZsOSHeVNKM+wC0Ll4san/Uq
   yKrVPv/lGFXBLN7rT/l9E/n3SJNHxtUPxEkiJfHg4vY7vT+v/Xa0iPcUr
   Wy8hv30unm4M17h0CZohC2VtqL5eC+l/DInaHJy6Y+ff18riRyxPN6GOF
   Dap2ChxzyaxKuhAsSQ771meF6eWU8mLbEyWzuTgDQ0cliNbv232QSKPLT
   czgV7g8cTaAYJld2C+ThNiRARlrohkflpYwAg+O6CMzzTRCpQSA5ftcne
   nZ8usv6o2WLdB8HnoMxfji+YacHaYOz+/vZixcF4/xJvuYWH1AF9dLMeO
   Q==;
X-CSE-ConnectionGUID: kvdtKKtnSaKDG8XzF1fgtQ==
X-CSE-MsgGUID: UPiNnaocRImyXfAVov1nxg==
X-IronPort-AV: E=Sophos;i="6.03,283,1694707200"; 
   d="scan'208";a="1537627"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 17:54:56 +0800
IronPort-SDR: ee6vIhM0ulZ1ZKzCvu7SMkAPROXv4cLLWkzzlhZyw+w9NWRvnG7WgQT8b6dD0Rc+CVOumifUm+
 8d8qEn0RPGHgtyiPFjHcuW3oB++UkUT1L8jrgnUxOtdoOVAPR0aHN2zogF+OEQek+zVgu28Apo
 qBZEMoTTkVyT6EQtUXunYz4NR5c3DkJRVym0yTV2UzT0tsOUq4KiYCwMBo5jzGh0DwtkUbBhpf
 dYFWIWMmQlzxajDCS0nbM4mrSetgThdGodXwFam9/rkJGBn52rRhV7dLdvoS6IPNvp6YJxKRey
 dqk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 01:00:52 -0800
IronPort-SDR: AD3SKnFO35P6fwXYcea+/pa737kBMnJolA91VWc9Brn6Z5+JaTPvKoCx/oUeSw+Zd/MfAqK1St
 Fa18S99VlQu5pDWHnvDNzQWn1/8n1/B10fAdcT/BJV6gaQlUOq228+LNi+ldh+/KcQ1ZxqcQa8
 QaDJdYYQ1A+yDUPpig4QHLxK6FXGlH1y3Giov0ipuNTRJykpbjuWXOiF3G4U98vq0LS4rW4qAu
 qJyrH7znUgFM/mojdGzw4ZBZErG4xEaagWfmFcLhhT3qnjnDAq8bZ/jQw2MGUfwC0XfeOLnXXS
 GPk=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2023 01:54:54 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] mmc: core: Use mrq.sbc in close-ended ffu
Date:   Tue,  7 Nov 2023 11:54:45 +0200
Message-Id: <20231107095445.22477-1-avri.altman@wdc.com>
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

Changelog:
v1--v2:
	remove redundant reference of reliable write
---
 drivers/mmc/core/block.c | 34 +++++++++++++++++++++++++++++++++-
 include/linux/mmc/mmc.h  |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..e9fb93ee72fc 100644
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
@@ -532,7 +539,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			return err;
 	}
 
-	if (idata->rpmb) {
+	if (idata->rpmb || (idata->flags & MMC_BLK_IOC_SBC)) {
 		sbc.opcode = MMC_SET_BLOCK_COUNT;
 		/*
 		 * We don't do any blockcount validation because the max size
@@ -1032,6 +1039,28 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
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
@@ -1059,6 +1088,9 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
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


Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABDCDB46E
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Oct 2023 18:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379677AbjJLSmq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Oct 2023 14:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379655AbjJLSmp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2023 14:42:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA283
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2023 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697136164; x=1728672164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1NycfuipYB+ojhUIZct0o3mb2phHLlgSOxpw47xVAc=;
  b=oC5//gd0OAshpyn2Ym47bJ6PrD70Pi3jB1SjH2maMgBJDKomU7qqOMFM
   Kl9Fxa4M3s+9qP7cgh+6OynYIs8fbsoQ59YfdQkcAYGGkQMQ+TuaHt4vQ
   2TdvMMNaLriJz8MTTyyxnrbPBaFRGyQYHF0eTTUMxC2gakrXivnBOSxU6
   YWDvVCBsvPZa/yIESk5Ti+p5SxJBWJFMSvl+v0xvEUGWxTekVQs9heLjI
   OKKb2yPGopcTSitGvLhvDbPdOYXyxPzKo/fPwtxY/kTCiSwwG33pu1bm/
   DxAT1iXX+G4mdEKh9g+HSv9kZ+hU1+x8jPXtmsSkxo9XQOfmWdZDW5G23
   g==;
X-CSE-ConnectionGUID: YzEo81zUQLST/RQt8zZuqA==
X-CSE-MsgGUID: 0zhOcpfmTrq8FETtA7OC2g==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="246421366"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 02:42:44 +0800
IronPort-SDR: gjadJjYzw35XOL866XRgnhoJoI1sBr5GwdWRGD8gkJsBuK9Xxop+CfC33/Be6do7L06lHo8n8N
 LUOLG6zM/wt8RB5plUmmewsI8LK1j6Oh3ZQXS430nVu5oh1SGeUXPZOOxKmVVpkTe9HNQTI4g5
 H330JZcOE9IX5Pl4e5Xthx9FF+qgU3mERbUx1Td/oYR3XxEssp+1vZ6yXcdgcgYS4EzdEW1CkM
 r08pZtPaIq3prl2tDLep0mlZ4EHZuaGSrRAbi/6VRyJ1fWgGnpdcNzizSH4r9ajB1XWAjZcFIh
 YeY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 10:54:51 -0700
IronPort-SDR: onN01rj1b5s6LJP3ch6KxpcORb8BMvNYJQI3kn81akWVaDGi1drDx8uVEctmOoeFQYka3jHAqq
 +Xgd9890y6VxDwN8IWKp2jld0aj77qQ4MMH9HQvrd0nmXCS5XVrErUcdb2myClUbf7KdOwJbJ3
 z0mnfo0jtkZla1eOG7NxgE1zOIj63YbmKACnLMAC2pZ6x6DnJXilaHndHXHCdnE9kFZ+1g6YIa
 CcL7Xx/Ttpt1KVnsI5VLtHTX+/pv267XwYRG3mzcRXqh5BZO2GEZRuK8CxesIP3LYs1x8SPqVb
 Hm8=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Oct 2023 11:42:42 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/3] mmc: core: Mark close-ended ffu in progress
Date:   Thu, 12 Oct 2023 21:40:40 +0300
Message-Id: <20231012184041.1837455-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012184041.1837455-1-avri.altman@wdc.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SDHCI_QUIRK2_FFU_ACMD12 quirk was invented to prevent from those
bogus sdhci to use auto-cmd12 after cmd25 in a close-ended ffu process.
Capture the applicable mrq and mark it so it won't use auto-cmd12 post
that cmd25.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 25 +++++++++++++++++++++++++
 include/linux/mmc/mmc.h  |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..d92e7322c6da 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -114,6 +114,8 @@ struct mmc_blk_data {
 	unsigned int	flags;
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
+#define MMC_BLK_FFU	(1 << 2)	/* FFU in progress */
+#define MMC_BLK_CE	(1 << 3)	/* close-ended FFU in progress */
 
 	struct kref	kref;
 	unsigned int	read_only;
@@ -548,6 +550,29 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	    (cmd.opcode == MMC_SWITCH))
 		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_MODE_CONFIG) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		if (value == 1) {
+			md->flags |= MMC_BLK_FFU;
+		} else if (value == 0) {
+			/* switch back to normal mode is always happening */
+			md->flags &= ~MMC_BLK_FFU;
+			md->flags &= ~MMC_BLK_CE;
+		}
+	}
+
+	if ((md->flags & MMC_BLK_FFU) && cmd.opcode == MMC_SET_BLOCK_COUNT) {
+		md->flags &= ~MMC_BLK_FFU;
+		md->flags |= MMC_BLK_CE;
+	}
+
+	if ((md->flags & MMC_BLK_CE) && mmc_op_multi(cmd.opcode)) {
+		mrq.ffu = true;
+		md->flags &= ~MMC_BLK_CE;
+	}
+
 	/* If it's an R1B response we need some more preparations. */
 	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
 	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
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


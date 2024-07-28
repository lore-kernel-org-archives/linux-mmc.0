Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E70BA20
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154486; cv=none; b=XOPRr9ruhIwNO80TaI1wK7yBCgOSPBYwX9q5RSBXuZ/o7zfM+IOMMtY05tJTT4hSBnjxvgMhs8oApISFxI5EnJpvKayVHZ+a0XgMW44aLZwAvc+Zkfs1lMrhro7fkILMjiOzzXT9ybcQ4aVVgiZqlDcfwOAxXypx3m7JG9a7fUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154486; c=relaxed/simple;
	bh=S8xVwTDSTeCW0c+Tn4lgqG+XzOS+QoWYH54V9w9WVPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O8dPeFl6Fsd3F6Z2WaebDB6MJCsdBp3no8KNj606/oHVZX4KfBHVOdjdo0KNyVogtJPZUTLuRgknLD/zQ3CUHeIDIqLj44+thVN5Vh9BSwTvsTXp/PiP361IB1FMuzZ3IKh2EgbW98rLNA1AiGPxhq0OZ1XrDAEjF6uq1lzZ0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C/g3sVbn; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C/g3sVbn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154484; x=1753690484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S8xVwTDSTeCW0c+Tn4lgqG+XzOS+QoWYH54V9w9WVPE=;
  b=C/g3sVbnB83TXpr3GRgMZY21iIpBwXHwUBUrDFu+87eVPr+ErIDzF+V+
   11P1yG378s16+fgjgk9Hh/VIZ25JKYihcQDLFi5quP4a983nswZ9JFGHQ
   OGSm6ayiH/7iYfSyzD31k1Bay+0TcCDlrf8c8MysYRwQnK72thbYQGwGE
   vHVuOf8tgpG590uJoyin5XKm0iDdT/YuJEpTfk8H5/BumSgOU3qh20alM
   NW1AnTVNW8/GayyIE2THSsSJATCb50mKq5koYr8n9j1X9fwBgM/Urlo8d
   ASJ+//RR6i7vmXBkMnS18HS3Sbbp6+nYO71l67wBlOkznUk8GHJefrQk6
   w==;
X-CSE-ConnectionGUID: 2/Ce7q+cRWKL+gSJYItd6w==
X-CSE-MsgGUID: E63lat4ETfizHo5PsJudfw==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22909116"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:35 +0800
IronPort-SDR: 66a5f116_DYq9VzEpchK5O4hMTib0pc2o9b9LqiSMzn2tD2EIW2sKbO0
 Q3VhXE164iJB6nfzDKF4q+cajmNpJQ3bgauBD/g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:50 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:34 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 04/10] mmc: core: Add open-ended Ext memory addressing
Date: Sun, 28 Jul 2024 11:11:48 +0300
Message-Id: <20240728081154.1782120-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240728081154.1782120-1-avri.altman@wdc.com>
References: <20240728081154.1782120-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For open-ended read/write - just send CMD22 before issuing the command.
While at it, make sure that the rw command arg is properly casting the
lower 32 bits, as it can be larger now.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c  | 8 +++++++-
 drivers/mmc/core/sd_ops.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 367509b5b646..eb41d2803c9b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -180,6 +180,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 static int mmc_spi_err_check(struct mmc_card *card);
 static int mmc_blk_busy_cb(void *cb_data, bool *busy);
+static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -1664,7 +1665,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 
 	brq->mrq.cmd = &brq->cmd;
 
-	brq->cmd.arg = blk_rq_pos(req);
+	brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
 	if (!mmc_card_blockaddr(card))
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
@@ -1712,6 +1713,11 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
+	} else if (mmc_card_is_sduc(card->host)) {
+		u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
+
+		mmc_blk_wait_for_idle(mq, card->host);
+		mmc_send_ext_addr(card->host, ext_addr);
 	}
 }
 
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 0db081f2355c..1f80941b6779 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -9,6 +9,9 @@
 #define _MMC_SD_OPS_H
 
 #include <linux/types.h>
+#include <linux/bitfield.h>
+
+#define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
 
 struct mmc_card;
 struct mmc_host;
-- 
2.25.1


Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA75198E90
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010701; cv=none; b=gu035J1tU1z5b4juHbzstC8XLgJ6MJnBXp1o4u7b1LPW5o2zvAOXGIA344Da0HQeZQWG8162cNPch/DwDGWRxhHv5nfQC6zPzsG2CNtGj2bh7R5b5atzAvtxWAAEt7n/bOHaBjFQJ3VV8oc/K5eboR24dtB++AfdGIuAlT8GkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010701; c=relaxed/simple;
	bh=oG+rXt7cEqPZX9VNLCZ/g6/9uNIBC2w1APBThzfqA4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8s6nbUTe8OXQ9ER3jf69ZrEmcG7RgCKZjg4hkZ4t2ntEQt+By9rbQDghW200Yl5v86lemjt3KAYaBLITIUirnD8+iUP1520PxByDB7E7STTo2OqTYge+VTOW/OKFYrrL6pvAXH/xRjMAbJfc26o2WEFzus2tKOrpaBFXLb61CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TsCX61y0; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TsCX61y0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010700; x=1754546700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oG+rXt7cEqPZX9VNLCZ/g6/9uNIBC2w1APBThzfqA4o=;
  b=TsCX61y0ORFe7yh8/kAxtYQX/9SjYuSu9MPsgL+0yjQUpg34vV3GCfw/
   I2F3rW9xt07xnf+qdHjb6jpvvzjAJ1jRx4eiF95nwskf9YubqHCR/gfTI
   OyEqJ/zNpnnuEgLl0S06DdS2Dod42xCmN/UIHK65BSTORHldVGvpyZCht
   XEER4cbSi6+IjqzoaMBVWDmCdSomIPxvk/y/lV9GxJ72mXbj+V+RfPdQX
   Wun6cnqOkqj9hbI+9Uw/gQ7Nqxnn7l7Qn+jUpfznmAKQhlJ/rU2f/YJLL
   inThh2GOQuHI+Lzdh5u19jrFwDyWLPsNluUipX53UOi0gpyiojTwK2qqE
   A==;
X-CSE-ConnectionGUID: AoBsIqHWTIKThOs+YBgb8g==
X-CSE-MsgGUID: b7GcAWbWQpiHSimoLR+HdQ==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039316"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:05:00 +0800
IronPort-SDR: 66b30091_vl6OnTE1aUyKb0FJzS04iKloNyQAol6mzxPEGBbz8bzFZt2
 eYYQvyfOCtb1mXUbwFJ7T7RBxLwCW5/7ZK8MB+w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:22 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:04:59 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 06/10] mmc: core: Add close-ended Ext memory addressing
Date: Wed,  7 Aug 2024 09:03:05 +0300
Message-Id: <20240807060309.2403023-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807060309.2403023-1-avri.altman@wdc.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a multi-block data transfer, CMD23 shall precede CMD22. Prepare CMD22
in advance as an additional extension of the mrq, to be handle by the
host once CMD23 is done.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c |  7 +++++++
 drivers/mmc/core/core.c  | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 392621232ad8..abf1e8a124a5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1713,6 +1713,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
+
+		if (mmc_card_is_sduc(card->host)) {
+			brq->ext.opcode = SD_ADDR_EXT;
+			brq->ext.arg = (u32)((blk_rq_pos(req) >> 32) & 0x3F);
+			brq->ext.flags = MMC_RSP_R1 | MMC_CMD_AC;
+			brq->mrq.ext = &brq->ext;
+		}
 	} else if (mmc_card_is_sduc(card->host)) {
 		mmc_blk_wait_for_idle(mq, card->host);
 		mmc_send_ext_addr(card->host, blk_rq_pos(req));
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..754e628b061b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -184,6 +184,14 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 				mrq->sbc->resp[2], mrq->sbc->resp[3]);
 		}
 
+		if (mrq->ext) {
+			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
+				mmc_hostname(host), mrq->ext->opcode,
+				mrq->ext->error,
+				mrq->ext->resp[0], mrq->ext->resp[1],
+				mrq->ext->resp[2], mrq->ext->resp[3]);
+		}
+
 		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
 			mmc_hostname(host), cmd->opcode, err,
 			cmd->resp[0], cmd->resp[1],
@@ -270,6 +278,12 @@ static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq,
 			 mrq->sbc->arg, mrq->sbc->flags);
 	}
 
+	if (mrq->ext) {
+		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
+			 mmc_hostname(host), mrq->ext->opcode,
+			 mrq->ext->arg, mrq->ext->flags);
+	}
+
 	if (mrq->cmd) {
 		pr_debug("%s: starting %sCMD%u arg %08x flags %08x\n",
 			 mmc_hostname(host), cqe ? "CQE direct " : "",
@@ -309,6 +323,10 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 		mrq->sbc->error = 0;
 		mrq->sbc->mrq = mrq;
 	}
+	if (mrq->ext) {
+		mrq->ext->error = 0;
+		mrq->ext->mrq = mrq;
+	}
 	if (mrq->data) {
 		if (mrq->data->blksz > host->max_blk_size ||
 		    mrq->data->blocks > host->max_blk_count ||
-- 
2.25.1


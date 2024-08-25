Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2417C64
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571813; cv=none; b=F8lGB5C83aP7j9//p1dkcMiXd3MDZPv2lIN62jQigbGxUAEJVvxdtewawcM7EG3uaL83/xlo/Z4ZeWJxdHhkpxEUG0DIB7gdrahZhFk6sow/J1ZjeqnCpZss86LRDcsxtYI42V5OpVKBkzBvr4QZVOA+e3+KtaVTyDNiDWe09V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571813; c=relaxed/simple;
	bh=tLvWTxXXb5aqpxy15nYWZnF6mArThXUomPGalcDLJhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tLEuMpG+Pnek9KVr2OycpSDiWYzMCdfFxdd2glUXP4xfqjCQJsHxXGq4PCT2rhihPShlPcGPuMDJJHOL5K24yVUCJhSdejonFMEU9gzGw+TKTmaNWv111dfDbBQ71qQNLhnIkS/g7u+58xE2DzSyVn7y3t01kvqgkoXpnj8T1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d0j3C61j; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d0j3C61j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571812; x=1756107812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLvWTxXXb5aqpxy15nYWZnF6mArThXUomPGalcDLJhM=;
  b=d0j3C61jzLoJ1ht8syt3DeUW4h6NS+csviw4hPN9ckpLXuexRgt+oSwX
   5CPmjegITrn2sE506LariklRZVTvxGAMuOIIoXYNWxHKtlxLImgvIIFL1
   Xk8621PPbGU32JWngTkgRYZBjbU09Kqliw6AS6ZMNVgs0OoDEIkD/UtBe
   eeWUfQnnDelF7YwOZFAN9veeFUv5sUHUH+Onf6KvocWlQHG7l6XsyaHs3
   T7xnPpElBCBg/rE0GGnjVhlYXlHIaFn6tQUOuZTNPdHMDngRWQMOlF7nS
   6nQTb7EpeUu8FQXP9c7rdAAv/RNRfUM5mt8r1rNFTH0sWiREjmiP13gcG
   w==;
X-CSE-ConnectionGUID: TWyHE0giQ82DOWWD60rOAQ==
X-CSE-MsgGUID: 0sumpg9sR8yCIjzXIY7mGw==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100425"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:31 +0800
IronPort-SDR: 66cad3e7_+jLgpkhuKT9cbSLRkYqCZxhLHOxD359upoQueRyzz4wYjtY
 b4DlXBh4YgA5JY+6fj7dwoe9GjvQgtQCnhlIfUA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:11 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:30 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 4/9] mmc: core: Add close-ended Ext memory addressing
Date: Sun, 25 Aug 2024 10:41:36 +0300
Message-Id: <20240825074141.3171549-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
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

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c |  7 +++++++
 drivers/mmc/core/core.c  | 18 ++++++++++++++++++
 drivers/mmc/core/queue.h |  1 +
 include/linux/mmc/core.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8816b3f0a312..7020a568fb79 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1713,6 +1713,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
+
+		if (mmc_card_ult_capacity(card)) {
+			brq->ext.opcode = SD_ADDR_EXT;
+			brq->ext.arg = (u32)((blk_rq_pos(req) >> 32) & 0x3F);
+			brq->ext.flags = MMC_RSP_R1 | MMC_CMD_AC;
+			brq->mrq.ext = &brq->ext;
+		}
 	} else if (mmc_card_ult_capacity(card)) {
 		mmc_blk_wait_for_idle(mq, card->host);
 		mmc_send_ext_addr(card->host, blk_rq_pos(req));
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..4808e42d7855 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -184,6 +184,14 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 				mrq->sbc->resp[2], mrq->sbc->resp[3]);
 		}
 
+		if (mrq->ext) {
+			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
+				 mmc_hostname(host), mrq->ext->opcode,
+				 mrq->ext->error,
+				 mrq->ext->resp[0], mrq->ext->resp[1],
+				 mrq->ext->resp[2], mrq->ext->resp[3]);
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
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 1498840a4ea0..7e191d7f0461 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -40,6 +40,7 @@ struct mmc_blk_ioc_data;
 struct mmc_blk_request {
 	struct mmc_request	mrq;
 	struct mmc_command	sbc;
+	struct mmc_command	ext;
 	struct mmc_command	cmd;
 	struct mmc_command	stop;
 	struct mmc_data		data;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2c7928a50907..5560e70cb8d4 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -142,6 +142,7 @@ struct mmc_data {
 struct mmc_host;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
+	struct mmc_command	*ext;		/* SD_ADDR_EXT for SDUC */
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
 	struct mmc_command	*stop;
-- 
2.25.1


Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D33C13B
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154488; cv=none; b=ThYuiAYz5MhT+wxVetcEektB6gfIt8rIX1z0+dAHHkiFGVIGoZxfipl/usLRKgmQhic/i8DVpEWHjVr7CTXMAubXUZjB3JNTl32gp1IAZqaf/BJRsKpWIifT8RmRsZJBm14Vi4kzopJt+bD1r+6LDEzLVcXSXPm0thAX+Hf3feQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154488; c=relaxed/simple;
	bh=8vklSCxbwQmBqkwyEQxE9z9GSmPMa5EQCOmr4nxL940=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDzbiC4leLTWjMns/J43cSTao0S1Wa+E12Mp1RaCh5RRqTqUkX1H5DRyA4uwbQNRXqWujftY64Rgh6psgr66amLupo8dme44sGatoDEcFVHzdbvGYwJ0avs8ig3ul9TaJF7Ow/ouFPqmCx21vnWRciKTB7a1jNDV0epXiPYaAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lHDN45SM; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lHDN45SM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154486; x=1753690486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vklSCxbwQmBqkwyEQxE9z9GSmPMa5EQCOmr4nxL940=;
  b=lHDN45SMZ7svN/5VuqVxHf4iYwG1QrBAerOf0tKoOAYVEmZcAtI09ac6
   OfQaezzEX+e8ftkOV6kfpixR9zFy44vxYXi3nY01AePLx+WVSNiivn5vD
   trFCFEuHpWYSSDuUbCdQp70T/5c1ACmRKebORanARASN0r7IvKDHzsbLQ
   5InR0P5lskINMFlrDotHwwWfPYcF9aLVGs5VTUpC+Y2bBO8JUL4HIv4f1
   DZy9Oy1sCjKSCR7esLFx27J3F0On8BWTN0r+NeQi0avr2f3Caiwq1nMWb
   7hCNpQeVGkMnYj/l7Iel7zrCdcCzQb7sRclwqupGynHV0jrmeZNBDubnY
   g==;
X-CSE-ConnectionGUID: aDzcQy0wRbGVCsSBndx1JA==
X-CSE-MsgGUID: iezgi68TQaymxu3XxeBczw==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="22909124"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:43 +0800
IronPort-SDR: 66a5f11d_ootoeREntYTuuuR+KmdUSvTBi07m9lbfK9HxpAUdLDJuN/T
 2CGaYuPtLwRBujRuZiL7eOG/hooJmSdKtu2CS/A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:58 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:42 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 06/10] mmc: core: Add close-ended Ext memory addressing
Date: Sun, 28 Jul 2024 11:11:50 +0300
Message-Id: <20240728081154.1782120-7-avri.altman@wdc.com>
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

In a multi-block data transfer, CMD23 shall precede CMD22. Prepare CMD22
in advance as an additional extension of the mrq, to be handle by the
host once CMD23 is done.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c |  7 +++++++
 drivers/mmc/core/core.c  | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index eb41d2803c9b..fd3ee4d5db31 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1713,6 +1713,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
+
+		if (mmc_card_is_sduc(card->host)) {
+			brq->ext.opcode = SD_ADDR_EXT;
+			brq->ext.arg = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
+			brq->ext.flags = MMC_RSP_R1 | MMC_CMD_AC;
+			brq->mrq.ext = &brq->ext;
+		}
 	} else if (mmc_card_is_sduc(card->host)) {
 		u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
 
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


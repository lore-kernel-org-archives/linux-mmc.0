Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A026AC6
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620703; cv=none; b=APTPVK/Vk1rIrDgLk0OluGsewrnAKa4pyXCktjXMk7Sq0YluEUavB8PZZqFSE0tMnR8w7UztSzsW+EFM0Hrvw6HZxTKNc8wA85XpO2QBJKtPdnIVY0a+HPI7RzW0dVQLxLbTZXHE9IfW/RhhRfV0+M61NuVnVh4oXvUyF2EcSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620703; c=relaxed/simple;
	bh=sh1fnV1d8I6XgM1V2sCyj9vcmdLlTfgbultXtliXbgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/bLHc11Zgw6xAT2mhyvel3SdUJxA3yKf35onXK3CS3T92xicDk47OxKTRy9v0fpR4XYdKAKZhX6xiAGAcy6419HcM2V/q13+TOOXOgpgMhSOAv6HEM7821Fajn37m6BY6Cl2FQLDOWUCB3UKayxYI6cuQDfQDQncNdzlgmo+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RuuzH/Pz; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RuuzH/Pz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620701; x=1755156701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sh1fnV1d8I6XgM1V2sCyj9vcmdLlTfgbultXtliXbgk=;
  b=RuuzH/Pzp0n2Gz0uL6dY3ftYnCru/xEvjjusEj6o22t/oBDJ1QNqfMgJ
   K9G8xr6nEH2yILKIyRtMNKjbPuez9SexkR5fBSbPZzGeW78fibuQOuQ5W
   0zQ/oT57aQ0765Jqcnarkoa1kReBsHhNdROO/GDyN4E/n8BdIaQP3XNnn
   7tMCeUllXpWoKq29B7lchg763LyuP8IRxKMvcGaPrLJu1LN6qwTd3qh7U
   iUvesFMImKG0UcN1/CQrJ50iALMsEzd6225Y6+0Mc8CeSR7bjHFKTcpod
   xlaZlUiJU+YbsuFsd7nILujfZ79d8HASBIxGwgLNr4YkOhazwjm0BpmQG
   Q==;
X-CSE-ConnectionGUID: 7XSiro7OSbegrVUCXJshxg==
X-CSE-MsgGUID: 9ELCnu2XSe6d9vmmN9yA2A==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24957224"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:41 +0800
IronPort-SDR: 66bc4f5a_0sWEogkdbelUEFEZk9sNStT/sisjxpqq4MK4OuaLGPPgKK2
 5E5U2n23y0NAiqYNATLanP1wNVm7iJyWJBB/ViA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:31:55 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:40 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 06/10] mmc: core: Add close-ended Ext memory addressing
Date: Wed, 14 Aug 2024 10:29:30 +0300
Message-Id: <20240814072934.2559911-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
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
 2 files changed, 25 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1129f4e1a268..0b6ca771b458 100644
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


Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54DD1EB21;
	Tue, 26 Nov 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625458; cv=none; b=JfjmlKVrpZ+iSQeoHGKLQgRnK9+uBH5R9AU64ce03tQNr17I2Ur3UV0eyMGv+Ftv72WXiECWPfFe1CSb3f0PIdShx7qi/RCwTQep7dYYlO+BADA15oRHiQgMi/uhwMIOdIWMXkcFTA0RpQmEaA6R9sNSsJf4EIHKctUZW8IAX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625458; c=relaxed/simple;
	bh=G/6qWH7b2tPaG2zuB5OYhDvl691nv0bIWigOk15PhbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxiC7/KUSMJpWs+S03NHiUKZ4QKrhOjuyv4H3mJw1pnU++8s1S0jJ7oc/T8TfPk7q3ULhz/Ho4spiollwo2UhbM8/yy0xLEvvhonmv3/vU5q5LnivZUcE/XbgksZFDfk32ACGWNrQGvUm8J6vNL412kvnJc1pNGGspqvOabWGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZxKtLh1k; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZxKtLh1k"
X-UUID: 0fd5c964abf511ef99858b75a2457dd9-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5qp363pOkk5uIWe6ckwZTUijsChIwo2BFK3HWrcaSe4=;
	b=ZxKtLh1kDhYBMubMVvH4OCodK1GDPnrB7Yd99uX/eb+YTqvONVVFhlYAiH+ONEtoDm1Cpk/40nos7+0wlVgHKw2hSRQtkn84kGOnda9KAjN8zzEmkn3++o/Pt2cMqQkLOvcIGQSH6T2NWjzFXoA7FVHmV0YzglFcGughShXQYGo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:c5d39692-c1cb-493e-8289-2bc2d4d52a4b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:ae274ee0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0fd5c964abf511ef99858b75a2457dd9-20241126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1765199979; Tue, 26 Nov 2024 20:50:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 20:50:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 20:50:47 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <avri.altman@wdc.com>, <adrian.hunter@intel.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 1/2] mmc: core: Introduce the MMC_RSP_R1B_NO_CRC response
Date: Tue, 26 Nov 2024 20:48:22 +0800
Message-ID: <20241126125041.16071-2-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241126125041.16071-1-andy-ld.lu@mediatek.com>
References: <20241126125041.16071-1-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The R1B response type with ignoring CRC is used in the mmc_cqe_recovery(),
introduce the MMC_RSP_R1B_NO_CRC response type to simplify the code.

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
This patch dependents on "mmc: core: Drop the MMC_RSP_R1_NO_CRC response".

https://patchwork.kernel.org/patch/13884886

---
 drivers/mmc/core/core.c  | 6 ++----
 include/linux/mmc/core.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a499f3c59de5..4603224bafb9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -557,8 +557,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_STOP_TRANSMISSION;
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
-	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
+	cmd.flags        = MMC_RSP_R1B_NO_CRC | MMC_CMD_AC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
@@ -567,8 +566,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
-	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
+	cmd.flags        = MMC_RSP_R1B_NO_CRC | MMC_CMD_AC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index e13856ab6ad0..4aeab326ed9d 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -64,6 +64,8 @@ struct mmc_command {
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 
+#define MMC_RSP_R1B_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE|MMC_RSP_BUSY)
+
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /*
-- 
2.46.0


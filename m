Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CF7E110;
	Sat, 23 Nov 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732345839; cv=none; b=esGjYLpayGm6Tnj4PCKuhL4JYUTMuI5RnKXr1nJCdntidjiHPKTE0Oc/UxDcYm889DvLqMmcT/rIn4IZUKqWPkvTMfCX6DVq7RhsCIBP28bO46Yrp18DmsebkZ1rfyRLxZdS+Uh8tQXGLrMBCFBv8VxbbYa2LASpVuJFAMdehDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732345839; c=relaxed/simple;
	bh=tcNGkFjzsdvzIwzgHfLMDwMCVCUfylTueMX/Jp294n4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7/jmJiIYxWBMys6Tu5OYE/4LGtZ2YxHvI7lqqjIYGf8zogYcSmgUKdXRKa4CTT/H+MybwQmVLnyRbjV0WcEgzQo8J3aVM2tFB99Y+ePvoIZpJdWxMbAD81EZ9FeHMeDhdG3Rf+ScZ2RPxTUJk+s7Ho/yfy/y7Ig7T/pOiOrrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Rol3+5rX; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rol3+5rX"
X-UUID: 07c34cb6a96a11efbd192953cf12861f-20241123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=of66qC7qugkiFYiLOj7X/DHcAAfucvWSwJFAEVz9WNw=;
	b=Rol3+5rXBZ3kQSOzhKw9IQbt7Z5T129RQdbhWeZDI6lCDUoW4hDcTjApF1d5baqbz9+LllkFIJa5TTiVBZK1wc0qnyIzlRE8fFe0asXf8PSw1NX6gzO7hs76RYZyMuZxYBck8yFcyKWYwMIqzS5YionQb6qeUUpmLzJ25SR62c0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:06d93a38-28e2-49a9-a1ce-af553d4d8d5b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:464815b,CLOUDID:7c63aca0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 07c34cb6a96a11efbd192953cf12861f-20241123
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2066787923; Sat, 23 Nov 2024 15:10:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 23 Nov 2024 15:10:30 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 23 Nov 2024 15:10:30 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH] mmc: mtk-sd: Add support for ignoring cmd response CRC
Date: Sat, 23 Nov 2024 15:09:05 +0800
Message-ID: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.109900-8.000000
X-TMASE-MatchedRID: Q3t+gDEGl+H7W7/9wscjdRuZoNKc6pl+ju+GX08gELBKda7Cp9A+Rm7T
	iYn7+ZHjXers26Xj0FAkAzbREWz9m28aeniRmKw1H5YQyOg71ZZMkOX0UoduuQqiCYa6w8tv8rK
	/0wUyv6DwLx34aly34aojHM/WIuK90rly6TajiUnuykw7cfAoIHE01tKb2rARmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1HN3C0owwdL7VUQqweXw1HiKsnV6jwqhAS8V3+ghPHP094nqACUbvaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.109900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D2E444064FAB0EB55E14C3A892E9AA8715E06345789FCC8F6A380B8EA7050E592000:8

The current process flow does not handle MMC requests that are indicated
to ignore the command response CRC. For instance, cmd12 and cmd48 from
mmc_cqe_recovery() are marked to ignore CRC, but they are not matched to
the appropriate response type in msdc_cmd_find_resp(). As a result, they
are defaulted to 'MMC_RSP_NONE', which means no response is expected.

This commit adds a new flag 'MMC_RSP_R1B_NO_CRC' to work alongside the
existing 'MMC_RSP_R1_NO_CRC' for the following process flow. It fixes the
response type setting in msdc_cmd_find_resp() and adds the logic to ignore
CRC in msdc_cmd_done().

Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 11 +++++++++--
 include/linux/mmc/core.h  |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..5d669f985a82 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1097,11 +1097,13 @@ static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
 	u32 resp;
 
 	switch (mmc_resp_type(cmd)) {
-		/* Actually, R1, R5, R6, R7 are the same */
+	/* Actually, R1, R5, R6, R7 are the same */
 	case MMC_RSP_R1:
+	case MMC_RSP_R1_NO_CRC:
 		resp = 0x1;
 		break;
 	case MMC_RSP_R1B:
+	case MMC_RSP_R1B_NO_CRC:
 		resp = 0x7;
 		break;
 	case MMC_RSP_R2:
@@ -1305,6 +1307,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 {
 	bool done = false;
 	bool sbc_error;
+	bool ignore_crc = false;
 	unsigned long flags;
 	u32 *rsp;
 
@@ -1329,6 +1332,10 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 		return true;
 	rsp = cmd->resp;
 
+	if (mmc_resp_type(cmd) == MMC_RSP_R1_NO_CRC ||
+	    mmc_resp_type(cmd) == MMC_RSP_R1B_NO_CRC)
+		ignore_crc = true;
+
 	sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
@@ -1351,7 +1358,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 			 * CRC error.
 			 */
 			msdc_reset_hw(host);
-		if (events & MSDC_INT_RSPCRCERR) {
+		if (events & MSDC_INT_RSPCRCERR && !ignore_crc) {
 			cmd->error = -EILSEQ;
 			host->error |= REQ_CMD_EIO;
 		} else if (events & MSDC_INT_CMDTMO) {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 56972bd78462..076e1c71a07e 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -66,6 +66,7 @@ struct mmc_command {
 
 /* Can be used by core to poll after switch to MMC HS mode */
 #define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)
+#define MMC_RSP_R1B_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
-- 
2.34.1


Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28311537D4;
	Thu, 23 Jan 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624418; cv=none; b=nQOo0zF2pk8IHXzvLxJ6ITOnyYOsUanvvUf4hK2S/wXGJlqrmuln66se4DqP4n3+BpFx/GD+L+1APzxjj4eGpRvIQSUtJic1GHqfM1JKpkYTuVvKmy/4sPgKV+eYHaHrpglP1I7+vFiKtVud7i6/B53aj/xk/S7iDezPoMvcS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624418; c=relaxed/simple;
	bh=+FYPjK09aJ2mU1gRleJTy2vD/Q+rRNCpOLzIxDE1rR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZYB+ecc5XgInUmHCP1HWT0MCtn20HMnr0T8brnwVXZknbAtRtlEOac+4sNvCynzJAr8LYVOxsSz+SfelStiAJFri8nb4DJqyjPGGQ9BuryDZaFkR8MZpIOL5HxEw9AhI/WCz4HrWIe3dJk481W4yPUzX+ED29Vmqwrgoa+YvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q+1o6WiQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q+1o6WiQ"
X-UUID: 2bcc92d4d96c11ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JWWAzItImoWGXYtJ3eWXsoeT9tJE5bcK6MiBbovl0yo=;
	b=Q+1o6WiQRMWjQrGuftnUxvTbZDpBV40O64KrHLIq2HOy/tDSP1CLGdn6ZcF9RIcK8k32vY+oemxiJzHey3dz4/5dZaG4gJM9oGeFh5NhqKYj5YymUJzrOrPk4LHse6m1BiTvLcg6yMJE5RLugu+ZRItS0yaRnXvuURdI/Z+8v8I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:3dfbe51e-e51a-4409-808c-11ad9d894d5b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:f781affe-c190-4cfe-938d-595d7f10e0dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2bcc92d4d96c11ef99858b75a2457dd9-20250123
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1499405675; Thu, 23 Jan 2025 17:26:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 17:26:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 17:26:46 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2] mmc: mtk-sd: Fix register settings for hs400(es) mode
Date: Thu, 23 Jan 2025 17:26:01 +0800
Message-ID: <20250123092644.7359-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For hs400(es) mode, the 'hs400-ds-delay' is typically configured in the
dts. However, some projects may only define 'mediatek,hs400-ds-dly3',
which can lead to initialization failures in hs400es mode. CMD13 reported
response crc error in the mmc_switch_status() just after switching to
hs400es mode.

[    1.914038][   T82] mmc0: mmc_select_hs400es failed, error -84
[    1.914954][   T82] mmc0: error -84 whilst initialising MMC card

Currently, the hs400_ds_dly3 value is set within the tuning function. This
means that the PAD_DS_DLY3 field is not configured before tuning process,
which is the reason for the above-mentioned CMD13 response crc error.

Move the PAD_DS_DLY3 field configuration into msdc_prepare_hs400_tuning(),
and add a value check of hs400_ds_delay to prevent overwriting by zero when
the 'hs400-ds-delay' is not set in the dts. In addition, since hs400(es)
only tune the PAD_DS_DLY1, the PAD_DS_DLY2_SEL bit should be cleared to
bypass it.

Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
Changes in v2:
- Change commit title from 'optimize' to 'Fix'
- Add a Fixes tag
- Change spaces back to tabs

---
 drivers/mmc/host/mtk-sd.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4b6e91372526..345ea91629e0 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -273,6 +273,7 @@
 #define MSDC_PAD_TUNE_CMD2_SEL	  BIT(21)   /* RW */
 
 #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
+#define PAD_DS_TUNE_DLY2_SEL      BIT(1)	  /* RW */
 #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  GENMASK(11, 7)  /* RW */
 #define PAD_DS_TUNE_DLY3	  GENMASK(16, 12) /* RW */
@@ -318,6 +319,7 @@
 
 /* EMMC50_PAD_DS_TUNE mask */
 #define PAD_DS_DLY_SEL		BIT(16)	/* RW */
+#define PAD_DS_DLY2_SEL		BIT(15)	/* RW */
 #define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
 #define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
 
@@ -2504,13 +2506,23 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+
 	host->hs400_mode = true;
 
-	if (host->top_base)
-		writel(host->hs400_ds_delay,
-		       host->top_base + EMMC50_PAD_DS_TUNE);
-	else
-		writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	if (host->top_base) {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay,
+			       host->top_base + EMMC50_PAD_DS_TUNE);
+	} else {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->base + PAD_DS_TUNE,
+				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	}
 	/* hs400 mode must set it to 0 */
 	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
 	/* to improve read performance, set outstanding to 2 */
@@ -2530,14 +2542,11 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
 	if (host->top_base) {
 		sdr_set_bits(host->top_base + EMMC50_PAD_DS_TUNE,
 			     PAD_DS_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
-				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->top_base + EMMC50_PAD_DS_TUNE,
+			     PAD_DS_DLY2_SEL);
 	} else {
 		sdr_set_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->base + PAD_DS_TUNE,
-				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY2_SEL);
 	}
 
 	host->hs400_tuning = true;
-- 
2.46.0


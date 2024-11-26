Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1731CDFBE;
	Tue, 26 Nov 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625460; cv=none; b=m7scbi3PkU6GKHHNMvZRAtDuBGLXE1QAXX9fUhw134Ejm++HC7Hl8qJRfyu+ggikPMP8U1CDckVmbOIe/oDsE47nzhPUm4zHxC7UabXpHG4RvZb0tTKWqRfSn2CW2uUb7SP6oE/1NZE2KQBpvQWMTLoqG8JZikKAnIaVCFB0pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625460; c=relaxed/simple;
	bh=ArR5+21AA93ZEfayM9mvETGHY7Aj5xShHAv/zV45HSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVjbZxEPmHvxXG8MRcz3pdLy+zGZ387IO0TRFkUJzTRTaOzFULawaxJoCMjIy62+s4coTPSDdFXCzKo2Kcf8mDKPdiuF0AzkE8xkqS9/WbH6EoXwF/8shGFEV9iIpjZ2pUtxiL55HIcCV4+ng2UFZAqF8Sv3noEjBFtmf3A51us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TTPpw5YI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TTPpw5YI"
X-UUID: 112eb9ceabf511efbd192953cf12861f-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ddGXrlsNVofZVqtyw9ZyO42fEPecY4EOHW94yOtt3ck=;
	b=TTPpw5YIT1xQDTVz3JmLjcgvxakL1CmHl4WC4rUfMOA1IqSq7GRchP+yJsXu+LNR/hrs7lo61E9gShBLsyuDjTBCiL4p3VsquugBmt3JjbiY2SZRd5a47T2HDDcjAstYblMJN28OC3iwiiSZOpYSLskDi8ejI0WOBkJnmIbtAsM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:ce220c78-975f-4fcc-811a-b79e5b409a4c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:464815b,CLOUDID:b8274ee0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 112eb9ceabf511efbd192953cf12861f-20241126
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1899476045; Tue, 26 Nov 2024 20:50:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 20:50:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 20:50:49 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <avri.altman@wdc.com>, <adrian.hunter@intel.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 2/2] mmc: mtk-sd: Add support for ignoring cmd response CRC
Date: Tue, 26 Nov 2024 20:48:23 +0800
Message-ID: <20241126125041.16071-3-andy-ld.lu@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.369700-8.000000
X-TMASE-MatchedRID: yALcya1h5KX7W7/9wscjdRuZoNKc6pl+ju+GX08gELBKda7Cp9A+RkJW
	dVOufBPR/KZpBkEBJHqIY8ivHy/5E6XzgcphDfm8A9lly13c/gHt/okBLaEo+C8zQZ2rR/Op0Fi
	DqDlQgH4SIx4SDL9Y5uuLFZZYlisfHxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUI51nWVDVVfWhFL
	FIsK0Cw+lupQ5Bsw7jcU72BTeNXW5Nk8cAoC9YSLojLyfylXvJqPdSBhdySgg0qsN/ix5JTJi88
	butrgo98jae4OD13tAV7Mc+rowcVKtX/F0pBwVJjSV5hDFby7aUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.369700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 78C610F20AEBBD1AD5EEE534EEE4D7022F688123028ED1F227EEF820CA4E8EB82000:8

The current process flow does not handle MMC requests that are indicated
to ignore the command response CRC. For instance, cmd12 and cmd48 from
mmc_cqe_recovery() are marked to ignore CRC, but they are not matched to
the appropriate response type in msdc_cmd_find_resp(). As a result, they
are defaulted to 'MMC_RSP_NONE', which means no response is expected.

This commit applies the flag 'MMC_RSP_R1B_NO_CRC' to fix the response type
setting in msdc_cmd_find_resp() and adds the logic to ignore CRC in
msdc_cmd_done().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..e2c385853eef 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1097,11 +1097,12 @@ static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
 	u32 resp;
 
 	switch (mmc_resp_type(cmd)) {
-		/* Actually, R1, R5, R6, R7 are the same */
+	/* Actually, R1, R5, R6, R7 are the same */
 	case MMC_RSP_R1:
 		resp = 0x1;
 		break;
 	case MMC_RSP_R1B:
+	case MMC_RSP_R1B_NO_CRC:
 		resp = 0x7;
 		break;
 	case MMC_RSP_R2:
@@ -1351,7 +1352,8 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 			 * CRC error.
 			 */
 			msdc_reset_hw(host);
-		if (events & MSDC_INT_RSPCRCERR) {
+		if (events & MSDC_INT_RSPCRCERR &&
+		    mmc_resp_type(cmd) != MMC_RSP_R1B_NO_CRC) {
 			cmd->error = -EILSEQ;
 			host->error |= REQ_CMD_EIO;
 		} else if (events & MSDC_INT_CMDTMO) {
-- 
2.46.0


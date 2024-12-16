Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8122AF03
	for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346302; cv=none; b=QHbhP9HznkLmi8rEo1i+ORcsVMdyNR319WuRhE+ZFO/ZlVtipgDfLEyyrENM2O5SL6t6WGWpYomFO1P1V15jfWir3lE368zNkXiRv5WFa9uowd7AFCtR0AGVLDRYlPBNzCA0Md4pP+VDcM6Tdx1Q5+yLP6HOAmh2kyAL4yHiFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346302; c=relaxed/simple;
	bh=N7UyU0SHUxXXQqUtzge9fJ4AAh9RucJH1pYNBJ8I8Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=C8soAMDm9nWZKCTEObbfRXAqbx/SH0BqSCze2dxqTkow6cds3Ex9NUGKW5k/UZboKKgajkuPu5IwcAJ3UeX/7bNjjvr9bisbxuAW9RUpIN8725Gh55donsoSyCJWwsoK1fmCiefoW3NCFl0fG5b8Qb6bwYLpvQ6VjVBqnlSWSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tMzCd1qk; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tMzCd1qk"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241216105130epoutp0272dde916f0354d804af1a201d74b8fef~RosMmJxCm1286812868epoutp02c
	for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2024 10:51:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241216105130epoutp0272dde916f0354d804af1a201d74b8fef~RosMmJxCm1286812868epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734346290;
	bh=PNILPYlvsU6k3ockygiPLsR523EqpQ2yKubyUWaVxOs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tMzCd1qkp6FEmYeb3HuD95D8fFqyXdeVYuKxlfXV8OPknT/IN48h8u1SnqCc/XYl8
	 uY3ztyNLtEG73/FSien3Rq6x236+sZJRBeBumd19cnSdSsEeWwNlaOxuRIuJNI48qv
	 ukm9wKHUJTM2hHUwKE8FWWKbI0qShdAIH+c/Pq58=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241216105130epcas1p2c1170f40a6ddef40376020baa95fb880~RosMVk7Ty1402114021epcas1p2T;
	Mon, 16 Dec 2024 10:51:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YBcFF2v7Tz4x9Pv; Mon, 16 Dec
	2024 10:51:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.28.23379.13600676; Mon, 16 Dec 2024 19:51:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883~RosLMt_fW0845908459epcas1p4h;
	Mon, 16 Dec 2024 10:51:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241216105129epsmtrp165bdabec232a2aaa1a4209aeea1e0a15~RosLMLYDr0601006010epsmtrp1N;
	Mon, 16 Dec 2024 10:51:29 +0000 (GMT)
X-AuditID: b6c32a37-171e970000005b53-35-67600631ee3d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.7A.18949.03600676; Mon, 16 Dec 2024 19:51:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241216105128epsmtip2c5e96d6efcacff4c3e080b29db6adfb5~RosLCqbNY1729117291epsmtip2q;
	Mon, 16 Dec 2024 10:51:28 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, jh80.chung@samsung.com
Subject: [PATCH V2] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
Date: Mon, 16 Dec 2024 19:51:27 +0900
Message-Id: <20241216105127.2180403-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmrq4hW0K6wYtZIhYnn6xhs7jxq43V
	4sj/fkaL42vDHVg8Fu95yeRx59oeNo++LasYPT5vkgtgicq2yUhNTEktUkjNS85PycxLt1Xy
	Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpi57yBbwQmditvnzzA3ME5T62Lk
	5JAQMJHo/djI1MXIxSEksINR4tuBbkYI5xOjxL7LO1khnG+MEu9un2aBadk4bycbiC0ksJdR
	oqPbHML+wihx/bAMiM0moCOx/dtxJhBbREBW4uefC0D1HBzMAt4SU4+KgoSFBSIl1t1sAhvD
	IqAq8fD7ErDxvAK2En93X2WHWCUvMfPSd3aIuKDEyZlPwGqYgeLNW2czg9wmIbCJXWJL71wm
	iAYXiT9b77JB2MISr45vgRokJfGyv40doqGZUWLpkoOsEE4Po8S/hutQHcYS+5dOZoK4VFNi
	/S59iG18Eu++9rCChCUEeCU62oQgqlUkLr1+yQQz/+6T/1AlHhJPf6ZCgiRW4v6F5awTGOVm
	IXlhFpIXZiHsWsDIvIpRLLWgODc9tdiwwBgej8n5uZsYwelMy3wH47S3H/QOMTJxMB5ilOBg
	VhLhrTGJTRfiTUmsrEotyo8vKs1JLT7EaAoM1InMUqLJ+cCEmlcSb2hiaWBiZmRsYmFoZqgk
	znvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA9Pcd/6Tu/4oa8a89CnbqrvYrON+7mrO0JlXVv74
	MT9yk/vPeMP7FhcsrC8tual4zTm3itlmWc9T9yNaEdEXe/3dV/++mxXMF1Pgnvv9e47fibzp
	HhmrZhiVnFsb/bvI2sJVduVxx5wHCdY1dpIVC07YNAbemXbbVcix09pKufJKe/GMuTdumu/V
	3D9bKjmdzZXRRMsm2VAjYmbe8U03LkTXKqRoz8122BBy8sWGHSc/b0ud4fbE2eNlzoaiieWL
	nlzYu7Y4/lPQavkjD9s+2c+ZYSTyc9UOKa+H28+G5Lp9W7ToZcDxiQc6TMXCGn6s6DXXWdiV
	ekDfVyyprGhB2NePV5eF/16rlLdaSqpC9rUSS3FGoqEWc1FxIgA7J5yi8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSvK4BW0K6Qd8sG4uTT9awWdz41cZq
	ceR/P6PF8bXhDiwei/e8ZPK4c20Pm0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBlzNx3kK3g
	hE7F7fNnmBsYp6l1MXJySAiYSGyct5Oti5GLQ0hgN6PEut/XWSESUhKfn04FSnAA2cIShw8X
	Q9R8YpS4duMrG0gNm4COxPZvx5lAbBEBWYmffy6AxZkF/CWOfDrGCGILC4RL3Lk8lQXEZhFQ
	lXj4fQmYzStgK/F391V2iF3yEjMvfWeHiAtKnJz5hAVijrxE89bZzBMY+WYhSc1CklrAyLSK
	UTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM49LS0djDuWfVB7xAjEwfjIUYJDmYlEd4a
	k9h0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGpjSO/1S
	DPszrGzeTF6X3t3P4Hl4ntXVE9O4gsv+nXFIu5bs9uL6V76fXgFr5r9PmZg9gWfze7OM9zXS
	p+qvT9297/LxPpnHWrImQc53Gl8/PVZ6982Dev78Sg6FnQ/b/74vulRxpOKwZ2D4hdCAyFur
	JP95H7/OkjFLIEjVQa/D5PeOmcrh8udnP555YepJloKm1exscroHPtoKl/w+VLHluum5/KOC
	SQYhtZmPWsvWVrk0Hbj87D6Hun3NnOeCNZG/Vd6/333w//NdfLHexY8UQidqWSoqyN9anG4/
	21z2skxSG297VeeVdBOO/y2bnmcynv5T01G1Oki+cund92vvFMXYqnkHL9n8KeHQUT0lluKM
	REMt5qLiRABNysWorAIAAA==
X-CMS-MailID: 20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883
References: <CGME20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883@epcas1p4.samsung.com>

dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
lines of code. This allow us to reuse code depending on voltage.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V2:
- Add more conditions to clarify if it's MMC_SIGNAL_VOLTAGE_180
- Order the local variable according to Adrian's comment
- Use local variable to make more readable
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 75 +++++++----------------------
 1 file changed, 18 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 7ea3da45db32..08a9b963fb1a 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -328,12 +328,18 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
-static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
+static void dwcmshc_phy_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 rxsel = PHY_PAD_RXSEL_3V3;
 	u32 val;
 
+	if (priv->flags & FLAG_IO_FIXED_1V8 ||
+		(host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 &&
+		 host->flags & SDHCI_SIGNALING_180))
+		rxsel = PHY_PAD_RXSEL_1V8;
+
 	/* deassert phy reset & set tx drive strength */
 	val = PHY_CNFG_RSTN_DEASSERT;
 	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
@@ -353,7 +359,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
 	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
 
 	/* configure phy pads */
-	val = PHY_PAD_RXSEL_1V8;
+	val = rxsel;
 	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
@@ -365,65 +371,24 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
 	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
 
-	val = PHY_PAD_RXSEL_1V8;
+	val = rxsel;
 	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
 	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
 
 	/* enable data strobe mode */
-	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
-		     PHY_DLLDL_CNFG_R);
-
-	/* enable phy dll */
-	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
-}
-
-static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	u32 val;
-
-	/* deassert phy reset & set tx drive strength */
-	val = PHY_CNFG_RSTN_DEASSERT;
-	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
-	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
-	sdhci_writel(host, val, PHY_CNFG_R);
-
-	/* disable delay line */
-	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
-
-	/* set delay line */
-	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
-	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
-
-	/* enable delay lane */
-	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
-	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
-	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+	if (priv->flags & FLAG_IO_FIXED_1V8 ||
+		(host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 &&
+		 host->flags & SDHCI_SIGNALING_180)) {
+		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
 
-	/* configure phy pads */
-	val = PHY_PAD_RXSEL_3V3;
-	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
-	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
-	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
-	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
-	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
-	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
-
-	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
-	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
-	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
-
-	val = PHY_PAD_RXSEL_3V3;
-	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
-	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
-	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
-	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
+	}
 
 	/* enable phy dll */
 	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
+
 }
 
 static void th1520_sdhci_set_phy(struct sdhci_host *host)
@@ -433,11 +398,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
 	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
 	u16 emmc_ctrl;
 
-	/* Before power on, set PHY configs */
-	if (priv->flags & FLAG_IO_FIXED_1V8)
-		dwcmshc_phy_1_8v_init(host);
-	else
-		dwcmshc_phy_3_3v_init(host);
+	dwcmshc_phy_init(host);
 
 	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
 		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
@@ -1163,7 +1124,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
 	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= th1520_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
-	.voltage_switch		= dwcmshc_phy_1_8v_init,
+	.voltage_switch		= dwcmshc_phy_init,
 	.platform_execute_tuning = th1520_execute_tuning,
 };
 
-- 
2.25.1


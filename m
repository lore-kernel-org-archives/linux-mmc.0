Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656B11CA0
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738292062; cv=none; b=qekpgGFFQc9sPmmxVGFdfaVxhvDImRN9l1GKDXKGtz7LkleiN6FVNMetV7+cx4gdicGWTn4YvtkrwFCrCmHeW9dw8cbTwC344MXjHcf2N4gpKIE01tfdvtjm74GheSdJ3SZS+sVD8mDpGV2k2qto571FYNkbuKxTIbwLIQNG9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738292062; c=relaxed/simple;
	bh=Kv5qipN1ieMlNhwqGT0LJt3pdBZ9/pUm+Ta7ABHFJjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=dG2uB24iDpOXKI9/gA0Y3+0JH+mmvdZ8BYt1Rp2Oqq5CxG34dDgQZ3wBgcIJN4obPqjnTpWDoI4xEW5YK/OwQeGXVcUoXIDLmDSEg1xAmpuLPxZNjbA0Ro8xkEaBgTUGEXkAUNuSvpss/VTUogOKyGCbeN7dZf7SN5oOw8oWZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TBUl2My1; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TBUl2My1"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250131025410epoutp04fea1b5f104281aea15f36e731b6f1aae~fp2j_h8LA1291912919epoutp04X
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 02:54:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250131025410epoutp04fea1b5f104281aea15f36e731b6f1aae~fp2j_h8LA1291912919epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738292050;
	bh=KRDovcObAHvn8jSXmfybm3Zdp1K36bhYuCVJAFl8MH4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TBUl2My1DThaE80t0e2cx3u9oM8bA5nrkNPrU/45tVnaLs3adyl8GS7SURMNZJ6cu
	 FcjIniyGvr1u3a0ZYfraSB1VeZTvmYxhmgKPeHEbzQ288LWMa4+wkynFFu0LL4E2qr
	 5kOXWx1PYN3MooOCm1lGcpJsRK9S62iljpbVZ85c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250131025410epcas1p22a6f85b289bc5e70e074eece7ce5b842~fp2jr5tU81806118061epcas1p2S;
	Fri, 31 Jan 2025 02:54:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.234]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YkgTF1TCdz4x9Px; Fri, 31 Jan
	2025 02:54:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.CE.23425.15B3C976; Fri, 31 Jan 2025 11:54:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250131025408epcas1p10fa298907557074b1d38b25a56b51f5e~fp2iZ7O0i2795027950epcas1p1l;
	Fri, 31 Jan 2025 02:54:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131025408epsmtrp23e673839a22619f785d2d51370248582~fp2iZTjZb0076600766epsmtrp2R;
	Fri, 31 Jan 2025 02:54:08 +0000 (GMT)
X-AuditID: b6c32a39-973e970000005b81-21-679c3b51b3b8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3B.DC.18729.05B3C976; Fri, 31 Jan 2025 11:54:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250131025408epsmtip12240835011b3da2f5f6549e5037874ba~fp2hn9m552531225312epsmtip1z;
	Fri, 31 Jan 2025 02:54:07 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, jh80.chung@samsung.com
Subject: [PATCH V3] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
Date: Fri, 31 Jan 2025 11:54:06 +0900
Message-Id: <20250131025406.1753513-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmnm6g9Zx0gzlv2CxOPlnDZnHjVxur
	xZH//YwWx9eGO7B4LN7zksnjzrU9bB59W1YxenzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvk
	HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
	X1xiq5RakJJTYFqgV5yYW1yal66Xl1piZWhgYGQKVJiQnbHh2BHGgnk6Fd/WnmRpYPyo2sXI
	ySEhYCLxdcdZ9i5GLg4hgR2MEr+/nWCGcD4xSvT9OMQMUiUk8I1R4uU5uI4nNz+xQsT3Mkqs
	3egD0fCFUeL2/9MsIAk2AR2J7d+OM4HYIgKyEj//XGDrYuTgYBbwlph6VBQkLCwQKbHj2CIW
	kDCLgKrE06VgI3kFbCXezz7BArFKXmLmpe/sEHFBiZMzn4DFmYHizVtng90pIbCJXeLiyyms
	EA0uEntnToVqFpZ4dXwLO4QtJfH53V42iIZmRomlSw6yQjg9jBL/Gq6zQVQZS+xfOpkJ4lBN
	ifW79CG28Um8+9rDChKWEOCV6GgTgqhWkbj0+iUTzPy7T/5D3eAh8ad/ERskfGIlnq85xDyB
	UW4Wkh9mIflhFsKyBYzMqxjFUguKc9NTiw0LTOHxmJyfu4kRnM60LHcwTn/7Qe8QIxMH4yFG
	CQ5mJRHe2HMz0oV4UxIrq1KL8uOLSnNSiw8xmgIDdSKzlGhyPjCh5pXEG5pYGpiYGRmbWBia
	GSqJ817Y1pIuJJCeWJKanZpakFoE08fEwSnVwLTwTdjtJrb15utmi67b1n5iyZXz0e/qP6qV
	WU6aUD/DbGaZ0BpW3enOM6o4r0uoT5gX3Pvsz5ENEVevyh3wuaE/Jc7l4MZTG4teTRHc84KZ
	a+lz2SBrGQHNGftEfepUkrbn6hk9TdxjUOx2IM7lUvmLyt7KE7uPlb4/yWq36oxvX72oS+rC
	Z6mB7XbnDi8/13ysklt5vuCOqQudHoQeujjjRBVH/PP8S0/bOuy2ZKyXeP/q8NmlIf4e1/2f
	er6bx8zos8+m2TV535ZFySkrxNdvv8oXqWXce2Oy+i/OkD2n2sP01qs/XcCnX5AXyfvYjPPl
	F+b+PUK/GyaV8oUfEL2jUVNw9OvMmX1ra9wNJ/gosRRnJBpqMRcVJwIAeTwUI/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnG6A9Zx0gxM7dS1OPlnDZnHjVxur
	xZH//YwWx9eGO7B4LN7zksnjzrU9bB59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVseHYEcaC
	eToV39aeZGlg/KjaxcjJISFgIvHk5ifWLkYuDiGB3YwS664uYIFISEl8fjqVrYuRA8gWljh8
	uBgkLCTwiVFi6uE6EJtNQEdi+7fjTCC2iICsxM8/F9hAbGYBf4kjn44xgtjCAuESDa8bWEDG
	sAioSjxdygoS5hWwlXg/+wTUJnmJmZe+s0PEBSVOznzCAjFGXqJ562zmCYx8s5CkZiFJLWBk
	WsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERx2Wpo7GLev+qB3iJGJg/EQowQHs5II
	b+y5GelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamKQ1
	BHm88uu/98Tu73/gtEOlp+dXZuLXfSZdArGrtzAoH24K4O1eVh1buJX3wON+SdllLNpbTu/s
	WKS/bLas0kbX+fy1fwokI98uL7Havnpl9mmRvyIiJ3xPSU4pXXR4x72q498mK7MrPl8U5pMr
	c99/49EI0dM1apZxS5M6e2z8YzNcyzyv6UYdfZN37gtnH7do+Hc3q6tBPwXmKjYFlrjrVZfK
	3XqkueBunKGfz10XbZ2nr16qndLJndt4KTkpaNu6n6zCkmc1vtgfbGN7OevCJl+5TX9TTmq2
	/M6QmevB/CfGinf3Dv2ZK35788cxLvylo8jHHRQqKNwSs2Ki4tytC5JurApx0ZYyvvpAiaU4
	I9FQi7moOBEAi/s9L6oCAAA=
X-CMS-MailID: 20250131025408epcas1p10fa298907557074b1d38b25a56b51f5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250131025408epcas1p10fa298907557074b1d38b25a56b51f5e
References: <CGME20250131025408epcas1p10fa298907557074b1d38b25a56b51f5e@epcas1p1.samsung.com>

dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
lines of code. This allow us to reuse code depending on voltage.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V3:
- Remove unnecessary condition
- Check rxsel value instead of checking entire condition
Changelog V2:
- Add more conditions to clarify if it's MMC_SIGNAL_VOLTAGE_180
- Order the local variable according to Adrian's comment
- Use local variable to make more readable
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++-----------------------
 1 file changed, 15 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 7ea3da45db32..09b9ab15e499 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -328,12 +328,17 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
+		host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180)
+		rxsel = PHY_PAD_RXSEL_1V8;
+
 	/* deassert phy reset & set tx drive strength */
 	val = PHY_CNFG_RSTN_DEASSERT;
 	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
@@ -353,7 +358,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
 	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
 
 	/* configure phy pads */
-	val = PHY_PAD_RXSEL_1V8;
+	val = rxsel;
 	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
@@ -365,65 +370,22 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
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
+	if (rxsel == PHY_PAD_RXSEL_1V8) {
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
@@ -433,11 +395,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
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
@@ -1163,7 +1121,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
 	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= th1520_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
-	.voltage_switch		= dwcmshc_phy_1_8v_init,
+	.voltage_switch		= dwcmshc_phy_init,
 	.platform_execute_tuning = th1520_execute_tuning,
 };
 
-- 
2.25.1


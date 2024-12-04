Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451618A6BC
	for <linux-mmc@vger.kernel.org>; Wed,  4 Dec 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306715; cv=none; b=dgjILL//PAwn3rxcB7fyl4sRg3bKfwoo8AbP9JaIEs4l52VE7H+2wdmZAFztLSaCM5qMOKoWXZF4FGhfmXKre46l8qBhkYXCdMqy3bO2ePYAOjRKtkU1lhfqwk/T9/4REWsjhx1iye2zpAr+FVJgL09Z2zegTbhriiwZ9CPxKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306715; c=relaxed/simple;
	bh=ceQAuWf0Mbqhk6O51j1FmrtSWl14o01kr+p2VRI4Cr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=dq5gIPe9gbm4je0hKzMKPNJb4PBzme5A5oDv+DoAqiGAcAQuPeApJFx/X8r/NP23n54eWnHPOyz+F/1aMD7ln2ZlX/pKAulXEM/99C6GZY0rORw8pID0jBlUpgvM8PDmxHjbIGGSQxfEdyNLcAwCHqxAFpInBw+KqOk2qdnk/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MeZ+Rt/r; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MeZ+Rt/r"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241204100510epoutp03afc76fb2bc9b57a677144ab9b82b9f8b~N8UUQ_Awd1404414044epoutp03T
	for <linux-mmc@vger.kernel.org>; Wed,  4 Dec 2024 10:05:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241204100510epoutp03afc76fb2bc9b57a677144ab9b82b9f8b~N8UUQ_Awd1404414044epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733306710;
	bh=BwbCci6/s7QIONtqBrwA0P6QY5OMw5SS7RLGmLbdCkE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MeZ+Rt/rmZmkuHb6TbJOCLzpGbOxeodD26TLI8wnFjn+ll9c81EqW9YVio5gIJJJ/
	 N9D79Mvbaa1VUYbPiq7qT/oMWrz7WaqEUtCqWwSjsHWZarWNsAlNUOWGvckKqTy2co
	 1PZCNYFM3aSdQrH7R4tXE+lhTbPIpNd2RwBAQfTs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241204100510epcas1p13021148864ebdc791b80d51844f56f60~N8UT72yTQ0465204652epcas1p1K;
	Wed,  4 Dec 2024 10:05:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.236]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y3CnK1dTQz4x9Pw; Wed,  4 Dec
	2024 10:05:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.1F.23379.55920576; Wed,  4 Dec 2024 19:05:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6~N8USvVn5q3031230312epcas1p2l;
	Wed,  4 Dec 2024 10:05:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241204100508epsmtrp119e343fc97a82bdd0832b6bd16ed7fce~N8USuv-FQ2621026210epsmtrp1V;
	Wed,  4 Dec 2024 10:05:08 +0000 (GMT)
X-AuditID: b6c32a37-17dea70000005b53-81-6750295545cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.F2.18729.45920576; Wed,  4 Dec 2024 19:05:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241204100508epsmtip1e786a5912618b916873a46fdf3ceb727~N8USlLz671749517495epsmtip1L;
	Wed,  4 Dec 2024 10:05:08 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, jh80.chung@samsung.com
Subject: [PATCH] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
Date: Wed,  4 Dec 2024 19:05:07 +0900
Message-Id: <20241204100507.330025-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmvm6oZkC6wdVGTouTT9awWdz41cZq
	ceR/P6PF8bXhDiwei/e8ZPK4c20Pm0ffllWMHp83yQWwRGXbZKQmpqQWKaTmJeenZOal2yp5
	B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
	F5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0xb3MRecFCzYvaurWwNjFeVuxg5
	OSQETCReTZrO0sXIxSEksINRYseRrewQzidGif8Xf0FlvjFKTOl8AuRwgLW0/YiEiO9llPj2
	qQOq4wujxMRFc9lA5rIJ6Ehs/3acCcQWEZCV+PnnAhtIM7OAt8TUo6IgYWGBMImzr5czgtgs
	AqoSzb8/sIPYvAI2Es1n3rBAnCcvMfPSd6i4oMTJmU/A4sxA8eats5lB9koIrGOXmLVuGSPE
	cS4S8/96QfQKS7w6voUdwpaSeNnfxg5R38wosXTJQVYIp4dR4l/DdTaIKmOJ/UsnM0Ecqimx
	fpc+xDI+iXdfe1gh5vNKdLQJQVSrSFx6/ZIJZv7dJ/9ZIWwPiebVa8H2CgnESlydu5t9AqPc
	LCQvzELywiyEZQsYmVcxiqUWFOempxYbFhjDIzI5P3cTIzihaZnvYJz29oPeIUYmDsZDjBIc
	zEoivIFL/NOFeFMSK6tSi/Lji0pzUosPMZoCA3Uis5Rocj4wpeaVxBuaWBqYmBkZm1gYmhkq
	ifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cDUbtyzw27i7tscj6P4hH5Ibol+b3Rx172JFxee
	9+JN0T99NSbJqDLlo+bDD5OFL+kVvi/t3/42r4t/fdoD1VrLjG43zYRZOazhbxWl459eVZZi
	Os0qNcdnly1PpcWaJ6GM1atTJ+5wmmHgJZn1UePbzAADHhVvzZ2/LeVfpvcmLf0U2XpU+mBV
	ZZyjx6miBwmTlXSEL03otX/wRzSnZdW2e5wLG2wXTeJ6x9hzIvuhp8wX+8wviodtrU6a3qg2
	k+T58GKO+XSmzU99dL9ws35TaM18pbDDtL4mtuHZlWlL96+/clvi4sIDF6Ml5zUd+5Q7//0z
	zjuMnQ/Ssv+ILv70cGWL26bUl7cd5poyG0xUYinOSDTUYi4qTgQAje7PJPEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSnG6IZkC6wZEdxhYnn6xhs7jxq43V
	4sj/fkaL42vDHVg8Fu95yeRx59oeNo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKmLa4ib3g
	oGbF7F1b2RoYryp3MXJwSAiYSLT9iOxi5OIQEtjNKNG4YSdzFyMnUFxK4vPTqWwQNcIShw8X
	g5hCAp8YJS5kgVSwCehIbP92nAnEFhGQlfj55wIbiM0s4C9x5NMxRhBbWCBEYsLk02A2i4Cq
	RPPvD+wgNq+AjUTzmTcsEJvkJWZe+g4VF5Q4OfMJC8QceYnmrbOZJzDyzUKSmoUktYCRaRWj
	ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDQaWnuYNy+6oPeIUYmDsZDjBIczEoivIFL
	/NOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MPlmmc3L
	Wbeo7UIvwwr5zIroflGW9DXTVjzVcptlsi/ofO7T9G0P5/93SvuaGlT6dH+syE4lL21/j8NJ
	pjeWvXrdH7vq9/QGudkbgwxTZmsb9wtsnFLilVZ9/XIzw/Oq3cFdh75OTrp1W+vwJse19xln
	vco2b5KYVGH8NzfoS8bd6VGL3820dHrxj3nHggPds21dA905tlbu3nr50bvEhXNqlki43TMP
	TePm7vI/1XNX7Ma8f5eNbuf3Gr+04ZeIVvv4puSNQENJUtHsYGW70pwgW4/arfmF698zO6zK
	zTCd71rE/v+Yw9bWvdPvC35T3z3DdsPSDMdfnQHpXzlf/vEy9O+JYNtzeo3639Smz0osxRmJ
	hlrMRcWJACBHat2pAgAA
X-CMS-MailID: 20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6
References: <CGME20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6@epcas1p2.samsung.com>

dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
lines of code. This allow us to reuse code depending on voltage.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 69 +++++------------------------
 1 file changed, 12 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 7ea3da45db32..87bc32d13cc0 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -328,11 +328,15 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
-static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
+static void dwcmshc_phy_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 val;
+	u32 rxsel = PHY_PAD_RXSEL_3V3;
+
+	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
+		rxsel = PHY_PAD_RXSEL_1V8;
 
 	/* deassert phy reset & set tx drive strength */
 	val = PHY_CNFG_RSTN_DEASSERT;
@@ -353,7 +357,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
 	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
 
 	/* configure phy pads */
-	val = PHY_PAD_RXSEL_1V8;
+	val = rxsel;
 	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
 	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
@@ -365,65 +369,20 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
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
+	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
+		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
+					PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
 
 	/* enable phy dll */
 	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
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
-
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
 
-	/* enable phy dll */
-	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
 }
 
 static void th1520_sdhci_set_phy(struct sdhci_host *host)
@@ -433,11 +392,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
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
@@ -1163,7 +1118,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
 	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= th1520_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
-	.voltage_switch		= dwcmshc_phy_1_8v_init,
+	.voltage_switch		= dwcmshc_phy_init,
 	.platform_execute_tuning = th1520_execute_tuning,
 };
 
-- 
2.25.1


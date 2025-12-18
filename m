Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B92D3A69
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042840; cv=none; b=hWk44l3/BBv2HDgo522OC8OJXq8N/iuu71KhnWmjP05/KE1ZFGVw1RzJJ+jxUjXm7fR3ckVDI9cAYV1n9Gs6CAXm5QnGRRjHxJVSfG/XdyGqu8bQmCUMoUbziyShJy3tCcErB65NySoaybe1EYdfr02XaQkOmTECR3HJfTEGFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042840; c=relaxed/simple;
	bh=MUmp0LYOdvOfTe1YdcfZh5UnSGlwo5wHgJcDhXSjTtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=gUlUclfy9RrzIzXCKzxRH4EQCn45ejMNeIuATyhu3VUN6qyWTswHvI+juq7Ly6MVB6e4pPrOysrPvPPUkrL2YZkoX8wAqQpm9NdjRLI9/C+K5XRs/yEH37HWrUlvLM5GeWjLdfegoPNPb/DAI4SvKaRFtdehq1xtfvHfhWDfrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rza+sFed; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rza+sFed"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251218072711epoutp019acc02b648cacef94cf605e2d108097a~CPpkwcSdZ0031900319epoutp01v
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 07:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251218072711epoutp019acc02b648cacef94cf605e2d108097a~CPpkwcSdZ0031900319epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766042831;
	bh=KH3bNpMCGuaq3DPNFMLM4Avr9vX2EB6zSc0gqOSQo20=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rza+sFednW2KU3j0FY5l94cLyWTduUWttsIrDIZ2Hr3xRI7fPnPQC1gcY/ujGXnpk
	 cqZ57sm55Djg25DeYcEJ+AsQ8ux2RgmG79snsXvE3wA28cRueoJj1W4Mqh3TlKdyGF
	 He9X6ac2SEnlo5nRmC/sHuxYKAu7xcu1bcnUNmKM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251218072711epcas5p32f6c7209849c4a41fc6c333b34f81dba~CPpke_zTH0626106261epcas5p3q;
	Thu, 18 Dec 2025 07:27:11 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dX2L71b9Pz2SSKg; Thu, 18 Dec
	2025 07:27:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251218072711epcas5p454506a0e5cddde54a40b529d6ea3bc1b~CPpkU4B680331103311epcas5p44;
	Thu, 18 Dec 2025 07:27:11 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251218072710epsmtip23c21b548cdf8b4a691e4bf92706070e2~CPpkCCSGP0851108511epsmtip2l;
	Thu, 18 Dec 2025 07:27:10 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: [PATCH] MMC:dw_mmc:when disable biu_clk should check whether this
 clk is normal
Date: Thu, 18 Dec 2025 15:31:05 +0800
Message-ID: <20251218073105.1439689-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251218072711epcas5p454506a0e5cddde54a40b529d6ea3bc1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20251218072711epcas5p454506a0e5cddde54a40b529d6ea3bc1b
References: <CGME20251218072711epcas5p454506a0e5cddde54a40b529d6ea3bc1b@epcas5p4.samsung.com>

some vendor not enable biu_clk , disable it will panic

exynos use ciu_clk ,not use biu_clk

Sorry, I can't follow the below changes.
Isn't we disable biu_clk in dw_mci_runtime_suspend(()?
How could that work because biu_clk is used for register
access, FIFO access, etc.

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..e737333a0727 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3633,9 +3633,15 @@ int dw_mci_runtime_resume(struct device *dev)
 	if (host->slot &&
 	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
 	     !mmc_card_is_removable(host->slot->mmc))) {
-		ret = clk_prepare_enable(host->biu_clk);
-		if (ret)
-			return ret;
+		if (IS_ERR(host->biu_clk)) {
+			dev_dbg(host->dev, "biu clock not available\n");
+		} else {
+			ret = clk_prepare_enable(host->biu_clk);
+			if (ret) {
+				dev_err(host->dev, "failed to enable biu clock\n");
+				goto err;
+			}
+		}
 	}
 
 	ret = clk_prepare_enable(host->ciu_clk);
@@ -3686,9 +3692,12 @@ int dw_mci_runtime_resume(struct device *dev)
 err:
 	if (host->slot &&
 	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc)))
-		clk_disable_unprepare(host->biu_clk);
-
+	     !mmc_card_is_removable(host->slot->mmc))) {
+		if (IS_ERR(host->biu_clk))
+			dev_dbg(host->dev, "biu clock not available\n");
+		else
+			clk_disable_unprepare(host->biu_clk);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_runtime_resume);
-- 
2.50.1


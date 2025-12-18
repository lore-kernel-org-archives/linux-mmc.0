Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9023221FBA
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040426; cv=none; b=rcBZclZE07jP0FWrZp+pgwFAIto/aOyrj0e/x7yzTrtORmEM3mBI7rYtfd/w5Dy6yFwtadj/MM8G9oM6FTH/7tsyO2Woy8DNdIP3rLZyaM8A5NIvT13nbgr0zkG6WGh8+heJix5uuGaNRItlY2khhs0IfMJj7Q39zbyEVGV49F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040426; c=relaxed/simple;
	bh=YxdzTgA8Ip3K0F5WiS2FT+8NtvpfkJUpZwQnrVF1miA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=SvT29UpHbQv9o40ppED+wkNSUiLha7zHqK/Hrfu//JheTwAOB5fXIdTAgL1XpQ0kF6U6wGgVzGJ0bO2FHZ7dpgkf3Wm4/r9qNq6nxu17o98X6bwABtJervSPuiycfgFfJh/USxscnOyj8FInSu9c+QhwXzx/sLZIwB1go4CNhZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IAyZk+cX; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IAyZk+cX"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251218064656epoutp04b059490ef108bc07f3f92751d31492c9~CPGbMwmUA1777117771epoutp04k
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 06:46:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251218064656epoutp04b059490ef108bc07f3f92751d31492c9~CPGbMwmUA1777117771epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766040416;
	bh=uzEeeKBIRfMYjnO/kRDoi1zqdsmYroqwjghEsojN/Mo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IAyZk+cXKu8FtqayUf1XSR7qM+1EROZRIvNfv1wCsT+OZ2O9jMgKp4D0KfjFlH+wG
	 faH7QEscLc8Ou886Wfd7N15Daq7ZXawBKSxaZvRUAzUUMxqCBrf5houHiOo7n/0x7S
	 Y4C+N1vlPFKR3UC672JlaUY5B3du3POEWReiew+A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251218064655epcas5p2232520afd43758be2798b8a83a59d0ef~CPGa23Y9W2932029320epcas5p2x;
	Thu, 18 Dec 2025 06:46:55 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dX1Rg50hTz6B9m4; Thu, 18 Dec
	2025 06:46:55 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251218064655epcas5p328ad453941deb1c60ee151b6ba11d8a0~CPGabtPWo0502905029epcas5p3u;
	Thu, 18 Dec 2025 06:46:55 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251218064654epsmtip1452753c3ce08bf182335a1fa7adc47df~CPGaHs1G51260712607epsmtip1c;
	Thu, 18 Dec 2025 06:46:54 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: [PATCH] MMC:dw_mmc:when disable biu_clk should check whether this
 clk is normal
Date: Thu, 18 Dec 2025 14:50:48 +0800
Message-ID: <20251218065048.1316282-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251218064655epcas5p328ad453941deb1c60ee151b6ba11d8a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20251218064655epcas5p328ad453941deb1c60ee151b6ba11d8a0
References: <CGME20251218064655epcas5p328ad453941deb1c60ee151b6ba11d8a0@epcas5p3.samsung.com>

some vendor not enable biu_clk , disable it will panic

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


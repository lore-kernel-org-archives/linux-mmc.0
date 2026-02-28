Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0333F8A8
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259630; cv=none; b=UCoW8OHf9VkByNWKM3jwi8yxK/gzy9jC2smk92cMnfNwrZ6N+TweEvwPlViypoKaMQ6wgOwXVN8IE11jKEdShtG4yia4nZvwp4137CGCSOhoEaiWb64u/s9TfRCUegJ//I/qRgU1pFNsNM75OGuqNfH2Nxwbsw2n371nM0Rf/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259630; c=relaxed/simple;
	bh=Mc/ukhBWOAhsNnX5Y5G66zMN5eMnSSSUgsc5IzoURhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=eg92f7swygR/iVoBWo73v5K6fgmPKK3/qLc9PaiJzh+ugcy6Q6VS1iYgB/Q/D24ml0Y5e3XpznTT/JyjxuM1NwrNIzfS/zTCc0Ga6H4qHv5Ag8VXgz408kra09iZ1aD/jv3YrF4CmtCJC9Nx0qwE+92sf/hFrFlMQ+SppZblTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oEOZjaX8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oEOZjaX8"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260228062026epoutp03befdabfd0f8f7d3bbd138fc2799d80cc~YVL2nk1jO0217702177epoutp033
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260228062026epoutp03befdabfd0f8f7d3bbd138fc2799d80cc~YVL2nk1jO0217702177epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772259626;
	bh=Y7aeIzf7YhdhhUIQOXfrmLJoFXSw3G6nv5YZ41qAq2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEOZjaX8QZLgQokHPTu/TJnJAfwAUmjBzD38XUX6y2bMUIEiNPauc8Ai3FmKSQKUl
	 5r9Q8IyYStdz9JWjmzAVzDdTmATT07aLvW756ow7hzJBVkw6/v/AL1kxt77saClg5H
	 /zvDOuXn3ncMn83VTMS6rH2sghDSSNUR00I+e0vs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260228062026epcas5p2f41a408da6e54a6aa8adbfe41327b7eb~YVL2PtDzq1169611696epcas5p2v;
	Sat, 28 Feb 2026 06:20:26 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fNFRt3Nlkz6B9m9; Sat, 28 Feb
	2026 06:20:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260228062025epcas5p2404df86646abdbe307bd792d339dd350~YVL1n1E102344523445epcas5p2n;
	Sat, 28 Feb 2026 06:20:25 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260228062025epsmtip2d7252c306b207bd8913d19341d370c49~YVL07h2261538715387epsmtip2q;
	Sat, 28 Feb 2026 06:20:25 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, krzk@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kwangwon.min@samsung.com, hy50.seo@samsung.com, Ping Gao
	<ping.gao@samsung.com>
Subject: [PATCH v4 2/3] mmc: dw_mmc-k3: before set biu_clk rate, check
 biu_clk available or not
Date: Sat, 28 Feb 2026 14:24:56 +0800
Message-ID: <20260228062457.3210099-3-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228062457.3210099-1-ping.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260228062025epcas5p2404df86646abdbe307bd792d339dd350
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260228062025epcas5p2404df86646abdbe307bd792d339dd350
References: <20260228062457.3210099-1-ping.gao@samsung.com>
	<CGME20260228062025epcas5p2404df86646abdbe307bd792d339dd350@epcas5p2.samsung.com>

From: Ping Gao <ping.gao@samsung.com>

If biu_clk is not available, no need to try to set and get
rate of it, just bail out and print a warning

Signed-off-by: Ping Gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index ad6aa1aea549..ccb6bfe3e0ce 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -190,6 +190,11 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	int ret;
 	unsigned int clock;
 
+	if (IS_ERR_OR_NULL(host->biu_clk)) {
+		dev_err(host->dev, "biu_clk not available\n");
+		return;
+	}
+
 	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
 
 	ret = clk_set_rate(host->biu_clk, clock);
-- 
2.50.1


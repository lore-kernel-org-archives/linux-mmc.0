Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F22E1C57
	for <linux-mmc@vger.kernel.org>; Tue, 23 Dec 2025 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464958; cv=none; b=cG685RF4lLqsVOLX1VCjwCC+iI9KRERQ2+JyckKl3+9jDFL8saVJdccPk00Q0EcwxquMwiyA0Ub5w2/6f4KICflX9EAZgpL06pk+gMDWza7Pw9dTtWqP7vBKicMlVU/E7jRSHHOs7LyfNRb1GQ3Z1vjJdOJPrgNUVUcszUdk4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464958; c=relaxed/simple;
	bh=ahsKcMvTzD55eK4qGV4Ev1Tsr9awE9a4lhBSxZngdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=V1ukcbKx/Sgn1ydppilkj/VRoQNFR8X7UM5lHFNfRSskYTNbw7HuRkkZLquKWQFz37XuuXifjarOXHfiOx7OaMvNlm6dx8BJShiGwolmiNL1JP5cvhPVNmORM4Z8gJ4hh4HI9gsClRM4WcGwwHtC4AJi4IWs5c6fqkWONgZW2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QOfcBsqB; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QOfcBsqB"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251223044226epoutp044e57c3e965ca978b5426c70e211ee5c3~DvoKIxW3K1192111921epoutp04J
	for <linux-mmc@vger.kernel.org>; Tue, 23 Dec 2025 04:42:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251223044226epoutp044e57c3e965ca978b5426c70e211ee5c3~DvoKIxW3K1192111921epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766464946;
	bh=/3iOh+UaKJE8lvzsJn4S8W4BE/IzvVnYYCImSCafq70=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QOfcBsqB+9BQUdDniIOrnmCmD/iJ+Zcs9+G0OWThGK+D/FeKTpeW/m1mByEsvxbAV
	 6NvVsNWIyy9wbyRQQAYMtqCLKhGAA7T0tPuJJf9eC+PyjjK7uUij9XAumQaG7TUDkT
	 HF4scSwlincKfDuy8XkhYW3h5hd4LBazNambr93I=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251223044226epcas5p3193ed8d8f2fdbda6811a5a4a659fef5c~DvoJm73kU1812718127epcas5p35;
	Tue, 23 Dec 2025 04:42:26 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4db2Rk0p2Gz6B9m9; Tue, 23 Dec
	2025 04:42:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20251223044225epcas5p2b5afed35eec4ba996a5a223e4b8779c9~DvoJTMXFR0535505355epcas5p2z;
	Tue, 23 Dec 2025 04:42:25 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251223044225epsmtip23b1196aaa913f34eb802a981f484ed06~DvoImuprQ2610826108epsmtip2i;
	Tue, 23 Dec 2025 04:42:24 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: [PATCH] MMC:dw_mmc:when enable biu_clk should check whether this
 clk is normal
Date: Tue, 23 Dec 2025 12:46:21 +0800
Message-ID: <20251223044621.3352567-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251223044225epcas5p2b5afed35eec4ba996a5a223e4b8779c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20251223044225epcas5p2b5afed35eec4ba996a5a223e4b8779c9
References: <CGME20251223044225epcas5p2b5afed35eec4ba996a5a223e4b8779c9@epcas5p2.samsung.com>

exynos doesn't use biu_clk , enable it will panic

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..61f6986f15ef 100644
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
-- 
2.50.1


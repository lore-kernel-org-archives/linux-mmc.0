Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881250;
	b=v40Yiz9ekafM2pBYBCGH0+VVzhkeop3qLR+1Dae6j6OZW811oz1UEclyEBxriTbf4eT0
	 y15rXbzcCn70kpNx+vAS4fQ//AVeo1cZp69Fa9fBmvZRILSaIA1iS0ZgW/SihNwISdAdf
	 tvKsBNsCH8pLn0s7q8mGJiEOrCQOqXfTEOsSr8amVbxzqDAtCAHwRg6WdS4mbxUu/MAxy
	 cGU7908g1vf2IR3gdJYrvB9b/048B2Ryzt2CAW3zpbD3iHNHn2CrGs/AiMJmMp3AYEJ0X
	 tw2n8mFEanW9dul8tmAxxGtL6/CNfw/kd9Hsj4HpITre3t671K8cBMJZMUHPAWKYaVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881250;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tfsM1BiETfGoPnRoZJyss+e6YOX0bg6fIP5X0SX8DA4=;
	b=NjDzVUQrDiMhSfU2DpTxfgSFQEsM4UYdAMzpe8Hnn3u6WnCOdI4HWrwcjz2hQ7iO9lcH
	 LWFe6zsi7oq4iN9XRANrlhWkKLEvw1IifSvQKONF5esa7FMUft9FrFwubnrMgjZo6hO33
	 DnNd78FGSUizFOZlhivJDTRoaUMaT8t52R0y0anSd94CobETu5HqUayOu6SCp2qcs7LIq
	 2dzLsgzNWCVr4WV5Mp2iUrR9BSaiCUQA8TrSzpaCXD0O5aJpb49XwNOfrMbazgcTm6Zen
	 Jo8YjxlzV4WShTQrUgOXLoNinal5FxlrLpLQK6lyRGnoB1sqwu52UKeURhgjX/6owlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ezOFaQgG;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6914A606A329;
	Tue, 17 Nov 2026 02:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6914A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ezOFaQgG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ezOFaQgGLDSQI0v1+mUGzTwzj8+nBxBsandwHwmvSsj79rVX8fxmfWHeywVM02l8mm7mPGApXGvZD
	 GwR/oxbkYfpELfEo5owfsxdW78rm9nmppoWJD3lbifNNlEkHLMT6i1+Gk+KNa8+xmsP2sjatIOZYXR
	 5LGiE+EO9mhwhRxw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26afbb6dec66-3ff68;
	Tue, 17 Nov 2026 10:07:27 +0800 (CST)
X-RM-TRANSID:2ee26afbb6dec66-3ff68
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36afbb6de0a1-9d3c0;
	Tue, 17 Nov 2026 10:07:27 +0800 (CST)
X-RM-TRANSID:2ee36afbb6de0a1-9d3c0
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mvsdio: handle clk_prepare_enable() failure in probe
Date: Tue, 17 Nov 2026 10:07:30 +0800
Message-Id: <20261117020730.20204-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvsdio_probe() ignores the return value of clk_prepare_enable() and keeps
programming the controller, including reading the clock rate and touching
the registers, with the clock possibly off.

Return the error.  The cleanup label and the remove callback already
disable the clock, so no extra unwinding is needed before this point.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/mmc/host/mvsdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 7d86426c60..6870b7708d 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -725,7 +725,9 @@ static int mvsd_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk))
 		return dev_err_probe(&pdev->dev, -EINVAL, "no clock associated\n");
 
-	clk_prepare_enable(host->clk);
+	ret = clk_prepare_enable(host->clk);
+	if (ret)
+		return ret;
 
 	mmc->ops = &mvsd_ops;
 
-- 
2.24.4




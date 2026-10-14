Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AF4EDCB4
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999873; cv=none; b=mWab2kB56wOISA8xe1jPI0g3lZ5/tbywb6nlC0FBzXa0h7UvDE0CF7gjyNJx7Q9xbwiddUp+qM5fPbpEHyXM8jsQvj7XB+aaCiwpKSI2ePgMx9hhzel7oQhUVssBH26frHpwtfI9/oABL81wAchsoxwyMrBtsh5RNFeA1W7CY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999873; c=relaxed/simple;
	bh=2oZYonurprwc6muwlObjEA8seBjbe0bRboulPYlqu/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PG/OkTFpIGVgvRO9b/MtslMCbWUHpz9HIyt97MKegIgT6+6YrHLHAAj2DE4Az3FYX8Zz15M0plGQryObAMVuUi/uxl9/2wwFJfHItrlZcXE5UJ2OcatuzRT9NWNHG7CGB48JjsafPzIphqA2ZWbx03bXU1YjpBCPCHeWv2oGUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hN5A65t+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hN5A65t+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso11772665e9.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791999867; x=1792604667; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=95d33N1meM14gVljkWNmVajc6Ur/SmP+/ev0dbA/4bw=;
        b=hN5A65t+SRG6JU+GKFqo2l1KHOgv2T7vYZzDe8NO5klHady/gOAq/g3xxOWMTX8WtZ
         jVmSKxBX221Oo49Wh++sPvVDPUUxRN3ZTYi100k7Zfc/hJbiOZTxoDHRDMGsVm84DCDN
         +SPaXcvHt1Gm4H6BI88DqsblcVEdENx/hsBBHUAcCjkUZSe1mble1XnqdTm/T/ei56Nj
         9zd+ZdJ7DeZWZqQSZwSR0WnwV1HgngQQl1wbI3h3zlDzfNNAN6DyPyCvILkbGd02jQYv
         3clebL9srOaOlfJqpoItq8SPIDpDToIooHRCmQmDtRwesdY0MLSLDxU4kmXOO1dXk6pp
         Gr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999867; x=1792604667;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=95d33N1meM14gVljkWNmVajc6Ur/SmP+/ev0dbA/4bw=;
        b=S/FDGMfejOi9OxihyppjLLJnymXm2nxBzQSUPiGbLRY0r/41wtRPuXDelrzxgNz/V4
         YqZNx+daA2dmqjPxWic/tPtQzzdxLPKTO2sTRjbcD2D0tcu8L0R/9x9qUzF5P2Ai0Gox
         I8eqbVyHoNcxuYTEuyBslNyqO/UZIDPitORPGPON+ShHG7VxWabhuYg/Xd6C53Hj7XVh
         wrjJA8zpoTajwQ3Lc+FVc+rbpQCVbVgofH7YNdTzaq+fcnsmhUoV0ielqy9Q3wdcTxnK
         F657C125KRWopf2ysdpXu9y1TWx2mnKQjiFTh4E0+g/yE9/P47N4xJ+dr5oMfemLK57J
         1+Ew==
X-Gm-Message-State: AFq9FYKtUfwDPZjwcD8Fa2voJ0qSzrX7iF08GUFuzpFSCXcPPDkjgi5r
	jLBmPMsGTz2EYkSEUrM2fOmK9eSaE3JG01aDJiXsIEo25xkVSjgWosD81FXsxCjurxo=
X-Gm-Gg: AYBFou05jpf0a8dRQBd1LvPUSTEo8LY0dNLT9IYSt6FM3IpKkkG6XcxyjuUGKPDZ8IX
	73dWc5UZQMxEZcbEDpesQsLQonjsgQmrprTYBIw3Rf6tXIQ7xmIse2Han52uwrPwybwI/ba+SlJ
	Jg9Hxy9FukQYFQLzEfezyeF0/VnX/ap/RIGCMLkU5gzNOKGu0L5QfVhZgkO6/GaEwvUKMowndWq
	fFK2+wxr7hnpUDIDYnK88e6GLBAlaXts6UYaOFeFq7TyQpKNcv4KLVbUdcc92MlnqCIsBrAyyLp
	4ebSH90hwJlX+9p9DMzUbl0hZwH7rr0RiLZD9UIzfBg740gArUYMZqKNo0IQRqT75fBlak4/GxT
	RvUEilSFWs+BYG2QZXy0W46X4QUD9bXe4YVduauMEMYyNrNnuZtVCjF9NPMwgr2mx/9Z+bwHbVJ
	+fOEDgeZoIgqgpC1p0a91y8tCYjeuXZDc54fb89BeufCsoe2bsu6DN5SfwynWTSUM/4mlfqmAzy
	QbtTCxLz67rwZWJGKefQBFPXnV62T2kRqBjc6y2Gf75RiWLvAiP4QKH77+RPzB4HpfkN14=
X-Received: by 2002:a05:600c:8b65:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a18e4ca244mr307651825e9.27.1791999867377;
        Wed, 14 Oct 2026 10:44:27 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8b5fsm6878175e9.9.2026.10.14.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:44:27 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 14 Oct 2026 19:38:10 +0200
Subject: [PATCH] mmc: omap_hsmmc: Do not log error on probe defer
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-patch-ektor5-dm8168-mmc-v1-1-2d148ca0f948@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDvgaJW0Vyku4jjWaYlKEqUg3
 t1Ulx+8928QxKsEeGYbeFk16DQm0C0DHuz4FtQuGYq8qCmnO8428oDyjZOvsHOGaoPOMVJp+GH
 bsk8jSO/ZS6+/s/xqLoel/QjHfw72/QBl3KtkewAAAA==
X-Change-ID: 20261014-patch-ektor5-dm8168-mmc-138c9ab3f014
To: Ulf Hansson <ulfh@kernel.org>, andrew.goodbody@linaro.org, 
 rouven.czerwinski@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999866; l=1397;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=yE8QaLHiQFvOinPAzWnIH4J4gbNmnrzgxRBtfUhPuFU=;
 b=4tpQVRTBiUVmSFWGQ7EK/UCtNNM/h2EK0HJMdtFyRXGA88W+khHRr9T1QxUUTfp+y6NLHaTEv
 KBzcmcjSm45BhEFBjJXlxtcdIkY3IV64VijCih2gg8d/qvisLNWzCUU
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Do not print an error message to the log if the return code is
EPROBE_DEFER by using dev_err_probe instead of dev_err.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index de5a3b70107d..ed52adb38fd5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1892,15 +1892,15 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
 	if (IS_ERR(host->rx_chan)) {
-		dev_err(mmc_dev(host->mmc), "RX DMA channel request failed\n");
 		ret = PTR_ERR(host->rx_chan);
+		dev_err_probe(mmc_dev(host->mmc), ret, "RX DMA channel request failed\n");
 		goto err_irq;
 	}
 
 	host->tx_chan = dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR(host->tx_chan)) {
-		dev_err(mmc_dev(host->mmc), "TX DMA channel request failed\n");
 		ret = PTR_ERR(host->tx_chan);
+		dev_err_probe(mmc_dev(host->mmc), ret, "TX DMA channel request failed\n");
 		goto err_irq;
 	}
 

---
base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
change-id: 20261014-patch-ektor5-dm8168-mmc-138c9ab3f014

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>


Received: from mail-m32116.qiye.163.com (mail-m32116.qiye.163.com [220.197.32.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D7348896
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066562; cv=none; b=Nb1IWBQ4krlXbwci+25igR50oHUt84kXuOpCHkyWPmYduwjnt2/2L1eTUQTW9swrcrkIwXNL6N9OZJWJRAHkmVlYO880Ln6yY8JLjEfN8fFDil3tpskb4KOI4NOtFTpxQbmkkMDbUaLeofWZiVetDaymS/gRWzZYyJiaIhom3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066562; c=relaxed/simple;
	bh=1Z8WzQR6kBKar8LutD+xijK1zcWP8kmzkth/yY5o0SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JykAi4B63SprCktmzgGABJCzFYdjnTpnVw8KO6O038bEIDoCpPg7A9KW9IIcy3o1Ja29QYaC60urdn9pPseTlTveN0Y9fX8eO65iBgkWWF7lCL0dighPv2TQvFtY0yBpgqTJUAH/6+l2vDA8RUJv6Zh9bpct/ja+KW4grdpSfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b/f6yOgC; arc=none smtp.client-ip=220.197.32.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b/f6yOgC"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb2e8;
	Thu, 18 Dec 2025 22:02:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 04/18] mmc: dw_mmc: Remove assignment of pdata in dw_mci_pltfm_register()
Date: Thu, 18 Dec 2025 22:00:31 +0800
Message-Id: <1766066445-14144-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c4f55a09cckunm1f354c4b72ad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5OTVYfGR5IHklKHkwYSUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=b/f6yOgCELN45M0igV9mVMbJk2LHZnim21CR+sZnFJpjrAXLFF7uvZ8N+3qvAF0yHezEfKIGYwxT7B7TiQa5LRk81qLOtkHQz7Y0CvjGHKye4aLKABLgnpROPapk0EXLuPSVxg8wsiLCBKrneZSsdrzhVjcYBrAU2HJNFx3gDIE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Cn1GFTHwxF8pzPobuT+MV6FL6Pb3Go5qntc1E7b4XU0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

No one using dw_mci_pltfm_register() pass in platform_data when
searching host and arch directories, remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pltfm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index af947e1..a927f5ba 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -44,7 +44,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	host->drv_data = drv_data;
 	host->dev = &pdev->dev;
 	host->irq_flags = 0;
-	host->pdata = pdev->dev.platform_data;
 	host->pdev = pdev;
 
 	host->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
-- 
2.7.4


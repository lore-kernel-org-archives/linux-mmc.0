Received: from mail-m49215.qiye.163.com (mail-m49215.qiye.163.com [45.254.49.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13745C0B
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116126; cv=none; b=DBmdhw0J9TvVfnMXmVclxaCJG1WDUPbRehMMr1juFB1RyGiUEVWSiUFsu6cGE1RY+n1PhMK0Q8IZObWIcJx345xgNnYbiQqF7FitAr0fuYDWA0vmldftyjv4YacksA+aiTKHnRynEmU3XFOSpMyx1Lk670KCcFjcnHuk2aT+ukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116126; c=relaxed/simple;
	bh=J1N9ZENjUkETSeUWVLKSo2svoHZleQeusKUWSdEQUY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U/UH88HewOxbfAyMszWdq1piGkFTpaTMdvYKH+McwyMojuT+JtgGIQRWrIm1rndoAtGXp3/NbFZFlJyTrvrNGysp9jHE5F886USHt4ZO5k9A4190GgyIbgHXwQqXCFq9yhvEKaWV5keqg6vJseDf2kCr/gBsCaZObohjGFWr8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZF6/m7ZS; arc=none smtp.client-ip=45.254.49.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZF6/m7ZS"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae34128a;
	Wed, 26 Nov 2025 08:15:13 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 01/13] mmc: dw_mmc: Remove unused struct dma_pdata
Date: Wed, 26 Nov 2025 08:14:41 +0800
Message-Id: <1764116093-5430-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd83a6bd09cckunme6f559504dce42
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpPTlZDSUgYTRkfT08YQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZF6/m7ZSiPwB674/tL3ALaYiJVR1tlEIeLHuTDL0lpOTTONNRE1HsjlDXWJLP+sGB857ypVn9SSIKWZTLfSpnXyM/lPU/fiwKe9oft9codSOv43J0mBIq0oHjYVgKwVbbaqjDQj/5qoKMjZbmgTgeYIEt/LtQodCCl88HCTcSB0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9uyoAoJDNFBq0Ky6IHPHXXodiNtOT10whYKcQ5r9faE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

None of the variant drivers pass in dma_pdata, which means it's
unused and could be removed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 648b4a5..b4ceca0 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -255,8 +255,6 @@ struct dw_mci_dma_ops {
 	void (*exit)(struct dw_mci *host);
 };
 
-struct dma_pdata;
-
 /* Board platform data */
 struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
@@ -276,7 +274,6 @@ struct dw_mci_board {
 
 	struct reset_control *rstc;
 	struct dw_mci_dma_ops *dma_ops;
-	struct dma_pdata *data;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4


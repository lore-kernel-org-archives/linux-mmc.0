Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562D3A6F1E;
	Wed, 15 Apr 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265400; cv=none; b=CmpftZ5kFwV89Qtr+rYK/PeI2Vy6YXfNukkTu5piu6hZIl3z0jycPToshkWsVdwr9C0DOVkcEZt0y2yGMM+SrI70izc2Qz8XF2yznZ5fffO5zPOguWv+sU+YLMH/BxBI0ewSyrzmuCeFdPcmr3DNa9Q1PcbLTnScJfhxL8NIePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265400; c=relaxed/simple;
	bh=L84JWopRw4FxKWz9AQYxbsooFwv6BpfQMhWnSZT5k/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izlxXeeflgfjaby4HxmKXK7PnvZ1HcfstXZL3qgZ89N4MalpAJwWbsAauXH5Zvyzg8HPLG0bJnNf2b8N/QRyu+kosYU+ENspJg9sdywhhGIsT08UKsKPENU1unjJ7ceLdzT9+FrXyHI0zm5C0fB80pPRbfaU+zwFKGflbYYhyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dT3QtYJ2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dT3QtYJ2"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 101EC27157;
	Wed, 15 Apr 2026 17:03:18 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6gzkfQ_kabV; Wed, 15 Apr 2026 17:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776265397; bh=L84JWopRw4FxKWz9AQYxbsooFwv6BpfQMhWnSZT5k/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dT3QtYJ2ZkmGSWY2R69mfOtu0cshVPJL3NgQuD6eN14GcsgvCFccoc+1XlY7r1J9P
	 iV35LO9Lj9X1QZsqfXAvQsrc3HZBpMRr8P8CxJFp75ya/I/fzY2Rj9U96vf9eat0x4
	 XGMMFcmgO7cPALyzF9wbBVlVli0mXlXZhYzwa2M6KnO/cLjMY6dX0h+3dDt8BA84VT
	 4Nxo7tB/gixyr0vbhRn19iIb8+2x4lvnD+2BLYHDYqARtiWNedH7XKQTDhar2bc5/4
	 +G3raNE1oOQaY3TXxJ2T/MOu17Y5x4nSqHKCtxyN1S/VDEJqpNUMDXlbsJJYHwmvF6
	 GRrci01HcN7+w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 15 Apr 2026 20:32:09 +0530
Subject: [PATCH v3 2/2] mmc: dw_mmc: exynos: increase DMA threshold value
 for exynos7870
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-dwmmc-dma-thr-v3-2-31014d36b6ee@disroot.org>
References: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
In-Reply-To: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

Exynos 7870 compatible controllers, such as SDIO ones are not able to
perform DMA transfers for small sizes of data (~16 to ~512 bytes),
resulting in cache issues in subsequent transfers. Increase the DMA
transfer threshold to 512 to allow the shorter transfers to take place,
bypassing DMA.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/host/dw_mmc-exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 261344d3a8cfe..4b76b997ddc15 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -141,6 +141,7 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU) {
 		/* Quirk needed for certain Exynos SoCs */
 		host->quirks |= DW_MMC_QUIRK_FIFO64_32;
+		host->dma_threshold = 512;
 	}
 
 	if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {

-- 
2.53.0


Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C23B2FC8;
	Tue, 14 Apr 2026 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155787; cv=none; b=k6Qy6NNHLvNqyk5UzsZzNtcUHyEjeLWtRIkiv8jk9JQ6v0h/M7bODd8VosEL2/IPLtfFOuzobh4zYMZ9N7PRrls5dhJTWg84wPPkJSM9S4whzUXXQi3LrWXS4Q4GxYTSQ28tGkUoStZYr+KhdXdPwfRMl/PCEG5G+Na92y4qnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155787; c=relaxed/simple;
	bh=L84JWopRw4FxKWz9AQYxbsooFwv6BpfQMhWnSZT5k/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSLVxHdoCfGcepYI6/CVrcNK6IaKgtRddTclQeslO1DnrZQ5if/8EIvootSeL7y3yBKCVKnJRkVCXtu+PQnD1gylPJu9F9uKSMy2Vd0+epxkURxKzIEhTr27d5OxRVrbfJ1710PLMdQeJJc+1euhNASZ50VnBEoK9oXbnR/cIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OzUEG68B; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OzUEG68B"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B648826E15;
	Tue, 14 Apr 2026 10:36:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8is0GWIGNF3i; Tue, 14 Apr 2026 10:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776155784; bh=L84JWopRw4FxKWz9AQYxbsooFwv6BpfQMhWnSZT5k/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OzUEG68BWraLt82oL6eodF8oRYmwxfCV4V6DLSn7ixMtUcgoTkTXeR5eihNNsp7XY
	 y8GCEs24oPSKfRaCrIB+ospXIOJREXsi8C5xf7Q35UY6GhR8mVH9GkCsykC3lmwC04
	 Y5yvtC+VG8cqkEzK0eIFVMEcsB8owjhfO1F1C+al/o54navyRFD4J+zDzK91Fjteme
	 2IYiVMevdh2uMYGpT/hBri3k9GTK73JQXuBavFJ8PuBSrZSc9kb0Jy1QwFWtrvH9KE
	 h9o2Vhiup8ael14tYg/NdFjf6OL/Bo+Y3gfWQRvuzbd6dG4pkWHsYtTUtEvhbir70q
	 dh/TzFf+52uLA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 14 Apr 2026 14:06:01 +0530
Subject: [PATCH v2 2/2] mmc: dw_mmc: exynos: increase DMA threshold value
 for exynos7870
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-dwmmc-dma-thr-v2-2-4058078f5361@disroot.org>
References: <20260414-dwmmc-dma-thr-v2-0-4058078f5361@disroot.org>
In-Reply-To: <20260414-dwmmc-dma-thr-v2-0-4058078f5361@disroot.org>
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


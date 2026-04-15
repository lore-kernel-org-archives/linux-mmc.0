Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF818DB26;
	Wed, 15 Apr 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265383; cv=none; b=KtPP3u0wCg4tO8764VAqnpGMS68V1hWo1YIRLmTJ6IorPX9jdFtAGBMzG8N6+tkdluInqq+UWdOJSlsK/YW84yEUfbIzrEgnKByA31VUxBUr5PSiZ3qmZ9MxTx8rX5EmvHRYK8iJaggFbqhFYtXucnU+LCGy3VKO+QAOcVqsWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265383; c=relaxed/simple;
	bh=7l+7KA0YkOWUGWnQB3bKnDxRm1f18ienYQMvCsVbkTY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G63y45Zm6ykoMKzlg+OQ1+ffvPteEP14Cz0vZi5UXTgmb7Z7889nlsSPuQ0ZC32jVvqqSyJ+jw1fkiX71OH94Tk+oH5cGvV7A1mbNcWUh0ny0hM+2/0ebEz7oieYxtRYmRaLhOOQ+WiOUV4sgzFw5VKitE8UqfvfPIRbdFpTUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KFwB1BjT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KFwB1BjT"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 141FF261AB;
	Wed, 15 Apr 2026 17:03:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RnjOkgDaXLw; Wed, 15 Apr 2026 17:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776265380; bh=7l+7KA0YkOWUGWnQB3bKnDxRm1f18ienYQMvCsVbkTY=;
	h=From:Subject:Date:To:Cc;
	b=KFwB1BjTcU2tLmwV6/OYe6i8h7KaNi/unLzcXPVrK4kgxjh+H77du6cYZr++ImDNL
	 UTY20IDagJ7efbxHXCKRdBQ+lPrWS1GDyFSYUR4hx0/Nku6Oo7Z4Kq1Iio9Pp/J5f4
	 s7/VoRcTTIUAoFdL+c5OgNM2fraQcOTU9tenLLbmndtVsAOHRh74q917xy3NYF4YC8
	 a+9sfy1w5dTDT5D+k+4ELfhaCTcZ2z/JZlxwHGGJZxzeIfSPm8QD+g73fNKAhka6b4
	 akFCd7yc+oTu1e4LmtnlTxC+V8v5idPfpjib6CZ3EU7hAcElR+XUsLyHt85XHlfTup
	 1uodu+ZnugBOA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/2] Configuring DMA threshold value for DW-MMC
 controllers
Date: Wed, 15 Apr 2026 20:32:07 +0530
Message-Id: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+o32kC/3XMQQ6CMBCF4auQWVszLRSqK+9hXDR0gC6gZkqqh
 nB3Cys1cfle8v0LRGJPEc7FAkzJRx+mPMpDAe1gp56Ed3mDQlVjJZVwj3FshRutmAcWEk/ojDK
 abAPZ3Jk6/9x711veg49z4NeeT3J7/5WSFCgabVVXa0NE5cX5yCHMx8A9bK2kPn3161X2FWqDj
 el0Wctvv67rGxkP6qfsAAAA
X-Change-ID: 20260412-dwmmc-dma-thr-1090d8285ea7
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

In Samsung Exynos 7870 devices with Broadcom Wi-Fi, it has been observed
that small sized DMA transfers are unreliable and are not written
properly, which renders the cache incoherent.

Experimental observations say that DMA transfer sizes of somewhere
around 64 to 512 are intolerable. We must thus implement a mechanism to
fall back to PIO transfer in this case. One such approach, which this
series implements is allowing the DMA transfer threshold, which is
already defined in the driver, to be configurable.

Note that this patch is likely to be labelled as a workaround. These
smaller transfers seem to be successful from downstream kernels,
however efforts to figure out how so went in vain. It is also very
possible that the downstream Broadcom Wi-Fi SDIO driver uses PIO
transfers as well.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v3:
- Move host->dma_threshold default to dw_mci_alloc_host() (Shawn Lin)
- Move comment to document struct dw_mci::dma_threshold (Shawn Lin)
- Link to v2: https://lore.kernel.org/r/20260414-dwmmc-dma-thr-v2-0-4058078f5361@disroot.org

Changes in v2:
- Remove dt-binding to set DMA threshold (Krzysztof Kozlowski)
- Add comment to describe struct dw_mci::dma_threshold (Shawn Lin)
- Set DMA threshold in Exynos 7870 DW-MMC driver (Krzysztof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org

---
Kaustabh Chakraborty (2):
      mmc: dw_mmc: implement option for configuring DMA threshold
      mmc: dw_mmc: exynos: increase DMA threshold value for exynos7870

 drivers/mmc/host/dw_mmc-exynos.c | 1 +
 drivers/mmc/host/dw_mmc.c        | 4 ++--
 drivers/mmc/host/dw_mmc.h        | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
change-id: 20260412-dwmmc-dma-thr-1090d8285ea7

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


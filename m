Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E537EFEB;
	Tue, 14 Apr 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155778; cv=none; b=FFNy+7B+v5GuR0sKnQncvKH24PVa6fgldotglg7XjeEOvsaOi8aZY9B+VM9EprAmAw/QVbYZCjM+m4FLr4fM/+s+gJcKovBvHsLBEr5ri6zOJCticUlBscFsfaEeqJgJwQ0zXkX1foGXc3qN/h2u3DneLwgH8D9isMyjtbvZj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155778; c=relaxed/simple;
	bh=ghLdmmqYMIFtISlUzNAIj4ZX1t+/pLxltbPOih8nxKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lm7rIa4QxI3xS0PI68LtcFs2ar4ohE9uA2VoGZ0PGzEgj0CHXMNhPIabMtI60w2G6CQUtRAaP0+LuqNNPxuJGPjpRQx2vVkTCzfwGy8A8N0dliLWUGOhYdJZDG6siNYJRy18ty0fNK6mnSx8fqzXMQ6VyqmQQwLtLmx5dRa8nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hJhQQYme; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hJhQQYme"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A706D264BA;
	Tue, 14 Apr 2026 10:36:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6ZzvqgFef7Y; Tue, 14 Apr 2026 10:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776155772; bh=ghLdmmqYMIFtISlUzNAIj4ZX1t+/pLxltbPOih8nxKk=;
	h=From:Subject:Date:To:Cc;
	b=hJhQQYme8vk8dq5ZHCrGJHQRZmPLJl88kTlIWyPojIbeD9Dg5JR1YMfR5B5hNcxmY
	 08Hwog6a35gr7qe9qGGwmiafeiecf7QWbVjarMRt1k78nQjEOxAuvOVpOiHLiogTFg
	 5mgCaT5kVZnaEec1bEBKmXABQq+tPHOorz6m5biCvZtMSAQuTJTEo9ArWPBqJHilAx
	 +2RvWZAFwQkcubq0I1AauXd6Q6AUI9IvHOerLX9ZfxG4L2LMhYsExIoU33XVsfNeDh
	 wRLt8fsCkNQfy7cya/4aTtd2fqJdcQbLk8ZKaDdV2eAZAVx9WQ7pB6c58qYKH6jSMb
	 xdg0Z2Cup34Fw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/2] Configuring DMA threshold value for DW-MMC
 controllers
Date: Tue, 14 Apr 2026 14:05:59 +0530
Message-Id: <20260414-dwmmc-dma-thr-v2-0-4058078f5361@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/83WkC/3XMQQ6CMBCF4auQWTumrRaQlfcwLBo60FlAzZSgh
 vTuVvYu/5e8b4dEwpSgq3YQ2jhxXEqYUwVDcMtEyL40GGVqddUG/WueB/SzwzUIanVTvjWtJdd
 A+TyFRn4f3qMvHTitUT4Hv+nf+k/aNCpsrDNjbVsiutw9J4lxPUeZoM85fwFCYQFfrAAAAA==
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
 drivers/mmc/host/dw_mmc.c        | 5 +++--
 drivers/mmc/host/dw_mmc.h        | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
change-id: 20260412-dwmmc-dma-thr-1090d8285ea7

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


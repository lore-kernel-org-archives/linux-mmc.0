Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B873B42F5;
	Mon, 24 Aug 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554719; cv=none; b=WQhNlHAdBMzKx+bE6Apqqdkp3GYaNz1TclQ/1nRieMlJH6dBdIMQDY/xu5lEg3p/zRRPtk82KYGyJNqveaBVIiPwWdJEzv1lHaZZ+y5ldhIj3MHycnGNY8CP5Ub8o+m1Dmw75YI8OtClKVhNT0LXCBvEWQOb44xYpeF/THAUqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554719; c=relaxed/simple;
	bh=dAajmRcFggLf+YqdXxdU/buJn4uQiWNbe+ajkv0Aohc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaCUzmrSuX1ZqKaM5E3tPEI11m83H2D6U6PV0IdcptpCMou0Nz/lnBMLpTxRj0TVhKCpsAn+hlq4lEeVeBuMCjbpMQ1Q/rGh4JSk4qfoIdJ/0c6Rx9IJk1LbVOUTnoK0jJsMo/5JLYvN1mnKIl3VMH3tFX3IH4lKorXR9Aw1V58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailoo.org; spf=pass smtp.mailfrom=mailoo.org; dkim=pass (1024-bit key) header.d=mailoo.org header.i=@mailoo.org header.b=l6PXMcbk; arc=none smtp.client-ip=213.182.54.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailoo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailoo.org header.i=@mailoo.org header.b="l6PXMcbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailoo.org; s=mailo;
	t=1787554689; bh=0/e0xZQoFtAjbnSrVBDZauzSbhfJRRm5Lb2/FRP1a2s=;
	h=X-EA-Auth:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	b=l6PXMcbkLVPfo/VrrFBAT2MjkBpc8gudJUZS4cbkRdfcnVDz/g6ESYMvbCuErdAPJ
	 DZekMGNO0Jn1k9OHXdNg6cGzh2sLhogM3NrY7VByTQM6DlP7kSOj14XAhpvssDNLxb
	 IsRdzK+OPuiVT74czSKCHVfQPi5NUL2K96f6fNdA=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
	via ip-206.mailobj.net [213.182.55.206]
	Mon, 24 Aug 2026 08:58:09 +0200 (CEST)
X-EA-Auth: LfdxBwEHA41tYPj/4BHDi9aoTrCY8EVRqnuwJXG/LqiNQgOzhnf+eIXiksAadpQVbfkROs95uHh+XYQo7avfLwBaAzjzdlOOq7l8pjbLWe4OnX98ljLHaA==
From: Florian Maillard <florian.maillard@mailoo.org>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Maillard <florian.maillard@mailoo.org>
Subject: [PATCH] mmc: rtsx_pci_sdmmc: ignore broken write-protect on ThinkPad X260
Date: Mon, 24 Aug 2026 08:57:55 +0200
Message-ID: <20260824065755.35451-1-florian.maillard@mailoo.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Realtek RTS522A card reader in the Lenovo ThinkPad X260
(subsystem 17aa:504a) incorrectly reports inserted SD cards as
write-protected.

This causes the MMC core to expose the card as read-only:

  mmcblk0: mmc0:aaaa SN256 238 GiB (ro)

and /sys/block/mmcblk0/ro reports 1.

Setting MMC_CAP2_NO_WRITE_PROTECT makes the card writable again.
Limit the quirk to the affected Lenovo subsystem.

Assisted-by: ChatGPT:GPT-5.6 Sol
Signed-off-by: Florian Maillard <florian.maillard@mailoo.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 8dfbc62f16..d25d4cb59b 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1425,6 +1425,11 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 		mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
 		MMC_CAP2_NO_SDIO;
+
+	if (pcr->pci->device == 0x522a &&
+	    pcr->pci->subsystem_vendor == PCI_VENDOR_ID_LENOVO &&
+	    pcr->pci->subsystem_device == 0x504a)
+		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
 	mmc->ops = &realtek_pci_sdmmc_ops;

base-commit: 388b607d107c07aaade04c7f22f344cab6bdccd3
-- 
2.47.3




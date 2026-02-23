Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9F25DD1E;
	Mon, 23 Feb 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861338; cv=none; b=IvJvHxWWgXWRVhmY/Bol+VXyiGn4g+nvwzZD5oU1j1qGTJkb3LNJ0Zq5dlFhUqCB6Bc91TFkI/i22/3a5gbxoonlATm/n3yHdv7Ieswpr9hVEsPl/ib6tPAOEvGIVqt5riqrH3VPvqTHULGLnjXimO2tO5kyuUoYsT7ImaP3FJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861338; c=relaxed/simple;
	bh=Ogeto/EnD71LOarK5o3fEJM9A88tBkrJwTRn9x7DRhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eoA2rlmd4tvdjwIqpy+XOa+NuV3yazCrmc4Vin++OEU7XWfkyQOcQuxBS4qMSRjKV99ht+911vEigvOPAlzLGBePrOSBi2/wO6pJCmbzXQ4hALozqF8YEi3BJ1opMA/7A04Uvz7DYK8nhQnFaZAvJo6rg0s2L5UvMVUhUDMPcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NUJS3oSB; arc=none smtp.client-ip=220.197.31.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NUJS3oSB"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c9167;
	Mon, 23 Feb 2026 23:42:09 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 02/37] mmc: cavium: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:41:50 +0800
Message-Id: <1771861310-84988-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2a43ea09cckunm7f2aa7e0986f0c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8YSlZMSxoeGB9KGkoYSR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NUJS3oSBGeWqnMxrcPY69IM1XQxic2UBGfUfSO71zOvOcnHABCm++sJPY64O/aTVFRZ/NgFZSp5/ns9sN582nNdOMqKzePQrSzUPEMfh/pNTDwksu2waW8NYmzOjck9Tukcq3RFstJ1DOmyM+J3vMlxktqrXCh3mcO/cEexh+zg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=razRCj/KdwH/QWQ4NPFgL/dcqZf1iVw1sY1Lb13uoWA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/cavium-thunderx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 1373deb..55c46ae 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -39,7 +39,7 @@ static int thunder_mmc_register_interrupts(struct cvm_mmc_host *host,
 {
 	int nvec, ret, i;
 
-	nvec = pci_alloc_irq_vectors(pdev, 1, 9, PCI_IRQ_MSIX);
+	nvec = pcim_alloc_irq_vectors(pdev, 1, 9, PCI_IRQ_MSIX);
 	if (nvec < 0)
 		return nvec;
 
-- 
2.7.4


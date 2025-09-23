Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2330FC3D;
	Tue, 23 Sep 2025 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609973; cv=none; b=qEpzvO5zCNSSKDcb9xaUlRrFcDOAWgVEiTJN9JRAPUODWayx5XR7XjY5InpemIo/NgGhBunxdwHCtDVvJMHSkeK0lU1DIfIxgXbVK38fk+sPxFyZmvzEuuXBKGhdDoiqmj1KmQa1buz6l0lAX7/NV5j4XC9nSZe/JqpmwEujvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609973; c=relaxed/simple;
	bh=C9eK2SZ98FRgRNTa+1cHqyETU4kzXW2v/DxM1bnpBMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttDsarY9P6c++BukvKkUoAUl16/vJxE/3N8jiz1XHGc7fhS0lFfAVeqGv2XREkAU0UFIjqTtM+KgaRxxxpWS+p1CoMFUOVo/pmeqpZV7xoTKvJuVvb7LNDekkUVVnM+nYGYSj1HBpGQEdp91neZ8bhk88abQMiHOb23fJa2oNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=LbGoyBP0; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="LbGoyBP0"
Received: from [127.0.1.1] (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23bdec011;
	Tue, 23 Sep 2025 14:10:40 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
Date: Tue, 23 Sep 2025 14:10:15 +0800
Subject: [PATCH 9/9] MAINTAINERS: add Black Sesame Technologies (BST) ARM
 SoC support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-v4-patch-final-v1-9-2283ad7cbf88@thundersoft.com>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
In-Reply-To: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 soc@lists.linux.dev, Albert Yang <yangzh0906@thundersoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758607828; l=1495;
 i=yangzh0906@thundersoft.com; s=20250814; h=from:subject:message-id;
 bh=C9eK2SZ98FRgRNTa+1cHqyETU4kzXW2v/DxM1bnpBMU=;
 b=JZsgEBGpVqHN9dEd+7lGflgkQfqMK4YBfK00+eHXuadz1pZZPRk4xJZBcGPPACvibVNTyvaTn
 sOPn6YnH8ZUCn2JLP4dwyhNNFWPnFs6c/3ui4w6sT6pCF7vQN/TId1v
X-Developer-Key: i=yangzh0906@thundersoft.com; a=ed25519;
 pk=bEcgALL9KpUg/m7zH44r50xa/re91dI9SA0vGV1/bu4=
X-HM-Tid: 0a99753214e309cckunmfc27e25b4e0397
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUlIVkwYHh5MTk4ZSEJCQ1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LbGoyBP0SW2raJk+/UF4YjSKBEDUJgC+wxJdfWpg+teBxYC47z7isIEwIsVGwCtww8/0ieCI3L4T+fhKxSrp8k04FjEA1AbOBKzvHkar/f2k4EIqCZrwPVNKDchTvdl8eFOJDO+mv9zkxrbw/qbgD4GWW6D703UKgYgtWD0mRAI=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=4dCsZ5GabPrZ/cKkHNeHxtMAqgiDoHIBMdGfIGcjzVA=;
	h=date:mime-version:subject:message-id:from;

Add a MAINTAINERS entry for Black Sesame Technologies (BST) ARM SoC
support. This entry covers device tree bindings, drivers, and board files
for BST SoCs, including MMC and platform support.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Change for v4:
  - Changed file name: sdhci-of-bst-c1200.c to sdhci-of-bst.c
  - Changed title from "add and consolidate" to just "add"
  - Simplified commit message description
  - Removed Signed-off-by line for Ge Gordon

Change for v3:
 - No changes

Change for v2:
 - No changes
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..685294ef3e2ecf124219b2c5eafb8cad25600652 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2505,6 +2505,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/blaize.yaml
 F:	arch/arm64/boot/dts/blaize/
 
+ARM/BST SOC SUPPORT
+M:	Ge Gordon <gordon.ge@bst.ai>
+R:	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/bst.yaml
+F:	Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
+F:	arch/arm64/boot/dts/bst/
+F:	drivers/mmc/host/sdhci-of-bst.c
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.43.0


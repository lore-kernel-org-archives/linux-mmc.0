Received: from mail-m3290.qiye.163.com (mail-m3290.qiye.163.com [220.197.32.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B23B63F;
	Tue, 12 Aug 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002212; cv=none; b=WYpkLASaDN1ZqVNSv6q8t4QNsCVXri3oSscR+HQEWN77DVWgKOl3nObss+B9OlAXBncr+4qIFzhs0g5zmsRKn0uFx5Bdk63r8Umkxj7P/opesfbvn8wm1FD4eBnLfFnk7gYxRvOgIzAnZxs1XWqt/S6HVkmyYP8npkSBHi0wXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002212; c=relaxed/simple;
	bh=zTgB+HkIWxyZXYFmwnQgvESXKIPYQxN69x/bv377KDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLm6sv23blI+SO/STIb4+QWwxrKiuEQ1lPMnl/eByPna+v3G+fa4GSC+yKFZytaQVWoUnq7RZilDPd2U1fmB/9DoHaLlA5XPsxS0jnOv5Niu5J3wHIwYMcGKd4lodrfweJzz7TZrTiOfqZXetqk3SNtNqi+WXpL8a0G/TUb54zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=OIOieOab; arc=none smtp.client-ip=220.197.32.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="OIOieOab"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f211b6d7;
	Tue, 12 Aug 2025 20:31:37 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	adrian.hunter@intel.com,
	robin.murphy@arm.com,
	ding.wang@bst.ai,
	gordon.ge@bst.ai
Cc: bst-upstream@bstai.top,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v3 7/8] arm64: defconfig: enable BST platform and SDHCI controller support
Date: Tue, 12 Aug 2025 20:31:09 +0800
Message-ID: <20250812123110.2090460-8-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989e43c28509cckunm52c5de628443cc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0JMVk0aTRlOSxhMShkZSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OIOieOabStHm2JazoXydk/fhydRg4Q9mi/tfK3CChPUTmplGxJk27odPBGKfsxD7nu91J4PvuPOkcLMmPYdDuylEgKLRb3AaDn2I3Bz1YJ+G8nCZ7sG/LEWXd98fDgulxIDWrQ7rJ8hQxFqTv19mvXVzbaZl9jfFgmc3HTpZ8Q8=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=kJ742w8ZJVIuGW3jnwo9Rh3GEZ+ujaREsWARlA26Ou4=;
	h=date:mime-version:subject:message-id:from;

Enable support for Black Sesame Technologies (BST) platform and drivers
in the ARM64 defconfig:

- CONFIG_ARCH_BST: Enable BST SoC platform support
- CONFIG_MMC_SDHCI_BST: Enable BST C1200 DWCMSHC SDHCI controller driver

This enables eMMC/SD card access on Black Sesame Technologies C1200 series
SoCs. The SDHCI driver provides hardware-specific implementation for the
Synopsys DesignWare Mobile Storage Host Controller integrated in BST SoCs.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Change for v3:
- Also enable CONFIG_ARCH_BST in arm64 defconfig (in addition to
CONFIG_MMC_SDHCI_BST)

Change for v2:
- No changes.
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..8daf8cf3dc97 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BLAIZE=y
+CONFIG_ARCH_BST=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y
@@ -1187,6 +1188,7 @@ CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_F_SDH30=y
+CONFIG_MMC_SDHCI_BST=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
-- 
2.43.0


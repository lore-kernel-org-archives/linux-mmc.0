Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com [220.197.32.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01B38F943;
	Wed, 25 Feb 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013991; cv=none; b=aP1wqn7mESx9WgKzAU3QZajyHsmVxFvfObjb15wu1YuBhH798zv8U2UDTOGfTyJ09OmjCvlzD3aUDdTlHmOqQAQQhLz+rHYzLABrxQcK24kh7bO4ZJe16iUvI0ZcYyCa/4c5rTzUtspwBxaUSWD3NhNxhoxaplqAxSw5Vu4h+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013991; c=relaxed/simple;
	bh=VZQwLOh/Olo2mgtTAwMGYE5FITYtWVXemnbXakJWlQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3AZBlI6EBR+uhIi6RozebZLzfH3G1tcPEhXCddG1j5iNZFlfFwdAtLf1hGxlWKsKVjkZpiq+37nGOhQYSucfKQdvv6CwdD9UuK/L18xA1B98EY+ViyUxgU7r120GgMNdYVQJLNT0iDIjU/J+k4sy/P75mDfSCI8iFYh64Tf990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=ciJ9FPX2; arc=none smtp.client-ip=220.197.32.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="ciJ9FPX2"
Received: from albert-OptiPlex-7080.. (unknown [112.65.126.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34ea9e542;
	Wed, 25 Feb 2026 18:06:18 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: arnd@arndb.de,
	soc@kernel.org,
	krzk@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	bst-upstream@bstai.top,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzh0906@thundersoft.com
Subject: [PATCH v6 0/2] arm64: dts/defconfig: enable BST C1200 eMMC
Date: Wed, 25 Feb 2026 18:06:11 +0800
Message-ID: <20260225100613.3791261-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c944384ee09cckunm3fc0fc0ab1afd4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh5CVh5CTBlJSRoZHkhIGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSklVTU5VSklNVUpNSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=ciJ9FPX2EJtRPysbD09Eyvd0xqGHEqHj14sgdDsIHh/VurM3f1fEX6egq7jVOizDqZI6J1ROMRLSklHdeI07j4rILWZmqIBxK/9aiKI9IB2ot1gXkO1JDKEjKd2o1D4XU3VmFLynfR4jqX4JF4/lsdwJ/3CPyaleeHNAU/J1fFQ=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=Qu97ogafe1ECz7tJtaU8qCPiTT7cxwgF9c/P5/qbe5U=;
	h=date:mime-version:subject:message-id:from;

This series adds DTS and defconfig support for the eMMC controller
on Black Sesame Technologies C1200 SoC, split from the v5 MMC series [1].

The MMC driver patches (dt-bindings, sdhci bounce buffer, BST SDHCI driver,
and MAINTAINERS update) have been applied to mmc-next by Ulf Hansson [2].
These remaining DTS and defconfig patches are submitted to the SoC tree.

Changes since v5:
- Patch 2 (defconfig): fix CONFIG_MMC_SDHCI_BST ordering to match Kconfig
  position (between CONFIG_MMC_SDHCI_TEGRA and CONFIG_MMC_SDHCI_F_SDH30),
  as pointed out by Krzysztof Kozlowski. Confirmed via savedefconfig.

[1] https://lore.kernel.org/lkml/20260123095342.272505-1-yangzh0906@thundersoft.com/
[2] https://lore.kernel.org/lkml/CAPDyKFrcXFAiYouOpjDx3NN-xWACU9jAzEfTU2m_-yvQ9SpC_A@mail.gmail.com/

Albert Yang (2):
  arm64: dts: bst: enable eMMC controller in C1200 CDCU1.0 board
  arm64: defconfig: enable BST SDHCI controller

 .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    | 19 +++++++++++++++++++
 arch/arm64/boot/dts/bst/bstc1200.dtsi         | 18 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 3 files changed, 38 insertions(+)


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.43.0


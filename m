Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com [45.254.49.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88B225776;
	Wed,  2 Jul 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451732; cv=none; b=OueQSNsJJdtelBKsEcMuYZw8LYtErNgoUG1O6IyXXcqcCVwHb3NvlN0EeEp2mW1OqRVwcgK3xFx1Ghe+RpCOgPrGAFrh+kELMPsA4HMdtjLmizN48MGJhRAMOjLYnXURkM889hnpnNB8YmmIR03Yv2CAnf7peG1xxKj9ylJ7Dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451732; c=relaxed/simple;
	bh=j9+o2KKNhw+NXIR8agJ3G8ETowsJUJLb46/hC12GG5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDZh5vfRKU8J0EZ5e83LWDTRl4IPv+DiDIGUxgdKTnr21VYFH9Kgc3iO+erUMcET0ce/ALg/DhRgnpd9trrnAB/DTLeHZPXzcmbyPmJj+3LfeUyrQxEcIU1yN46/lW1FYY8DK529IoRqPetETR14qsiPnP0DiYohBKr4JeSp1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=R9lyRD54; arc=none smtp.client-ip=45.254.49.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="R9lyRD54"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed6b;
	Wed, 2 Jul 2025 17:46:41 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	catalin.marinas@arm.com,
	geert.uytterhoeven@gmail.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	bst-upstream@bstai.top,
	neil.armstrong@linaro.org,
	jonathan.cameron@huawei.com,
	bigfoot@classfun.cn,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	geert+renesas@glider.be,
	andersson@kernel.org,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	ebiggers@google.com,
	victor.shih@genesyslogic.com.tw,
	shanchun1218@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v2 7/8] arm64: defconfig: enable BST C1200 DWCMSHC SDHCI controller
Date: Wed,  2 Jul 2025 17:44:43 +0800
Message-Id: <20250702094444.3523973-8-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702094444.3523973-1-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUJCVhgaHR1OT0xMSx1MHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0NVSk
	tLVUpCWQY+
X-HM-Tid: 0a97ca88063009cckunmee1cabff3ebc08
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ny46Fgw4FzErGk80QhkOHUwd
	IjoKFDdVSlVKTE5KT09CTUtIT05IVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUlISUk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=R9lyRD54Sd2OSBXZOeyjBa35mm+g96MMrnIt2kvkDlTYu3kRcoCuzYY0U2D7Gzudg67W3pnoe5K6jnrW1+/uXPFQaNXNawf7h4diraXb5uDEllw/WY9jjbGY1wVICrUII2PnhUu9iQfOiWyzVySSlUZAolI9SkPZ88dbqxSS3Y0=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=sSxvWs1jHzibMyZ86YFGGKkxcE98EspXtSKi7G7lkyg=;
	h=date:mime-version:subject:message-id:from;

Enable the BST C1200 DWCMSHC SDHCI controller driver
(CONFIG_MMC_SDHCI_BST)
in the ARM64 defconfig to support eMMC/SD card access on Black Sesame
Technologies C1200 series SoCs.

This driver provides hardware-specific implementation for the Synopsys
DesignWare Mobile Storage Host Controller integrated in BST SoCs.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0a1cfaa19688..8daf8cf3dc97 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1188,6 +1188,7 @@ CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_F_SDH30=y
+CONFIG_MMC_SDHCI_BST=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
-- 
2.25.1


Received: from mail-m32114.qiye.163.com (mail-m32114.qiye.163.com [220.197.32.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95E2309B0;
	Wed,  2 Jul 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449923; cv=none; b=Vimzj/OgyOu8Ik56xERE0YsTbwg2VR+8aEidjJYoscwgn/loUVg9nYtXBbDXWI6U0T9ogDcxZcZynHB2DEiGqRyQxqbK918jSI0oNPScnZTN45yhxayXj0ZzEx8OYf/PM5f7BHhiCjaAekV9mZuDl9lrDIjbLgOHUs83LlwgHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449923; c=relaxed/simple;
	bh=lPb9dIxD5+q4ZIVxyYI/lgNb35z0XDJuRZgexaTKPl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZ41P3/W7nvf6pIpA2W1UESc/G06p//9RNP/+/REgqRWH122j4dRzjNaeVtSh7lTpZ6yxZSysV9cNN8ZSJfM5H+12lUMsndSaWikcec1V86gZL6ZVYKBUAuyQye2C1DrmBXQtkRyIcwpV2hvSNnSBEK/VXGb7Q0dnKo7/S9bHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=k/yCuMJx; arc=none smtp.client-ip=220.197.32.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="k/yCuMJx"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed79;
	Wed, 2 Jul 2025 17:46:43 +0800 (GMT+08:00)
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
Subject: [PATCH v2 8/8] MAINTAINERS: add and consolidate Black Sesame Technologies (BST) ARM SoC support
Date: Wed,  2 Jul 2025 17:44:44 +0800
Message-Id: <20250702094444.3523973-9-yangzh0906@thundersoft.com>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB0YVk9CGE8ZGUxOHh8fTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0NVSk
	tLVUpCWQY+
X-HM-Tid: 0a97ca880db309cckunmee1cabff3ebc57
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6TCo6OTE0KE8xQiEqHUoj
	DRxPFDJVSlVKTE5KT09CTUtOT01MVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUlNSko3Bg++
DKIM-Signature:a=rsa-sha256;
	b=k/yCuMJxVeOXaX4UC8xJi8N4oYoHJBUgI1LfpKFjPnB0IpJl5J+ZvP1CeNHd5xPvj8sBdGPHEl5OeI/GNiObheVCq98z6l4Hw7F/B6KMhgVIlpNsRy5+0mWzl6SfnEY1pagXQRbRF+bJDcH1Q70fM5B+IBaK9MIBcLl45KFJN0A=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=p49bABjbEnShhniwT4G/iwpGc59+QIBwBwIG2CyY6WA=;
	h=date:mime-version:subject:message-id:from;

Add and consolidate the MAINTAINERS entry for Black Sesame Technologies
ARM SoC support. This entry covers device tree bindings, drivers, and board
files for BST SoCs, including MMC, and platform support.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efb51ee92683..e3236384c28a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2441,6 +2441,16 @@ S:	Maintained
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
+F:	drivers/mmc/host/sdhci-of-bst-c1200.c
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1


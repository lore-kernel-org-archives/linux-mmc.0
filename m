Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com [45.254.49.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CB24DCF6;
	Wed,  2 Jul 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450516; cv=none; b=YY5dIUv5Tg25+bfoTe3VKi/whOdNgrKaCb2hWVdb7eZtU5fB4igHEV05FgAcevC90oVz70ZM0p4RRm7gi9zkJ2RxhxmiyNFZPobkNGUHK7R8oRSyuzk234mY2b599sZ58GxhrHwtODsk6cwsrA3EKNwv9PAXALHPE052n7qVDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450516; c=relaxed/simple;
	bh=i9OB2XoW87G6P7CVuqhw+Zp1R6CIsj11Qr8nH7WUQ4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjCYxiKYagHhc/FiPV4ih6xyeLrdYs4qSeCkk8J3J8xFGu+EnQh56sa5hv9fw8LQXcQGlBdSjhiYksmCC+NUO2sSuCPdhsVJMRk4Q6B0vUh9g0zZK1t2gPq0XgCLtCgLbfSAF+gpxnNiMxgFdIlNUo8Dg6rQLcqyxcILNHqh1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=CCVhNbF0; arc=none smtp.client-ip=45.254.49.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="CCVhNbF0"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed42;
	Wed, 2 Jul 2025 17:46:33 +0800 (GMT+08:00)
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
Subject: [PATCH v2 3/8] arm64: Kconfig: add ARCH_BST for bst silicons
Date: Wed,  2 Jul 2025 17:44:39 +0800
Message-Id: <20250702094444.3523973-4-yangzh0906@thundersoft.com>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkNOVk9LQktMGRpOSBgYH1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0NVSk
	tLVUpCWQY+
X-HM-Tid: 0a97ca87e53409cckunmee1cabff3ebb07
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6DAw5HjE5LE9RQiIzHUkP
	TC8aCi5VSlVKTE5KT09CTkJPQkxPVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUlMSU43Bg++
DKIM-Signature:a=rsa-sha256;
	b=CCVhNbF0z/nZNzKXzKPmTCziV/mfP8r7/JXYSuX3+o352hI3g6Kd+ZBKmVA2IicGO6JRd2Fv501c/80xty3Xoc6C9D1Fk8SXqWl+jay/xIqLslItLvj1HV/8BynCZlGPmq7wpK9nT9EFSJP0rrE9PrdQfzgP4wfgYZcHo+W1q0c=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=+mZ281H0S02t7176D+bqxjl4chkVEj1RFfKyhGtpJ7c=;
	h=date:mime-version:subject:message-id:from;

Add ARCH_BST for bst SoC series support.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Changes for v2:
- Placed the configuration entry in correct alphabetical order
- Used generic family name (ARCH_BST) instead of SoC-specific naming
- Followed upstream kernel naming and description conventions
---
 arch/arm64/Kconfig.platforms | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb029aa4..4412d54b224d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -106,6 +106,14 @@ config ARCH_BLAIZE
 	help
 	  This enables support for the Blaize SoC family
 
+config ARCH_BST
+	bool "Black Sesame Technologies SoC Family"
+	help
+	  This enables support for Black Sesame Technologies (BST) SoC family.
+	  BST produces automotive-grade system-on-chips for intelligent driving,
+	  focusing on computer vision and AI capabilities. The BST C1200 family
+	  includes SoCs for ADAS and autonomous driving applications.
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
@@ -402,4 +410,6 @@ config ARCH_ZYNQMP
 	help
 	  This enables support for Xilinx ZynqMP Family
 
+
+
 endmenu # "Platform selection"
-- 
2.25.1


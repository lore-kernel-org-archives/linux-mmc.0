Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com [45.254.49.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D81DED57;
	Tue, 12 Aug 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002210; cv=none; b=rNgnh71S/9AERpOQWAyZjSB6A1p9otzeejfuGgJ9yIFngqjOr3iPHZdjTXIU2SKzdXiDtql7Hvac23wncf2wC6/Inpir6tM25r3tOYxL/m8EFuimbhJLyebkIVnwQFHvbgJQJm6EXjcPPJOBLBo+SN5ZlgLPmf69Fxc6S794GRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002210; c=relaxed/simple;
	bh=C19Qypf3MdiVdmYT5r6F4/GjE1+TeoyXiFf4jgLAP60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ygjz6dtDKe00gxrF5FQAJLpyqMxu+b6vuS+zDn21/EKoPBSNFxQ3WyMBHcdx2g3I6nmwxoorGTTk20Ezr5jMmtRM2kh+zQyVmqervvLbz0gwDHQ7vxsBkT95cD/Rj3wRckLvAcdUUe6zxIrGpjx4AFRHdDUgAc/7rqA6Udu3ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=McbTzGke; arc=none smtp.client-ip=45.254.49.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="McbTzGke"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f211b6ce;
	Tue, 12 Aug 2025 20:31:28 +0800 (GMT+08:00)
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
Subject: [PATCH v3 3/8] arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
Date: Tue, 12 Aug 2025 20:31:05 +0800
Message-ID: <20250812123110.2090460-4-yangzh0906@thundersoft.com>
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
X-HM-Tid: 0a989e439eab09cckunm52c5de62844346
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQx9PVktKQkpPQkoeHU1OTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=McbTzGke7qRrlKTuxiDsOwdTXAQmdvv0q9YnddOnQOYYWYa3bE00ayXsLDWMo8KiAkITrltpt46MfXAp+c8ZDqwjqoTy+KLv8ki/cuUpjtzCr922cl7deSFYHSmbfJoVJjXSZFDyvKnoXCrZpb+22NUmayt5HDfrmTQ1nvL0/tU=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=5azJ5qEoVzNoXa2DOglubsbylWr8QeDyzeiW7uUhUmU=;
	h=date:mime-version:subject:message-id:from;

Add ARCH_BST configuration option to enable support for Black Sesame
Technologies SoC family. BST produces automotive-grade system-on-chips
for intelligent driving, focusing on computer vision and AI capabilities.

The BST C1200 family includes SoCs for ADAS and autonomous driving
applications.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Changes for v3:
- Reword subject from "for bst silicons" to "for Black Sesame Technologies
SoCs"
- drop unrelated whitespace hunk

Changes for v2:
- Placed the configuration entry in correct alphabetical order
- Used generic family name (ARCH_BST) instead of SoC-specific naming
- Followed upstream kernel naming and description conventions
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb029aa4..b078b70ded0c 100644
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
-- 
2.43.0


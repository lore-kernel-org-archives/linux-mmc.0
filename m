Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com [45.254.49.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689F311957;
	Tue, 23 Sep 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612378; cv=none; b=A4VQs+HwW2pog4Ly5/+eksDfuTEkxpPAde4DJid2Hmts5SxWUXiMf0lGu3cujCPL7kTN/eeNIE2GpPUl6TQwvrNK8pe4OGRuueQAGuWA56TNFYJDP5n+FB8SzzBhRnN/yF3KnFzSAhPFPA4cl4eVM7ylKeSDGf5g25B5vRVkzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612378; c=relaxed/simple;
	bh=cHT9OdZmOkIsxZYmVp8kL8+kNdAyxnac4z7DgCBE+1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rF9c+Ot1Sm7GjV6PwGwiK/erXUPiW3WQNbMlpMGGfs2AOh+ySFPGa6YtDg0J4/wpjWvhRbEDHO25EcjMNj825flPJQ3px7IU24qGbM7Emw+8NKYAa2rirzmzcKuQaS9og1OREz975vaMFl4uAAFoXzQsxZkPseu2qP5PGXecrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=jtjwu41V; arc=none smtp.client-ip=45.254.49.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="jtjwu41V"
Received: from [127.0.1.1] (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23bdebfdc;
	Tue, 23 Sep 2025 14:10:32 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
Date: Tue, 23 Sep 2025 14:10:09 +0800
Subject: [PATCH 3/9] arm64: Kconfig: add ARCH_BST for Black Sesame
 Technologies SoCs
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-v4-patch-final-v1-3-2283ad7cbf88@thundersoft.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758607828; l=1640;
 i=yangzh0906@thundersoft.com; s=20250814; h=from:subject:message-id;
 bh=cHT9OdZmOkIsxZYmVp8kL8+kNdAyxnac4z7DgCBE+1k=;
 b=OME+FkLaqTP1p6JDWalZczqQZG/luaqEYd25xIJ3VIjzrcNGla4mWvW6JCbOoj2G1Qj83dWlJ
 ySZJfmZ4MzTB7cpa6dk1Of1li1dzTh1wdpESALut0Q0Jxe0sGa1t4Oz
X-Developer-Key: i=yangzh0906@thundersoft.com; a=ed25519;
 pk=bEcgALL9KpUg/m7zH44r50xa/re91dI9SA0vGV1/bu4=
X-HM-Tid: 0a997531f48c09cckunmfc27e25b4e0271
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE1JVh0YTENMGksZGUlPSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jtjwu41VZUI2FsHS4LND00ky5OEvWLJEiWKpD4y0Z59bYpQT+VrlGfSzcx1WNYySyRP4nNNB4mW14yvZr8WQ9tsmb0z1aFzssbdsd5qbESsJyi2T+fS2Ay9NEimMAMSLOIwuUmrIPlA3v+fs93tnAptcQNBogeUKnQlmsYb4wjE=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=NqLPM+kXoeHgjPG3WNK50K5OpNlzyApuQ3Iy6PDhjwg=;
	h=date:mime-version:subject:message-id:from;

Add ARCH_BST configuration option to enable support for Black Sesame
Technologies SoC family. BST produces automotive-grade system-on-chips
for intelligent driving, focusing on computer vision and AI capabilities.

The BST C1200 family includes SoCs for ADAS and autonomous driving
applications.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>

---
Changes for v4:
- remove Signed-off-by: Ge Gordon

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
index a88f5ad9328c2ee13a0822782af6c83899273f14..8a870b213dee930861bab39dce2df295c387cf89 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -112,6 +112,14 @@ config ARCH_BLAIZE
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
 config ARCH_CIX
 	bool "Cixtech SoC family"
 	help

-- 
2.43.0


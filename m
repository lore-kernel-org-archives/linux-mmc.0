Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6731D6BB
	for <linux-mmc@vger.kernel.org>; Mon, 20 Oct 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925003; cv=none; b=d2qmijAQz0yQHaqb6/COohFHQXvpnwUkj+1aRdYk2J3AQc6dzqMZXqsi1+XxCyST08AvfhKQNNLu/m56GvF0OqPqp25OmmhuT6f09oSFrlebej2CE0h3oB9U8mCm1ei5tBkEcKaIpepcDQRNX1ZPWJhxs+rU8w+RcA+pbPKLB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925003; c=relaxed/simple;
	bh=4hqniQV/6V0Q3buoONOUSNrNehtEqf2C0LTJGpSdqdU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TyJ24yIM+ANLGnbxEwVoeIrL9rgfTtbPAvg7k8iREyIwqO0w/cCaKg/eapBZejj/7aDC+Byl1lx5v4ZEo9P+2vQZHeNIsO7J3vi/GBFj5R1/1BU2L2/hav0yriz671J7PbDli72agoOCgqFZjl9ffBhpaSsXb345PfBcjxL9fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UQoChc5z; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UQoChc5z"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 266f2011d;
	Mon, 20 Oct 2025 09:49:49 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to 0x4
Date: Mon, 20 Oct 2025 09:49:41 +0800
Message-Id: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a99ff4ef5e709cckunm7dc9b9f843d19c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlJTVZIGBhDH0sZQ0xKT0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UQoChc5zjOocAgpWqLLP9Qgm9zi/FPOfn4sIeBewkzW4Fg3Dtl5lWFiybHBvVzHaYKjGVBq6liC1HbU1k4y8V32uecJepPQ14lsg6PhHyQhNdK5RXyzzMClHqMpDNbf4KV6VvSevOXTejCNBF8OlfU1DA04oCbw/4YqlEFtmssA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=yxXr5m9qvrc7RSco+mIdwPHLMRI0rH10mp0tZFbsHZY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

strbin signal delay under 0x8 configuration is not stable after massive
test. The recommandation of it should be 0x4.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd453..5b61401 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -94,7 +94,7 @@
 #define DLL_TXCLK_TAPNUM_DEFAULT	0x10
 #define DLL_TXCLK_TAPNUM_90_DEGREES	0xA
 #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
-#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
+#define DLL_STRBIN_TAPNUM_DEFAULT	0x4
 #define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
 #define DLL_STRBIN_DELAY_NUM_SEL	BIT(26)
 #define DLL_STRBIN_DELAY_NUM_OFFSET	16
-- 
2.7.4


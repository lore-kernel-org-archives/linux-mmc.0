Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com [117.135.214.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70D2C21CC
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933480; cv=none; b=Cr21Q4U06S7wgRq0ZvBVczX3a0TPdKGu873PBeynhlxtmloKTpwurvlRBHYm/uASX2BOXA6E2xfObyXSqv2PK3SY9M7lttdwba8+Lp+rMaA60PFdpTKPEvsoFTsA3miVthPngjKVKMlI9+9qvY495NRqFZowDsM0E8npAfAW+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933480; c=relaxed/simple;
	bh=tn9gJG3BS7Le1DIWXrvL4ivyA/8fL9U23BoI7qSMY/4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s09g+ComySib60iuDIm6W/QoMS42ETqO1ISHAIQ0saAFqbJrkdrg+TLjzg+6vIa4N1CdAhXWkD71W27lxYfOKDdM4F1HMfLuDRPPs4NZAglLnVIzyaK2DzUUZL5PVN3Ij/g2mV9i0ZhTyCTO3QHEam02sUX1Gf9OsIZQk2neidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MEojOPY5; arc=none smtp.client-ip=117.135.214.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MEojOPY5"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 294e35839;
	Wed, 12 Nov 2025 15:44:32 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: sdhci-of-dwcmshc: Disable internal clock auto gate for Rockchip SOCs
Date: Wed, 12 Nov 2025 15:44:19 +0800
Message-Id: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a7705fc4409cckunm8f73707313c85a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05PS1ZCGEhCThgdSk8fT01WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MEojOPY5t5IOHQKfAUdMm/Y4HVAF/I+5HXm7HevuM2qYTLUoaAN4BTzSmznXaq7CXltOMyGYF1J/+3ASM/x/4KnnybHmP0KKePUgQwEJfrtZblfr92LY6CoYgzKGmx57B4pfKkKx0K77ufQslDJKkds3Wz61oNmoHadZyNI7UxI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=zRbfAm65IZ20BrBgT0gB8jiEvce6GcYJAghk2mnfg6I=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Enabling CMDQ support can lead to random occurrences of the error log when
there are RPMB access and data flush executed:

"mmc2: Timeout waiting for hardware interrupt."

Enabling CMDQ and then issuing a DCMD as the final command before disabling
it causes the eMMC controller to auto-gate its internal clock. Chip simulation
shows this results in a state machine mismatch after CMDQ mode exit, triggering
data-timeout errors for all subsequent read and write operations.

Therefore, the auto-clock-gate function must be disabled whenever CMDQ is
enabled.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index c66a8df..e276a4e 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -713,10 +713,11 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 
 	sdhci_set_clock(host, clock);
 
-	/* Disable cmd conflict check */
+	/* Disable cmd conflict check and internal clock gate */
 	reg = dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3;
 	extra = sdhci_readl(host, reg);
 	extra &= ~BIT(0);
+	extra |= BIT(4);
 	sdhci_writel(host, extra, reg);
 
 	if (clock <= 52000000) {
-- 
2.7.4


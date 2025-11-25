Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAF2586C2
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113539; cv=none; b=gkhg/yCjYpYM7w7FW43g3Q3gO00z4XKhOJe9/jRqv3c4LTcTUithIXCdu59mrzklvj+iLS52IsP0lXVhxgzAwhse6/P2+AY+EF0dHmOFr6rM3H1QgIOsWH/1jIjtkb65d0sBXHdpAU+Xm1iL+EZf9raXJ7MMrO3n7d+fWPNoft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113539; c=relaxed/simple;
	bh=BMy0E/YLdVJPZQrFrBq0fSj7SDFrN/gvcfTnrjuJnOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Msc5jmXfKDtXln9xby8xdoult5eG5R9XVbVY8jbKeizuf4p1TvuvcGoczL3EpfeeQ2yMYnZePasl74+YPUo3bUF9NbOF+2Ic8ZyCzYjOBVYE+uAisAIomVY30K/AEPrBuYXJ3A9VNhga6gcVwb5Jk5093m8I9Nj6yvsnhdPcfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZFCilqXL; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZFCilqXL"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae234a18;
	Wed, 26 Nov 2025 07:26:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: sdhci-of-dwcmshc: Disable internal clock auto gate for Rockchip SOCs
Date: Wed, 26 Nov 2025 07:26:39 +0800
Message-Id: <1764113200-237279-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd577d1209cckunm0d7ff06b4d7c0c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8fTFYeGkwfSxhPSklLS0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZFCilqXL7q2AKpn7Cuo0ibtnmG7LmIqPV6FA4Wd3b5JSg+Z+xCtXr5aRRv3Q+gXi9EEpBO96T0EXZ+UUUPNWBYhYOnG7hYVXfZI5VOsCu1JQ4178+F19ckA4XXz5lJAQNK3CTpWfbkAIjxIN4lUiHOATGwl2oY5V0PByOirp8U4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=01MlGEe//G6BpeQK9BiOoMGUGr3i1N9jpoYUzNG2dho=;
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v2:
- rebase and add acked-by tag

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


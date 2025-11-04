Received: from mail-m8285.xmail.ntesmail.com (mail-m8285.xmail.ntesmail.com [156.224.82.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5D1F95C
	for <linux-mmc@vger.kernel.org>; Tue,  4 Nov 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228301; cv=none; b=pyd5dkUUJgeDe1sSfnJqDlXFSoIq9e9xtDGwxqTYAsqJMcwnpI+ilagh+UAcG332VPpOZ7XeN5TQVeqKkam0UFt+AzFiSoBdA2JxdCcGphMu2lLA7xObUCmp69pkREHmOn9fsW41IY3EzqIJQDR0Qgp+K1usSMQUxCr2+6e1w7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228301; c=relaxed/simple;
	bh=hvnSdCPSkh/7oNBuS4N+uE4tdzXpiGDpJiMdfBNkywI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D3kUdakmi3ffesIWeEErcDwgAQzCYQ86N/Rhbp7RIyfmY5cxD7fMBp+a1i9nxl+FY03cvNvYvu7jdmm51n8xZ0uZ05RbV0O/g0I5NOP4cDm9XHfQSN72+LVRjfH/puPxgVGPmQdKucSkn4NMqnw6/6jkRkiV4X8fFVznwp0/zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YVFHfac8; arc=none smtp.client-ip=156.224.82.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YVFHfac8"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28471606b;
	Tue, 4 Nov 2025 11:51:32 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: Fix wrong internal phase calculate
Date: Tue,  4 Nov 2025 11:51:23 +0800
Message-Id: <1762228283-5025-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a4cfdc92809cckunmbcb3b314af89ad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1CT1ZMSR5DHhgfTx9PGB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YVFHfac8fmzI4iux3lCuFh6U9hPaPv9xsbvDAoUiqdeq/iuLPeVJHDBxPQE8hrVdVa2yw8o28m7/W0t61hrt2tjg7N7ZGJ3N5Xlha/mA4WlkDCc25mS4WoAOo3xLV8lHHkd3Hq0sijNAPdzV4gOYU2d07uUI2BRe7O8YDp2gHQk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=vSm4uws7dN9y5KzPDQol27QF/KlgZoOhczJFgZ0ySCQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

ciu clock is 2 times of io clock, but the sample clk used is
derived from io clock provided to the card. So we should use
io clock to calculate the phase.

Fixes: 59903441f5e4 ("mmc: dw_mmc-rockchip: Add internal phase support")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 82dd906..6813549 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -42,7 +42,7 @@ struct dw_mci_rockchip_priv_data {
  */
 static int rockchip_mmc_get_internal_phase(struct dw_mci *host, bool sample)
 {
-	unsigned long rate = clk_get_rate(host->ciu_clk);
+	unsigned long rate = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
 	u32 raw_value;
 	u16 degrees;
 	u32 delay_num = 0;
@@ -85,7 +85,7 @@ static int rockchip_mmc_get_phase(struct dw_mci *host, bool sample)
 
 static int rockchip_mmc_set_internal_phase(struct dw_mci *host, bool sample, int degrees)
 {
-	unsigned long rate = clk_get_rate(host->ciu_clk);
+	unsigned long rate = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
 	u8 nineties, remainder;
 	u8 delay_num;
 	u32 raw_value;
-- 
2.7.4


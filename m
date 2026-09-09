Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A53D45CF
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992676; cv=none; b=uLuGpUR3AjI8QtMMhQuF3XjgKLYfcYzLSLZjCr5kGw+vzFquF64sxkcOCZd1ZV2XITh5Ut+k9gMLZUxkAT+Ik5xq7ZMqj0TdQlNYFPjUzktXFtzE3erP9og3C3sl2RvCJpkFzs43jcRs3KzY4TdgT/XgIrrLWds2Ii7fskwxVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992676; c=relaxed/simple;
	bh=plArU9jlAhXUMcLHIAmidbgt8bZqZJWLKcgaxNX2C2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvK1tvmV2RYsbB0IAFdhCDIU2dRtuXvGlEXmpUyGIFbDM1x92DLkVesLdU27vE0cQl4NlIVxOJnvxaVw/YA2vjK/y0wk9D1TE9h0wqCHXCdHDVD3g/SPvjflNmvsRG+kAewhBXH/kJ1b8Wn+2mMyo6I+mHXH8ir0ZzDHUjhHrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjd4nq40; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjd4nq40"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso7667389a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788992674; x=1789597474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IoCf21jwmykRsUWM5Fodjr5t8KndX12WFcMHhxMu9LI=;
        b=fjd4nq4073GK3HZGG+sX7P7KCQIEaXaPIiA1YnLAyvm53Z0Aysd0RUmYnuVogaj8re
         6bWGHpZAX6mgkSGeOHa2mbW7UbSRbhUvgVGnnA2xlOgMLZBWiGdUZxIGhORmX4NDR3X1
         ArR1g0brlAmNWE29x7OZc/n0e/FKRcOQ5dLhxdUZrkggSoKpZ7wpoDx8xvdtSczzilks
         LmI4tLSoAeZ6+bu1QDPIu3YRqBogyNarGphz5xI50zFYlOFS9QRzwojJOfJyezjDbJ1C
         GMxDfdztqLEL1xxTS4nTIwBJwtzTotHcvs32e7Jv81hocbQ8NiITh9OdFf28rcMB/olM
         PUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992674; x=1789597474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoCf21jwmykRsUWM5Fodjr5t8KndX12WFcMHhxMu9LI=;
        b=qgurHqPjwhkf/hmk4l830cr4fc+STN9ASy3xsZvHiswL7B3xd/WEuhFjM2sA07qH2J
         3N/01XmdGPuMPBxz52D9QI6q609r301+rbnlMdDkVzKDVqvAZZe2GmZSTGDBo7hdQzzA
         0xIVXPTrRgGsrZvrU8tbFWQlUhadCwkH1wTJDMz1Myu5d69Bak8mmsnc2uEscSYkwbT9
         xKwGDy+tAYhozEBpjx8X3lt3nrFjNeDpfstpK9GBYTSP91V5KQLYvVrl9yhmGKwT3GKa
         5SMIhAbmYQue/deOBWJYrFoyDx66p1ctPgHnQHoDiqjF9TTD5i8YnyVsrRSrVboFmgHs
         9VKg==
X-Gm-Message-State: AFuF++lKnqZi4/cYfaK+V9S4byhlYdJmgO7rxB9rzIJvHPL/nJcfluWT
	fiEsXqztb8RP8dMnUA7jmCZROCTRimhX3HVRc1xNt7uTgPafThV+01oEpuJzoQ==
X-Gm-Gg: AYBFou2om1JcPt4aJZZYpgV5Ytgi9g2eM1cLuLjk4s74GosbL5yE0DuETwjc85RKS6Y
	3q9tXY+DbBuu35E5c4e7TczHe3hP+se5u3SkkWPPbg+B8lgULlaRweDKkbiXmFyNAJUuhDaNYJS
	aUPAO1GolI7FO4WFnbjvBkRt3xD2m77HK07gKRrn80P0Pb8a6Opuqft1YCDIC4+Yjr1P/1g8jrW
	5j6otGUminE9SvgyMjIacZW9zq3t92SJe2Ax86Z1kpPAXFrKBmYYLufy0sgPjQ/LPQ2oQYikyCA
	toJlLd0VoXqi53aA96C6tjCjhpXcOVH+aOW6+yWCt0TvOlyIC5IEGG7TgpX83PtuUnE39DbVjIV
	dUzZhuc1kDnPKvWvM52busTPjnVSUIVwteAz/VYlAuJxuf+souvXejMprej4whKeOxpTff6rxR5
	ibx4I4FNwnMYOTnlfzt6PBAs/4007K8/mM9+EzYFGTtOiE9PqdoUAnisuFCCFA99AFrL0WFN4MT
	NCGUMsfhC0FcFdx7gUxTeYwnvjusZLAa2IiYNe+LOp65L7bgyIELsvfQPoi4FaldGpCLK70hSpk
	3cVLrJjBWLZ1HRFuwwgtSxudaTB/3D3kjU6TgCbDpob1iZ7f
X-Received: by 2002:a17:90b:17c2:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-39b25f1c5bdmr52789528a91.0.1788992674060;
        Wed, 09 Sep 2026 15:24:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e83d9cdsm244763a91.11.2026.09.09.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:24:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: sdhci-pxav3: avoid of_node
Date: Wed,  9 Sep 2026 15:24:32 -0700
Message-ID: <20260909222432.62847-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use device handlers instead of of_node ones for simplicity.

As this driver is effectively OF only, it ends up behaving the same.

Change is_bool to present as no-1-8-v is not specified as a bool in dts,
but as either present or not.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 181b4989c74d..f39764ffd4a0 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -123,7 +123,7 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
 static int armada_38x_quirks(struct platform_device *pdev,
 			     struct sdhci_host *host)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 	struct resource *res;
@@ -155,7 +155,7 @@ static int armada_38x_quirks(struct platform_device *pdev,
 	 * controller has different capabilities than the ones shown
 	 * in its registers
 	 */
-	if (of_property_read_bool(np, "no-1-8-v")) {
+	if (device_property_present(dev, "no-1-8-v")) {
 		host->caps &= ~SDHCI_CAN_VDD_180;
 		host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
 	} else {
@@ -364,14 +364,13 @@ MODULE_DEVICE_TABLE(of, sdhci_pxav3_of_match);
 static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 {
 	struct sdhci_pxa_platdata *pdata;
-	struct device_node *np = dev->of_node;
 	u32 clk_delay_cycles;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-	if (!of_property_read_u32(np, "mrvl,clk-delay-cycles",
+	if (!device_property_read_u32(dev, "mrvl,clk-delay-cycles",
 				  &clk_delay_cycles))
 		pdata->clk_delay_cycles = clk_delay_cycles;
 
@@ -402,7 +401,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = NULL;
 	struct sdhci_pxa *pxa = NULL;
 	const struct of_device_id *match;
@@ -433,7 +431,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
+	if (device_is_compatible(dev, "marvell,armada-380-sdhci")) {
 		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
 			goto err_mbus_win;
-- 
2.55.0


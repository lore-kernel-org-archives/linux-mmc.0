Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EE130E2E
	for <linux-mmc@vger.kernel.org>; Mon, 26 Feb 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983475; cv=none; b=QmjD1caGWtRUesP974mc2P8XdskV+yUl7tWPOLWdFnCvmvJwdIRQGxVe199QBeKZHVe/AyAdWMepw57mwUCVQ12dilH5AkDcjRovyP2q+0LsoM15NcjbsLerAhu0Fm5C9N8bSZp8ft4jCVPQQOpFrFbW1HZJLjF4+WJyNDIcjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983475; c=relaxed/simple;
	bh=ie89sVvbplEsqZ0131OZ4+yw637SSmyv+UFSLp8ibI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiOJSNeGn2GX3avw0Jmh8hg2SdUEwwaLutRNvHxYEZeMT71l5XRjeJKLxlQYJqaPMU6sPuMlqmzvgpEvwSpnS6fFNqPz1BnCH8AXm/z5GkmOD/BmQB2+knXJMDeSy8S7okaMWDP/VD5wS4itgK4ss0uY08tTUXH5ZtnBA2nVzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EbHd1cNx; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EbHd1cNx"
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id eifMrgtXR2yuveifMrNhV5; Mon, 26 Feb 2024 22:37:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708983464;
	bh=tmMG+U7Q36q6vKuwv+d+vvsnLJBFXkQVcXONSgONuqI=;
	h=From:To:Cc:Subject:Date;
	b=EbHd1cNxsqDB/7L7O3dFeESKpvfjpaziXl8cs2mYfQDbXQtoSYlkc22Wfa9TC+qde
	 VDI271L0tQe7rDZyDsTSjP+Ph2VjZW3/KXToNCR9LpfUmzBBqPQRvRoILYspKKuXDU
	 lh5HYbXGmnzqD36rGX30QVRAL9tGr5DjXJcVX0lVJfIjIbVOUJ1wCsbL0oMFiE9VUo
	 y02tan8z+AgeYwvAs7/0k0lKaaNb/YNXvzQJVIp7q9MtxC+0YzCpwkEWt8sia/ereP
	 krz6UXoVbwY5bZBaCYxESI0o4CSzfS1WfB5caVDfrNpGDRE16JnfY6DheVYoTiyPcQ
	 xdiytd6XxcL6g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 26 Feb 2024 22:37:44 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ulf.hansson@linaro.org,
	cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Mon, 26 Feb 2024 22:37:39 +0100
Message-ID: <bb0bb1ed1e18de55e8c0547625bde271e64b8c31.1708983064.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This looks strange to call release_mem_region() in a remove function
without any request_mem_region() in the probe or "struct resource"
somewhere.

So remove the corresponding code.

Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. Review with care.
Compile tested only.
---
 drivers/mmc/host/wmt-sdmmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 77d5f1d24489..860380931b6c 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -883,7 +883,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -911,9 +910,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
2.43.2


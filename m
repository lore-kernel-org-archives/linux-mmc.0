Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB181221FB6;
	Mon, 23 Feb 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854549; cv=none; b=VPJQbNQCSs7eCpxvbC7zrMHkMCz9qfGK+7IalEJsEVqQ13UubdExWaasKTkvEYTrfoI/g2a1aOO/sVgR24IqTeQf4BWfCktiKkWWQqOj5ou/LVz+BdVfOpwgynS5xgtnU3On+smhZgqr839jMZqydiikKp0x5XBu53OhYTyeTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854549; c=relaxed/simple;
	bh=XQIpyiWalgK1CCscpgGw5/wEQX0MCK/pI9+AfsGrk+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYl/cuExrUCUqcgApHe42rh7qBr0MMDZc7VaiF4n0TzA4TzfqDPOpC1o2lNoBAChgc9E5kVuGGTGQ7cEUFwIseiL2hIxiD1F9jj3OzncZT/BcZ8PuDeD590/5azXscC9aQH7pR95p38CBSUfMpaDZ68ljr4a1OcLwNmtY8q4W6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzfvDhtr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzfvDhtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1ABC116C6;
	Mon, 23 Feb 2026 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771854549;
	bh=XQIpyiWalgK1CCscpgGw5/wEQX0MCK/pI9+AfsGrk+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=rzfvDhtrrIM9qUauZk9UfyMh4/UYNjEBg9xtcUxPPiUNjUPTR4JebspEqWpnn/QmB
	 veSFUMWJXAgbEqZHZ7tEY+CP7nRCnSt3F0iVwEG7qKlN/BcIIashiYRpgJA/U7IcWH
	 Z3yajb0yoLumEGV0ptFI/1mUTWJ6iZ5lRKJXrIOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	stable <stable@kernel.org>
Subject: [PATCH] mmc: meson-gx: fix potential use-after-free on remove path.
Date: Mon, 23 Feb 2026 14:42:14 +0100
Message-ID: <2026022313-cling-pastime-4551@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=XQIpyiWalgK1CCscpgGw5/wEQX0MCK/pI9+AfsGrk+Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzIk1Xrzt7sO2pxe3dPjMmf44yFZFkuWUWy5xobXe6X tj1ZPeLjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIIWmG+TkP/Pf80ryybgqv 0snZ5256in0tdmdYcGJOV2Z6v8ErvYyoP+XBD/6yC3sqAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
on remove path"), we should wait until after we are finished writing to
the mmc host device before removing it, otherwise it could have been
already freed.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..9557f6816af3 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1297,13 +1297,13 @@ static void meson_mmc_remove(struct platform_device *pdev)
 {
 	struct meson_host *host = dev_get_drvdata(&pdev->dev);
 
-	mmc_remove_host(host->mmc);
-
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
 	free_irq(host->irq, host);
 
 	clk_disable_unprepare(host->mmc_clk);
+
+	mmc_remove_host(host->mmc);
 }
 
 static const struct meson_mmc_data meson_gx_data = {
-- 
2.53.0


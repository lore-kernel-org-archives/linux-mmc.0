Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAB3A6B77;
	Tue, 15 Sep 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483837; cv=none; b=JwEQjXzK/NJsS1i3geBCpD37WrmMIKXbGKKVJEnC7iyJG6OajbKIhh5SeaM94DZaXBD0wSjZzYg0S4wwB6PphcnZMFPRcsuQwjf6f2Bx/FR+Z3acjAxcSqbQJvwSFhjeF/ns4N6h/glZN1niBwjssbWdUZs9oxrMoBqhaFiwS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483837; c=relaxed/simple;
	bh=Cm86hzg9R5k9YsM28mSrIuU/1y3yycHJUjoNX5QCmt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YbLm24QCOXAktHBGR8SZpiiR+vpg46wGAh+r3uYbrTZQHtNBex5MAxkG4oLlhom03hYRN8YwfrozIkzwtZlPr2gwlZUgY+VOyuBhAP6lHfQxonkRnqdptSp+5Gdj3aFsCfLadBkrYrZacU94DlrzA3BFX8RcKMc6z6FrDCEpM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=aNpRNzug; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="aNpRNzug"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ddceb516;
	Tue, 15 Sep 2026 22:45:17 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mmc: mtk-sd: Cancel request timeout work on remove
Date: Tue, 15 Sep 2026 22:44:57 +0800
Message-Id: <20260915144457.3463325-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a58784d303a1kunmba030f482df7e3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUhCVhpDGh1OGk9PGEpNSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=aNpRNzug2J+Oby1DEhaCfVspXZ0Xn/5E3dmtrccGITa7FkRWINnlylH72aiPsejr1niVupMx2G0R0PdCRqKH4C3synpX9qDUM17WwgnzXEu1qDDuBCspJY/fdpEFdsoh8WqnJn2SqqnmPazbNcJDR8taNtnMCqQa5rAK6OF3AWo=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=rVWLpxXBv4SunQeUTF6bE13/RZkK32fGD8bxBOVZ3Qc=;
	h=date:mime-version:subject:message-id:from;

The driver queues req_timeout while a request is active.
msdc_request_done() uses cancel_delayed_work(), which does not wait for
a timeout callback that has already started.

The timeout callback calls mmc_request_done(), which wakes the request
waiter, and then continues to use host->dev_comp and check the SDIO IRQ.
During unbind, msdc_drv_remove() can return and the managed mmc_host can
be freed before the callback finishes.

KASAN reported use-after-free accesses in msdc_request_done() and
msdc_recheck_sdio_irq() in each of three unbind tests.  The same tests
completed without a kernel diagnostic after this change.

Call cancel_delayed_work_sync() after mmc_remove_host() has stopped new
requests and before the driver releases the host resources.

Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 01ea3adbdf3b..5b160fdad3f0 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3216,6 +3216,7 @@ static void msdc_drv_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(mmc);
+	cancel_delayed_work_sync(&host->req_timeout);
 	msdc_deinit_hw(host);
 	msdc_gate_clock(host);
 
-- 
2.39.5


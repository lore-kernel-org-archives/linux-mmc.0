Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CA202C5C;
	Mon, 23 Feb 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854523; cv=none; b=d45HLNLRF2yvmijQezPL+CpFmVM6+BXBxiaYAwrZNxusqjvlwgaLjuEWOreIe9Zy+LQ0yeiO2Kb6s9txtItDMOlfNOl9RQtngqM+ee09nGjXqfYzu4gJ0FrEfjfgzFikkl5gSanAcbhHafnNTr/3a+0lwRpdUjHTkzcxxBz7opY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854523; c=relaxed/simple;
	bh=uZnQdxAoai2HIQeNV9r3AZo3sqDz3K/2lTCdPkOWeRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrlOGLhGIFyRlKNnnGo4vearJH0d/+AUfQ/SaMOctkUUmQUkZigb/dRE/HyEFRWF2s+Ls+41NnyaSadmfOfJA2dr/0hEubKSkWRElZ7aW37zIykRbacWMzSZSH/t8TR3l7uRj5e9ZOvPA93HFBdeFtEg7+a5bwUT+Nm6QGHsBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aG5PfnS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aG5PfnS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB28BC116C6;
	Mon, 23 Feb 2026 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771854522;
	bh=uZnQdxAoai2HIQeNV9r3AZo3sqDz3K/2lTCdPkOWeRs=;
	h=From:To:Cc:Subject:Date:From;
	b=aG5PfnS6wjlW6eU+qTQOrc20f7W3d6CfOTb3m9R1ZAhr0TnpVZFq6sUwBNGcXmftQ
	 G3Y9njAOu58/vmgK3CV8SIubvh/j3VAIsJMveK1Xy+p+eSSURa9/U6tVOTjURbSPgN
	 xJInWH2NBgXVuRC5C2aIkiip2Z5RRZedjrxhyp+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	stable <stable@kernel.org>
Subject: [PATCH] mmc: moxart: fix potential use-after-free on remove path.
Date: Mon, 23 Feb 2026 14:41:52 +0100
Message-ID: <2026022351-badness-custody-28ad@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=uZnQdxAoai2HIQeNV9r3AZo3sqDz3K/2lTCdPkOWeRs=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzIuWFpaI43xWltZ144c71mGsS9ybTJ9andk9wPON38 t7T4l3hHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRJ80M89Q2mgm5GdU+3l+/ dJlktqoPv5SuPMM8HTE/u0cLio9sZTvr9PTBVc6VPKH1AA==
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
 drivers/mmc/host/moxart-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 3dd8f232052f..256e16390ef3 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -690,12 +690,12 @@ static void moxart_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
-	mmc_remove_host(mmc);
 
 	writel(0, host->base + REG_INTERRUPT_MASK);
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
+	mmc_remove_host(mmc);
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
-- 
2.53.0


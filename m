Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB82580F2
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397840; cv=none; b=vEA8PzTiRlXq3fo8OBUTEgCHkBPGK3/i+iJqBsWfcje8BeipJuL6QwS12KMW7ACxRGqGGEZBDE354ChKrImzmKVep7nKAltheyxJF6OY2OtvTCYJZgi0lQ190v+laahm7Y0igOX6hP81OAq78hbDQJfQWVmhObYQVPooNl7YfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397840; c=relaxed/simple;
	bh=y2YohVo2xG5rxr7FDwkWnORfvGqn+Vwgfjjm5ZCk7ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6H9LdUUlogBS0/Q2VPWA0uS6UfG+GWPFRqIoZR1L+FnOWx6jZskVl1CqEUTOtIRAE6BOBy7yFCQeLvCdgoHW5uSLKq/qS+QZUgsLfbhpKactgnS7AM8ykcjW0D3zViab38i9D9KH6H8pXhBMJZKNr2WmrnOJIR/EScAJzlwyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mJM2G45S; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mJM2G45S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766397836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k1EArML7p1XuJX9PSG7SXqrMlXb+YrX22CISKidRJ0w=;
	b=mJM2G45S2kKCUQ6Md94LPu67age2NJVxXISEfrEZxT9z6i8hhlzkXRRy522qRhEnXwbd/o
	RweM6CCcvP1rUfTPn+71wrsbCE8VkVlpPEdcNE68LST5SgdfH1C7Nqy1eqv82B3Fgin4KF
	VBBzo7IOp+7d9+XocN5BYsZ4n/fwNrU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: cavium: Use clamp to simplify cvm_mmc_set_clock
Date: Mon, 22 Dec 2025 11:03:33 +0100
Message-ID: <20251222100338.634144-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use clamp() to simplify cvm_mmc_set_clock() and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/mmc/host/cavium.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 9a55db0e657c..37a88f2a0c86 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -905,9 +905,7 @@ static void cvm_mmc_set_clock(struct cvm_mmc_slot *slot, unsigned int clock)
 {
 	struct mmc_host *mmc = slot->mmc;
 
-	clock = min(clock, mmc->f_max);
-	clock = max(clock, mmc->f_min);
-	slot->clock = clock;
+	slot->clock = clamp(clock, mmc->f_min, mmc->f_max);
 }
 
 static int cvm_mmc_init_lowlevel(struct cvm_mmc_slot *slot)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


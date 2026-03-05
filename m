Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73D11CAF
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713595; cv=none; b=jZ36X1C/merXdiPLps1XTJlrPYYif1+wUsNPXwMapq2Ddd3katOofRXL1rBXH13ZnsZFIwXNPUtcc2t4wYjbdU4/Ndvkh+mLVwB50f24kOurzONe4pHfKtsaoDfLoT3hGphG8MwR64V1a4binGBq2Q6eC2/uJAJkkZY9V0Z3Q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713595; c=relaxed/simple;
	bh=DcHGo3I+2RAJQl9/QLVB73b9w6oSaYRI0k3fIvbEBEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImRgPIXTp6E8zDnmCjl0QR8Kn3fP91DA+MX+3Zd+E/ks07bQRuIax0+Gg0WtUq7rpqpUCXXBp8XdWECuFurVA+F99DAx9R4K8dotHFSS0jmQikrRk/geSHMFo2QffW2nzaUAKzQyAypSVz07DsK5KgdIEF5KxAUI4pdCnsteCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPZIKMhr; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPZIKMhr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772713582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f89wghwW30vJm6WRQtoq9nrMSOaEbLm2bYNKUddM0Eo=;
	b=RPZIKMhrV5Wu0vHTymz7a3qoGTs3Uo6i3HWjb0Nz/inpGyCYIwnwpBNj74TTonsITlpM1X
	ktQTPVp8/mvuWaqLnLHSYdvbTIaay2lFAPYBCDfKXB/SsJ22aGhi07lejzxy/wNnX2ZwPk
	icY28cMsrwGVzJWHE4qGcYQNlgjKJhc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdio: Use min3() to simplify sdio_set_block_size()
Date: Thu,  5 Mar 2026 13:25:48 +0100
Message-ID: <20260305122553.249058-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min3() to simplify sdio_set_block_size().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/mmc/core/sdio_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index b774bf51981d..12716ec0e35d 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -163,10 +163,8 @@ int sdio_set_block_size(struct sdio_func *func, unsigned blksz)
 	if (blksz > func->card->host->max_blk_size)
 		return -EINVAL;
 
-	if (blksz == 0) {
-		blksz = min(func->max_blksize, func->card->host->max_blk_size);
-		blksz = min(blksz, 512u);
-	}
+	if (blksz == 0)
+		blksz = min3(func->max_blksize, func->card->host->max_blk_size, 512u);
 
 	ret = mmc_io_rw_direct(func->card, 1, 0,
 		SDIO_FBR_BASE(func->num) + SDIO_FBR_BLKSIZE,
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


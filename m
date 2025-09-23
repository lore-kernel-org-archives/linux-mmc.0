Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646E31CA6A
	for <linux-mmc@vger.kernel.org>; Tue, 23 Sep 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644365; cv=none; b=GftQteBN6EmxPE5vagbIHs/2z/TkZy+zIuFZnk5UpsBsPtliriRGdLQ4ooWmiuCE0W1ncORrMtxXfneDK4jG3ncwWNN5r8WoqN0lGkQiuFhdOf8z+rf7hbnrH9zVirweQ+ySFdScCqC9Z08tnQmkrxMyHOVk15C/f/uxrPW/BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644365; c=relaxed/simple;
	bh=VGysIx6ugPC1wKpK4qahCFYnp3Pqi+rhySd5kllItgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqOot03UmF92m35mxGsdRPMKQmWK79gdeCVj+MJl0tSiPCyMcuNFr6v3PCW9676oRGjReedOuIiPJhVt9djqltRPIaxYCZFfFCvMdfP9cjrM/xPYOIZEYO5eMR2rvmtReO8t1hfKZ/R8hqjltER25pVbF6NinPW5aawqrGApX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QfEfgZK8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QfEfgZK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=chZ0sj+mlqrXtm
	JOXE5Pl98r8hL1uFNFjTT+OIyFcMg=; b=QfEfgZK8Fe1aRUXZ75wXcfDkSBnItX
	lWhDrvrAEv4cf1BM7d+kr+fJIXGmDUPdlhm4CvofdguUUmr1dKKWuuWwUF+6jThq
	WHu50Ctt5la0w6xhbfWKB0FBSPWwRuzOjApBRuxXJqL2nmF9uotfClPGgoxVF0RY
	HaT7RB8o7WpCXOkZ4CpUU+Omc+RJ7rq+Il8g+IGhKrgrj/R8iSYY9Zq0ifPP+qZW
	iglf6r7Vm8kr1wTf7t+2nfeagotXEVpcMWr7Orw5w+Dsx5nN44I0ZeZPFs/KDmBt
	ieD3JezsK1c6OGeUFF+EMeK418R0eE0fKWhIJv9q5hmNuDMTGikyXE0g==
Received: (qmail 1173212 invoked from network); 23 Sep 2025 18:19:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Sep 2025 18:19:20 +0200
X-UD-Smtp-Session: l3s3148p1@u1RfTHo/LsIujnsp
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: renesas_sdhi: enable bigger data ports where available
Date: Tue, 23 Sep 2025 18:17:19 +0200
Message-ID: <20250923161915.3172-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen2 SoCs have a 32 bit dataport, V3M even 64 bit. Make use of
the bigger size in the rare case DMA is failing.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on a Renesas Lager board (Gen2) and Eagle + extension board
(V3M). SDHI driver was hacked to avoid DMA and use PIO.

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9e3ed0bcddd6..73c84fd8a2d8 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -124,7 +124,8 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
-			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 822a310c9bba..543ad1d0ed1c 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -60,7 +60,8 @@ static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
 
 static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
-			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_32BIT_DATA_PORT,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
-- 
2.47.2


Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266A3FF1A5
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763602; cv=none; b=LfhZBxc1/acbzyb/hciNlujd0AX342olslLLJOdB2FuxGI7sWjoOjeHhzn2BpCWZcC/yI8J5/JRlfKIRfpitF8Rkzf5hf7rrdnlL6iw5QayN4oortLM7YKHiX2WwrZvw2doRQ92Ku3ooNj/zarJkQzVH1WRHrM6Wc9D9kw2U5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763602; c=relaxed/simple;
	bh=a1FgZIJL9r7HJKSoF3sI7X0CpF9ived6+Iq8iJsTZK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUg40mA7How+91OaXEv93q/0jYl589BqsMpn4DnmMvm8F0PHmSNIEDTXQBZTrdj50DL+IlGRFhgtiNmFE6GD/a6V0X/7KqSZuHhvXSI2u9OJlKOVD9tyGIPLtGEx5jk3N1pQnNxoGwOm8lij+b7sAUuh6odjpgLnQzIl0qr78uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJpbRPnn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJpbRPnn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so4257324a91.1
        for <linux-mmc@vger.kernel.org>; Sun, 06 Sep 2026 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763600; x=1789368400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PloKXYxQeao5LyBqd6CNUwy0u74eRsiezTlXOqTheC8=;
        b=JJpbRPnnZCJmNtSN1GS7zzUJk0MQTzcMm/u4fvg96A4FWWNHfq9w5bd/8zzoegnmNJ
         gP+EU122ax6AMhjkcNuolScDSFwtP+jUyTepjR92Y6x7jtSQxxIys12JV/i6jAZ/bpp/
         zhkYk9/Bg9XvCYQ7IwldspSGqK+V8sYfwyIUUPYnUpT7uXY/r9Zwpguj0wXECenSEk5u
         cufuNsLgQf18Sn6f/T3i4k+LkwXPaQzuZH9p8nmIaEii5hrk6RwexqUx0WO8mFWF8i9B
         2oqmjAGc6duyU1ApZexfp22jqakAuJR37/yXbFYUCJxoH/GHeYZyjwue4yupyPHXM2ZH
         uchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763600; x=1789368400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PloKXYxQeao5LyBqd6CNUwy0u74eRsiezTlXOqTheC8=;
        b=rWXlVEKImFqhyZOgENfoMbakof5XbmnFUrPPRri6ihkdW4mldc6/iC5K7umSpHrMA5
         CMmMR5Sg7dfa+UQtmw4WYyite2IfF34JBV+cEUBo15DC5lNMCT87qFpJ7PJ3d35TLCfc
         O1x80UGRQ1mLLm1dBLiynw135JSAwOTkv3DJGxueQEbYvloGl/HjtBBBGTrG+ys4cji7
         OkKrI5QmE51jDNjo9CSDaXu8WtONc+K30InoVxB4AkSP4jz9Ii3j54foBiBOCRf/vf1M
         iIYfMT+QWcIvmwv5c9jFg9cDyx5FbIWoruTeAGPE2vXU2Wj9uFE4a1GZAkgBW2i6aD7v
         LmgA==
X-Gm-Message-State: AFuF++kWHY3q6ySSVlJFxsgntDO/P+yTvUkjS4WTCwMhOgte2+RzXps5
	8rShp412jBjF1dlIECAHDDAEISYrwkZJHVFh2E8l4/PFwjtEwdyxFR1X
X-Gm-Gg: AYBFou1BpKpbaul3HNE4RhtIxV76j3KLy8KEFN41jAhlC3IVlvId761jLA49VwbvPHK
	5zze2SV6rPRJKBct2aHU2yUr0SUjmJPDGXeFtvq5u+EX1d6o6q45EtNUamezGsR5doHcCnGXFx1
	vSGXPU/Vp25nK/EYlpjBShPZPrebiZdzS0rbPm3BbJQKHKLQWNJ1gp4uPf847MitK/vQTXzyz4+
	MbUFphzFRWdke32XJoZ23AI6d7IFXVVCMvE3wq7Pg3dE0mcdpQ3EIntC/MKqlTyH5NMriL2GXt1
	IAz8Im/rBKoXaaPkmW1gogD0u8JCmb9PyahQnFLU4f6BOmh0GA+PvUUpBLtDeyWUf82Z2gM7Dzv
	OaPZh7rKt6ucvqNuEiGBk0iTIJCdb5g9UbqD0Eyd0At2pvAcTOl/trwdxGEZsyzdlYpZC9in/Jc
	kfA9YAChazEm0fQL8HJ+3wfMV6lgxWprwn+M86V7xZofL5Cw9WDBqjAUde246xqN1qSeOSnc3Zd
	JZv3+yIkMtT4Q==
X-Received: by 2002:a17:90b:57cd:b0:398:c150:e7b3 with SMTP id 98e67ed59e1d1-39b2609f356mr34710524a91.4.1788763600149;
        Sun, 06 Sep 2026 23:46:40 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm25401130eec.19.2026.09.06.23.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:46:39 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] mmc: fix typos in comments
Date: Mon,  7 Sep 2026 12:16:32 +0530
Message-ID: <20260907064632.8926-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/memstick/core/ms_block.c  | 2 +-
 drivers/memstick/host/r592.c      | 2 +-
 drivers/mmc/core/block.c          | 2 +-
 drivers/mmc/core/core.c           | 2 +-
 drivers/mmc/core/mmc.c            | 2 +-
 drivers/mmc/host/bcm2835.c        | 2 +-
 drivers/mmc/host/dw_mmc.h         | 2 +-
 drivers/mmc/host/mvsdio.c         | 2 +-
 drivers/mmc/host/sdhci-msm.c      | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
 drivers/mmc/host/sdhci-omap.c     | 2 +-
 drivers/mmc/host/sdhci.h          | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ce33907bfc24..e2bf563ccbe1 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -720,7 +720,7 @@ static int h_msb_parallel_switch(struct memstick_dev *card,
 
 static int msb_switch_to_parallel(struct msb_data *msb);
 
-/* Reset the card, to guard against hw errors beeing treated as bad blocks */
+/* Reset the card, to guard against hw errors being treated as bad blocks */
 static int msb_reset(struct msb_data *msb, bool full)
 {
 
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 605b2265536f..dc3de63901be 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -289,7 +289,7 @@ static int r592_transfer_fifo_dma(struct r592_device *dev)
 	dev->dma_error = 0;
 	reinit_completion(&dev->dma_done);
 
-	/* TODO: hidden assumption about nenth beeing always 1 */
+	/* TODO: hidden assumption about nenth being always 1 */
 	sg_count = dma_map_sg(&dev->pci_dev->dev, &dev->req->sg, 1, is_write ?
 			      DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e760d13ee325..a02bb2fee874 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -86,7 +86,7 @@ MODULE_ALIAS("mmc:block");
 static DEFINE_MUTEX(block_mutex);
 
 /*
- * The defaults come from config options but can be overriden by module
+ * The defaults come from config options but can be overridden by module
  * or bootarg options.
  */
 static int perdev_minors = CONFIG_MMC_BLOCK_MINORS;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 29e80e5f928e..08d41f0996de 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2004,7 +2004,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 
 	/*
 	 * Without erase_group_def set, MMC erase timeout depends on clock
-	 * frequence which can change.  In that case, the best choice is
+	 * frequency which can change.  In that case, the best choice is
 	 * just the preferred erase size.
 	 */
 	if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..a02b04938e1a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1015,7 +1015,7 @@ static void mmc_set_bus_speed(struct mmc_card *card)
 }
 
 /*
- * Select the bus width amoung 4-bit and 8-bit(SDR).
+ * Select the bus width among 4-bit and 8-bit(SDR).
  * If the bus width is changed successfully, return the selected width value.
  * Zero is returned instead of error value if the wide width is not supported.
  */
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index c949a3eaae79..efd1903c3ccd 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1095,7 +1095,7 @@ static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
 	int div;
 
 	/* The SDCDIV register has 11 bits, and holds (div - 2).  But
-	 * in data mode the max is 50MHz wihout a minimum, and only
+	 * in data mode the max is 50MHz without a minimum, and only
 	 * the bottom 3 bits are used. Since the switch over is
 	 * automatic (unless we have marked the card as slow...),
 	 * chosen values have to make sense in both modes.  Ident mode
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 38610c89d54a..d500a419e2cf 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -69,7 +69,7 @@ struct dw_mci_dma_slave {
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
  *	transfer is in progress.
- * @stop_abort: The command currently prepared for stoping transfer.
+ * @stop_abort: The command currently prepared for stopping transfer.
  * @prev_blksz: The former transfer blksz record.
  * @timing: Record of current ios timing.
  * @use_dma: Which DMA channel is in use for the current transfer, zero
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index cf705b265e21..7d86426c6001 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -717,7 +717,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	/*
 	 * Some non-DT platforms do not pass a clock, and the clock
 	 * frequency is passed through platform_data. On DT platforms,
-	 * a clock must always be passed, even if there is no gatable
+	 * a clock must always be passed, even if there is no gateable
 	 * clock associated to the SDIO interface (it can simply be a
 	 * fixed rate clock).
 	 */
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4aff965f0e2e..b229545d9db5 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1770,7 +1770,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 
 	/*
 	 * The driver has to acknowledge the interrupt, switch voltages and
-	 * report back if it succeded or not to this register. The voltage
+	 * report back if it succeeded or not to this register. The voltage
 	 * switches are handled by the sdhci core, so just report success.
 	 */
 	msm_host_writel(msm_host, irq_ack, host,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8345e2c5a034..1ca3562d8f73 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1381,7 +1381,7 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	if (!IS_ERR(clk)) {
 		/*
 		 * esdhc->peripheral_clock would be assigned with a value
-		 * which is eSDHC base clock when use periperal clock.
+		 * which is eSDHC base clock when use peripheral clock.
 		 * For some platforms, the clock value got by common clk
 		 * API is peripheral clock while the eSDHC base clock is
 		 * 1/2 peripheral clock.
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b5d7c1a80a92..7a198fb26628 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -332,7 +332,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 reg;
 	int i;
 
-	/* clock tuning is not needed for upto 52MHz */
+	/* clock tuning is not needed for up to 52MHz */
 	if (ios->clock <= 52000000)
 		return 0;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f0fd81409a86..98c1fe20bfcd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -409,7 +409,7 @@ struct sdhci_adma2_64_desc {
 #define SDHCI_MAX_MRQS		2
 
 /*
- * 48bit command and 136 bit response in 100KHz clock could take upto 2.48ms.
+ * 48bit command and 136 bit response in 100KHz clock could take up to 2.48ms.
  * However since the start time of the command, the time between
  * command and response, and the time between response and start of data is
  * not known, set the command transfer time to 10ms.
-- 
2.48.1


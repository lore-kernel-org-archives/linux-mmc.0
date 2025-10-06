Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F951A9F80
	for <linux-mmc@vger.kernel.org>; Mon,  6 Oct 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714638; cv=none; b=mEGoZZJqn7sGjfWDnxMX3hHNILygEaWuHgRNY26fyJiiALDm1pZyxsfxfkO2k77PlWaDe1nL7xzl9NMUAiZVcL4pvUthbMSdjhVDR+xjTQXWrZUDAGf77nhztq/somvylSbslmynhZebyjsOuzbjWjlBWV54e+/W5g49c2p10bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714638; c=relaxed/simple;
	bh=GRTGrbwgFIMEKSOGptza56zcnrQrNjH9SVx9qxSAgc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd7vJjO26CKBqRXbDWxPvA56mWmTlc+ByMh1d86qo55gvuPGR8dm/CmOblpSiRwmrgfEDiT/LQ4Pd7vHClbjysZttxj/FK05IeqrgArW2gH3OdfgIdwMWbl6LFinv8j2rFxe5NIbRWUwF9AkuFeNbcGTGgsEXn2pgKH3kdz3bTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+sihUpy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+sihUpy"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3663f93fe9fso1134994fac.0
        for <linux-mmc@vger.kernel.org>; Sun, 05 Oct 2025 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759714635; x=1760319435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jclu3maYOklASHNOnt8Z9YAS2jjGe8UQUvAIJYmQr3U=;
        b=c+sihUpyy/cIIuUVEay5duS8A/djfIj47kViF9DoDrFy46i2yVlBjdZpq/gyGspNh4
         kdlqxE+FhRIPS1V7qSEf8EQN/ge9LCD1f2+ZLs6sFzF69mro5SZvD/LZod+cERfaR/0i
         4aKupw1RUkTWF+/ep4QEkvzxj3eKj8PbaUNCAzgFWj9Owh1cgLW0PsfSeUkD5MkwSgIZ
         pfgOkR1bKCy8x6O+xJNYfPGBjdZA9kp2tlDALbA69msh4GBBfqJommb/5fcgD34rJDwp
         39LV4V8bwe1EViDDMAhnRFiHumvm3WnvGMWnPGD774Xj/wbw7Bd0kKAj5yqmRUClOlaz
         99CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759714635; x=1760319435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jclu3maYOklASHNOnt8Z9YAS2jjGe8UQUvAIJYmQr3U=;
        b=OvfaJK+kmA0YF9JcrsA2FlzxqXAgbpBb/YHCAJXH3ALE6e1Dqv/AK/hla4CmtwRETP
         PnRcjB7r3+dgjjj/BfIXJHgzViHi5CAqw45MueOWDWRxgpwph+ZxA04YW2RxhHp6IaZB
         FMNEQ1xd5tD02kXANwg33ABBDfA02FWBsl2WUtlpb+Z8E2bivUrxz54HiDTOPytAOlIh
         Bha1PWiWgPg4nm+ETsks4ca9/SOeV3DyD+2AgmUISMfBRB+IE0/zsG/N09PxjcuCGcDQ
         jOwLio362bWLiKx4vJLBeMNOO8GEBsNB2uD1ZeObGl9ENpOEoNcRI2BlgUy5VIulabX6
         Kn7g==
X-Gm-Message-State: AOJu0Yx4+eSTOeq5tMJpu5Lh730ai49g8Z0ziymXtZR8dKlnRyyFw2md
	IHxcZW6VXPpOL0I2PSFX1qZ3CxDhW+9bmI2e/PaweRMAkHAKApKJDR78
X-Gm-Gg: ASbGnctTGJMlCPA6evXIsfi0/dRKVkvbO4/NxZMy6ddygnM7Yuo5IFpGt0+IaJ2PKMH
	za02n1+S8TtSgrLqmfSE6J1oUOcrsPjLlTHk1j8OKdz92WkkH+4Ff7ymxHwI+vlVCoZMYrJDgVl
	Bc6QPqx32k7FSZLqiPancr2ZW2mgpEiQEG2sCjpVzTUDF1mFjrUuUw/VCkQ2xcEGyYwY+UMYzAl
	rJ2ew5U5KhiKSmqqMYQBDgScVW8hwGvfcdswjoQtfJA83jm415i3C4htF7rPu0wp8nzimw+Ljx5
	+0XGnBNVe3Gda000IDgam0/A/ib1s1hRGIamZ/37buCNKaD93oXUQsECFKLumDi16OfMxvZztdE
	Glm/FKnr5ZjFAkBrpZctkEw2Bi5CfgkOR7eZzuvMddLqT71KhWU6z2N7GL0Pz4PcOJ6Ki2/KBLN
	EWDU0pluqQZvSTuOezTg==
X-Google-Smtp-Source: AGHT+IEBfpGl84oMNJFoLvA++lzw6nRFdCzoMSkxcmbMpcXadC2la9fvKvaHz34EjzftFKGO50+50g==
X-Received: by 2002:a05:6830:63ca:b0:7a6:f44d:6dab with SMTP id 46e09a7af769-7bf775302eamr3266418a34.4.1759714635591;
        Sun, 05 Oct 2025 18:37:15 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcfb69sm3462870a34.13.2025.10.05.18.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 18:37:14 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Garofalo <officialTechflashYT@gmail.com>
Subject: [PATCH 1/2] mmc: sdhci: add quirk to disable the bounce buffer
Date: Sun,  5 Oct 2025 18:36:59 -0700
Message-ID: <20251006013700.2272166-2-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
References: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some controllers, using a bounce buffer can have negative effects.
For example, on the SDHCI controller in the Nintendo Wii's "Hollywood"
chipset, using bounce buffers causes the internal Broadcom 4318 Wi-Fi to
fail on most data transfers.  The SDHCI core already supports running
without bounce buffers, so this exposes a quirk to forcibly disable them
for a given controller.

Signed-off-by: Michael Garofalo <officialTechflashYT@gmail.com>
---
 drivers/mmc/host/sdhci.c | 8 +++++---
 drivers/mmc/host/sdhci.h | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af7..7bf531802057 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4806,9 +4806,11 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
-	if (mmc->max_segs == 1)
-		/* This may alter mmc->*_blk_* parameters */
-		sdhci_allocate_bounce_buffer(host);
+	if (!(host->quirks2 & SDHCI_QUIRK2_NO_BOUNCE_BUFFER)) {
+		if (mmc->max_segs == 1)
+			/* This may alter mmc->*_blk_* parameters */
+			sdhci_allocate_bounce_buffer(host);
+	}
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 58fcbeaf281e..9a082add96db 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -536,6 +536,10 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 /* Issue CMD and DATA reset together */
 #define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
+/*
+ * Bounce buffers cannot work, don't use them.
+ */
+#define SDHCI_QUIRK2_NO_BOUNCE_BUFFER			(1<<20)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.51.0


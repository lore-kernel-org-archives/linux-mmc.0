Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646623FA5FE
	for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599274; cv=none; b=kq59u6CRf4IfGepMXKtik+IEARITKACuP9lxMrUesLCcmDR1J2IqrNS04rKfSRrevIywxaBJoUdNsSJylyeI24gbrR8MJilwPFmRrCIRDUGyBcVygawYxSAI5Im3G53vWKlfsQ1xgayCZIs0RI4X/3aFr9Q+DQ9g6BLiejH2RUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599274; c=relaxed/simple;
	bh=NLgdqVpvj8F7Pc9lFCCGOBeSdXFVDC7SLYvEkF+P6DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUsqc4wbqgFX1BHE+7kv+Sqbj26A0sucjq/aZt0DuIk/M0fFGoEInzuMyBabVI/y318qi2LG1u8eWP/ZuBFW58p4Kbd+aUte3cr/UBL3u5fxL2In49rJXFjliZJz8ZosRASqVduK9wkjUnvdGNjHvDRm+TryJM7yxsHRcKao74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdpp+R5p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdpp+R5p"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so551025a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 22:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786599269; x=1787204069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xzFkArDiYUJVrphFijlWZtDKj/k87XskzGvkdFKreQ=;
        b=fdpp+R5pOdizxM/gpWSXoFzMol+JHK25dXtq9Pvbff/y9bSwm6Jhle5vYUqdvENkAa
         ciOKFBmQ39yY0Cu35hrCJl1TAVRTQlCL++rq96pbpNravcV2AC6dL1RyWFKFklo35GIc
         SViRvMkUoZdhISEWZO4NDlzd+dbVQCo7LRGJrnSQDGGE/vCAWxUZPZmXE0P/JDk/9Ikc
         hIReSxJeu9faoov/jwRc48EPBbRZXlzI9iGPOYi0aTvJmsnVgCACZWkRPSiy5xRCJql0
         0zq9fNRRQcfPo+/ES7v9pJ4TSUfOMf2qxUEecC3tySp70R+p4OB/dqzBlxeGWrNtTuN5
         XQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599269; x=1787204069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6xzFkArDiYUJVrphFijlWZtDKj/k87XskzGvkdFKreQ=;
        b=bVNBVeq+bB1lP11zUMguCNvTtxt5BblOyupvSjSDvOJQ4J0NioqbMwbWskgNNk1NW/
         D6f15fW6pKYVb8YEDdMOIHvsrOLaSUC8JnG2zIgtFtfpaoBasQG+w8XYPXHUIRv+n9qc
         v5tKGUX6rqfd/pZ8f7/UNNs93PVUgt45oIbwHRxfKs/1ntdrW6C8KPaZDH27IroBY4pj
         NuapjJuzYlXNhNqP++ZEbwaPw3pjsI53rbry0TF2MFoKgmNajYvSLdab0bBCJJxH3ZkZ
         vqaBR4wQIMEOifWjQO+jVngwi4md2H9S8MzM5oFwHMU81NhLeGA6fxoSw9ylUyr7wn9O
         v3Qw==
X-Forwarded-Encrypted: i=1; AHgh+Ro04LV33gZBbUQRufWwax6rX1FxoJrafk2kZIpqOavIX3Wc7SUhw3DONsgA6v8FJuAAcmRSLVpxPuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/nwZRWcQVArXFpr8VWCb5Ok1qPWybDE37dZrATU4z9hS32XO
	06jABMsFEUpsvRnrT9HwstGlC3pDGp19rkSdEZz6pj9K8HX2jQuGPS9vLAZIJw==
X-Gm-Gg: AR+sD11MiKaoxLgBnPFqRSQidJNIBohhZhJECsObINJMM5HgO/iVYIFZMZS1FI/YlKP
	dha600qwG8YdJzx+aR107YXv7Z437YTrIH3pNVWQSvQg/EqF3qv9SBip7kJvy37+Y24K+9pB2zf
	zfre9oAc0VlpPGrTRlgrRQUjve75djQMhdIsxMuu5TNh5Z/YNTUR/co6xqjluI0hO3Q8kYVIicZ
	x22FPTNcNO+GNdtN9EzBBCxs7uRFNt7EoMCZL5pJIAcyqWQx3uN0DkMu3Fj4nv7SYcO6Vgrp+L1
	yALI+i0TqWXqxceMaYBw3nfCprtEj3BZKY4TRDRlNVKgEomY4WXaQqBR7TeZ9q3CCegK/kLh9fy
	i3K1T0HKfhZWJKsIM3ss5qNGTyiNyqOHhgQNmzkpzfnoKPke92rCotgTZ2pAFarHXdfZUrF/E6P
	0LP85ialYd/dXtuZ2xPlV2rnDxhE88LmQXfOwzof1TNK2diTP+TsKe4Qbrrcbk54lTNm+uCMO9u
	dikp0gHslBWrxC2DA/Eqe+2mWVaqg5CGk70+ao7Iw80cUy9VEqVmqE1bSSRWkTiibktPnaKjm81
	GcOlnoCOn3c9/xYg5NFKXx4lIs0=
X-Received: by 2002:a17:90b:4990:b0:38e:b3fd:d584 with SMTP id 98e67ed59e1d1-3931f94365cmr1262125a91.15.1786599268892;
        Wed, 12 Aug 2026 22:34:28 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm594734a91.0.2026.08.12.22.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:34:28 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 2/3] mmc: davinci: Handle errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 12:34:03 +0700
Message-ID: <20260813053404.21553-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813053404.21553-1-phucduc.bui@gmail.com>
References: <20260813053404.21553-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
and -EINVAL, should be propagated so that the caller can handle them
appropriately.

However, the driver currently stores the return value directly in
host->sdio_irq and continues probing.

Propagate negative errors other than -ENXIO.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Use parse_fail for proper cleanup on IRQ lookup errors.
 - Keep the value returned by platform_get_irq_optional() 
   in host->sdio_irq, since it is already checked 
   before calling devm_request_irq().

 drivers/mmc/host/davinci_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index cdb9fa94b56d..773577a10512 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1249,6 +1249,10 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	host->use_dma = use_dma;
 	host->mmc_irq = irq;
 	host->sdio_irq = platform_get_irq_optional(pdev, 1);
+	if (host->sdio_irq < 0 && host->sdio_irq != -ENXIO) {
+		ret = host->sdio_irq;
+		goto parse_fail;
+	}
 
 	if (host->use_dma) {
 		ret = davinci_acquire_dma_channels(host);
-- 
2.43.0


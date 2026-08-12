Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79878437112
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533658; cv=none; b=ofZVLpSlhfgsoUMyhUvuVxlfx6Zh61UU8RaubUK2e6tNO59CJfPasHVygIfoQhBFM57qoYoUKdxZf2e3Zl/rMpajgywMo0j+GnTYYqu2iJV3sp6GkvfogPhN4bhFt293nG/8kAprVIgxCgx0gX62FAd2TgKe+84UztDH9xgl4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533658; c=relaxed/simple;
	bh=UcFLOmXzIP0Dx04MjRqGimlzwiQeIWcaZfmLVU3HySc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhtqxNSVlsXuGPNmFwnj8PJ9s9pn/i8LdeskAQ0Y1voTco+AtuPThc6m7DC7puFNzBeEhyUs/nLaQSXQ17aj7d+858uu0lwMU6QOm2wKwLczPTDUZtBj8rmYyET/+4L8xoBoiHvXXlVgZJ254e1MamQPsi9+jH+235KeBuOwELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTKnLAn/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTKnLAn/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso8407485ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533655; x=1787138455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbzzHBH8DpqZehMLNcK23Xh4Yld6J3JsAmwo9QAsqAM=;
        b=LTKnLAn/UPQ5oiotFHAdF0PFcP1oQSB5lZImOWgvx+Hpy25tKcwt9s3bgscVeJ0G4M
         mfTQiWEM6hEa0n5FuYR+ZSwCsSOwZ+tSLTcrVAtvvJB//eCe+vqpjyNKxtUIpkZwY8OW
         N9h2b4bVM4EI01DK0L9ZWLVhs3svplkMKbyWD7Rs5C0JFZK1L6wXGzfsydjSFFQMks5t
         EnpAPqMbwzQ3q6yDDsQQVin1BY1q78NaAmv7DUW+U/XmYdSFRNT1U5p0YJ2SiadfWytL
         e3cRRQPvwOYr8TVf2xAydEoc2iGbLyJgVj8jvy6LOklDo8fSxk6EgXetkUUqPxBQGvbI
         c0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533655; x=1787138455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CbzzHBH8DpqZehMLNcK23Xh4Yld6J3JsAmwo9QAsqAM=;
        b=E819GogHffmsypvvKmAn/C5XwxS3WiEIzHmV8PhEHYR4dbE/uiYVRRr06dH/+0hA95
         7fJPNOeJr2D5npQpAkZG/upp8LCk78lilv43X4uznxKLTAeodDeMA+H96mhmXIlq38KT
         EUTCgEsURVVWoCoAxe/TqcGGXwqoClGqxNpALRS6HqqFtVMS+a1LOm5ibrfFtHBhuNrX
         mgtKv1vFuGjHL5wefsMGL+K+TmQRNPOHRkdDaMsOu/qFuPVBV/DS5If7hMMOep23yNVs
         HMJVBV6uwmZzHryDzlvN/QQ3WWKg8GfPlR6jEcG8LOqbTkjmhs4O5qaJbTNYsIKQtXs/
         3fmg==
X-Forwarded-Encrypted: i=1; AHgh+RqGCpPyOehZYiCdnzNbwXy9fzsoqb26MR9aXFZqdkyr9ZzMrBHnE1lB+2f0fTVBw6IitiMsKtjUuMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFjVw0pc12upzaw6J9tvR/LQJQ/rjjg3Q6TSdwSeDFFQ+MtA2
	pGcxP2i+WLBpzce5zcoYPebtfttt/k6wBv8j+XHLEuKu7NwOjMvvmbhY
X-Gm-Gg: AR+sD10lk7KAfRG3nvs57LuI02xelccioWaw7sCaBq13yVIiwDydgYoR8q52Y8K7Eq1
	OcCFQevd9a79jZ6oerPodbB3hPQ+D4xXwwsxnbNtxeSTAmYZG6Dl8piR+522Jy7XMdQ1VP24NE0
	rJemT+gitxz4y5voMzhZUKY3i1nkStoJYC/eu+guOnxTPprhTmAsIjX9ZP9P/izfNn7N9LyOqqs
	jvoqO1bjUcvqYBpBV4B56cLOE/944rH/+XpdmF4l2cvM0eOkksuLVEWTDgf1tyQFWRwcYIt0LIw
	hmPvYKMTgsCzkBhAmU8weN0VKl2koYj3ORRN9D+w4jBdFPGCiAVrqcaZqp1e6LrbJfHrfAlWsvA
	YTYJ5FQS46aN7GPBb5lmylsMfvItOZnDk+cj1P9Nxaf2CSlXnwFG37rfntD54NgGxjFIN0x3mGf
	swWVWmturmUBnETl1H2K8K3UNRNaTnyN1Rs9hkVhJSMiLkY0ZQGpz12FTzfZAJVwSj/iK/KY3uJ
	6PLhVi/dKQtgQJ0CAm51xZHsr03dfWib1q/pij+GSiKg729eSf8qHxhpj0ZaAilSjIDMB8iRUcz
	wSWP
X-Received: by 2002:a17:90b:1dca:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-3930123d0c3mr4872172a91.1.1786533654838;
        Wed, 12 Aug 2026 04:20:54 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f5ecsm3193765a91.5.2026.08.12.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:20:54 -0700 (PDT)
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
Subject: [PATCH 2/3] mmc: davinci: Handle errors from optional IRQ lookup
Date: Wed, 12 Aug 2026 18:20:22 +0700
Message-ID: <20260812112023.42254-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812112023.42254-1-phucduc.bui@gmail.com>
References: <20260812112023.42254-1-phucduc.bui@gmail.com>
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

Propagate negative errors other than -ENXIO, and only assign the IRQ to
host->sdio_irq when a valid IRQ number is returned.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index cdb9fa94b56d..4765d2dee599 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1248,7 +1248,11 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	host->use_dma = use_dma;
 	host->mmc_irq = irq;
-	host->sdio_irq = platform_get_irq_optional(pdev, 1);
+	ret = platform_get_irq_optional(pdev, 1);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
+	if (ret > 0)
+		host->sdio_irq = ret;
 
 	if (host->use_dma) {
 		ret = davinci_acquire_dma_channels(host);
-- 
2.43.0


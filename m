Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592273F58C9
	for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599269; cv=none; b=lvey3nxyQvsnZ78pdISmBchT+1l6/1x3jb4ErHljHaNPOOwZf1Im98yF/I5BVl9EZOB2ELDP0ZjH+lQF5qHH80uoiy8/xwvuXs/cy8VlwGFTmd2fIpmBko/u3N3xXsugyEnYG8hB3ucekarYw6W0pJyy8MgPOgNJS81zluqPlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599269; c=relaxed/simple;
	bh=Mhj3jWYbiVdYMnI3fvWRvTxrfRl3RdIu2H/JxIENP4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn2kn0NEqyZbuTyM+9MOwplOshXpNVpTIswX5qXQ+okKU6eQKQheiH16HEArb9s6MJjGMNp3HZ3Hq/8O8d2ynFP5amv9TBDC0A0H8R9unZgUMpaIkoBuqjwk/igjxTiVMFOS5kVdRYcsCWgvtd1Pcr2sAuyyZM3kvniFrvhv86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUPuLKOD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUPuLKOD"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so2414000a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786599265; x=1787204065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sg48OebW8O5DYM3I5rKP0/NygxmXw5dDjKnd0RIjz50=;
        b=BUPuLKODAaPmgjLsr7zfA8+I8jTgKDiqW9sS+gl1leplmc6MFmiIg2lew2BBTKRmOC
         iaUOtRNyrJaHfUL2oiVdJ5oSngJT5HYaS+Ey2jPvzWozH3415Ui6ViGhevEzlV3hnLY6
         SVoeyya3HXarsFJJjo1bMr/8iYSyg2t7AacAn+EmZkv+3HDRoAMX5hbzSmigC1vCR4Dx
         xyVpr2VmYHhKy+RCLbmsAgFre5c4rKgA+VaoCFLRkjPbotggvKoSxRlEXQv37jLzve9u
         8giV6Zi/fuUVfgOAlSuEqPANMH/K9WfhM+l8c9uhcZ4ksJwBiZ8h2NEmRVeaAe3vb3V+
         1nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599265; x=1787204065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sg48OebW8O5DYM3I5rKP0/NygxmXw5dDjKnd0RIjz50=;
        b=OWUAtPMJovqAjueyTaUz19pL52zv65HvHHO1qNm1SVIH3KKjn1Fa8zWPeW69DCx+md
         syERPwcYPLtdR04ObePytW8s+c1ohE4tMGUgB//h8bKCiytZGMPnYmT2+lr/GGaDErSO
         16gPktoCrRAnzeUSKMhUgaWIgmocUYYOgziApsC3+OsSjl+ifTUsVsbEtsxrUflexACo
         egsnCqCP4Xeq5hNNAR+lesum8BOl262o2Qpz5inA9hihGuR6DDAFKqXWdRni3TNpUAkh
         UqLbvEm0Qe/bVhovxlQBHrbyXTUHMMlLCiumy7StBH78wuxirAkbC+ElDV/Bl4jZvKWj
         UWfg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6FN9TcdywOxHJ9Dj5jvwSZTKW+qe8CmQB+XDA0e8af0Q7Uy/EtoQUQw7XAORLChcUHFdCh1EjU4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlP0fb9zoQSf1PlHwjfHr6bdsUtvfMJl343WlSsAmS4ug9lGM4
	tcYsC70Q7CNnqZVZmDXIF3ss+J50VVCvP/eOVGwroOmA3exKrqPMkZ90
X-Gm-Gg: AR+sD10sVgsbl9KSTwsLft3odSWEIuhYIqoJZvrvo/ZUOO1Fbe6qEa/Th0TlEfA9XNT
	eSqp4ip3N8Z/pIvWTOVMgN6WJ58FiIx+orthHdacwoxb8TzMoIFUrKtGFtK4SEFlylnWevV7I17
	r1yg7Q5ueiJ3UjWT2UMF5mfqAvIws793somFWRtdlLZSB2NUNsex9SuxbJxFSsl7pT+Z4N1RokC
	q/ptx95FdfrReEC7+AQOs9T1XmLSdxVtTU41eORHBFZ9S1LEHm18Ifs5Xfe+uIkvpFN1OHvkoc4
	CCeiU+sdYbLo2vyRNEHPxqkcUOzAO167mP7znKiNXnEIq8qcZWZPj2bgC8ekU6vMn+J3oihUr4U
	XuwTM5zNDRiKhzB0MKhjbM7bsLL9lTxF5a1q0Uv6p2P96EHLfBxQ+Avm9zVyhr8G3IFtFfHPH3T
	ZuYP4Z01VVUoTBUIuGa3UNoIo+TS5k3IlgNOlqLwjJdpJiKNQbLSTEPF2cjeh7AAovTm6GXCG62
	aD7GDKT4r9Y1TcEld1ww8Hk860tIVwCTFQ2918U30qqKh5I+hAfNTzkeLEhTBFIe1gNpC9pxDnF
	Be5Gmhkgmw==
X-Received: by 2002:a17:90a:d40b:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-3931e058763mr3777372a91.6.1786599264874;
        Wed, 12 Aug 2026 22:34:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm594734a91.0.2026.08.12.22.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:34:24 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mmc: meson-gx: Handle errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 12:34:02 +0700
Message-ID: <20260813053404.21553-2-phucduc.bui@gmail.com>
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
cd_irq and continues probing.

Propagate negative errors other than -ENXIO, and only assign the IRQ to
cd_irq when a valid IRQ number is returned.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Initialize cd_irq to -ENXIO.

 drivers/mmc/host/meson-gx-mmc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..d2903e3dfd6f 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1141,7 +1141,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct meson_host *host;
 	struct mmc_host *mmc;
 	struct clk *core_clk;
-	int cd_irq, ret;
+	int cd_irq = -ENXIO;
+	int ret;
 
 	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct meson_host));
 	if (!mmc)
@@ -1185,7 +1186,11 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (host->irq < 0)
 		return host->irq;
 
-	cd_irq = platform_get_irq_optional(pdev, 1);
+	ret = platform_get_irq_optional(pdev, 1);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
+	if (ret > 0)
+		cd_irq = ret;
 	mmc_gpio_set_cd_irq(mmc, cd_irq);
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-- 
2.43.0


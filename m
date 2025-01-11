Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496201BD01E
	for <linux-mmc@vger.kernel.org>; Sat, 11 Jan 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736621656; cv=none; b=Oo+ucPgEzLf2FpDsFoWqbVQHUIE8xxdX507Aox8PFSEmHp5n/M94lL4OQUZVjWnPSfyQAPKHrXdJTAwG10Xisjp8dyG/PT91UBZqw3eUMkEEdVuiXuO6KGkvYN6oyaURXjdQ53adv9pYRhBl3gvkowdVsWzIBSB5SJ5fzT9r1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736621656; c=relaxed/simple;
	bh=QOTxEnL65PeAOgGwFydnNMnEjIGt+/+sbPe9e2+1EIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUg7epKTaLfsSidwXSSj8sSHBGHJ2/gdSVZ8jpbrafb1o4jhhUciC0Z+qZVQlG5EPwRTQ+vbSBzYvvCwbGYCD6m4pBN5jz/xyEz5HRjtMWMkA6jiEZRHJKGEjyA6PS6qAKqxs3a8TNOir5LhUgf8fnGx3AIxPfjlkliH1UiZYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qL4uMMPL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qL4uMMPL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361e82e3c3so4381945e9.0
        for <linux-mmc@vger.kernel.org>; Sat, 11 Jan 2025 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736621652; x=1737226452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sjFILk91RRJfxDjv+tmpEvIXH9ca00fbQ4AEe6EAys=;
        b=qL4uMMPLF7BBJ6wPs/Z/qK7DjTq+v/Dk2SUbLL1969K3+kGOaVy+k3o29MMwLvkVxm
         eCTjgmSXyBUPCABO60zP5D+jcgjQJe1xtqKp2dXtEroEk+IHs1WVQDfrkFeLeKpsganz
         7i1pfQTCn2r70YfqKf0BMVH/I6SAVXuw54ofg6CrEVuZqNP6t2xIHNmsJs0ip4Gu2VE2
         gLzVbqKE5mvw6MMu5URMn2ecjYXGK5mmOpkqM3P2eDdtsivV3HdgsQNIwPZKX6vxZftP
         x2QIlxQkCGoRDvpycGN5+Fjeol9BE7WWSsX9JBqfFl1DZujX+wH8xDiH/Y88EpPBy9aH
         5nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736621652; x=1737226452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sjFILk91RRJfxDjv+tmpEvIXH9ca00fbQ4AEe6EAys=;
        b=LgO2a5+bLPnGqSZJAew7TpI0pxlQsO907Py4bM4ST9+mcewqdEvCR+8PcB5Iqb7RTd
         18f8ZHpQO23oSE5QqQscoaZzdeXobn4BdZBVQpd5Br+KIOSuoiQQAdZ2fggo1fWJER3X
         YLrtHgGqBZ7ajV+A3fkjlNfJvkWTohYd/HPPgYuRm5SZGZCy2n8dYGFMAVbQ0Ev0Swq4
         rGJZZqshuUpxK4TzIEKyBrG5o0xrTyhev7CrS6l18bBKMxDSpbun/aETFRzdwONCP05X
         gfSnVl7zqdHvxdaD5+5CdEbz3cdRNYXt+nN9UIVx1nkMaGcHLKQIm+3/FqLucQcfV80B
         V47w==
X-Forwarded-Encrypted: i=1; AJvYcCWrgClrzexpXJ7bF+X6CsKJ2rXs5Jx8QIJCd2Z/nbGvWF0FhfWqPw69WP/+TYhbhbJBu35uOOpAlFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8l2TFSN/OQvk9upE9CcaWUF6bsE+p8aFIN1h8PL8BvQc4rMf
	MpWWcbGWhXFQp9nd1dI5yqjdQIq9mL5Kki4elhuRr/Sr4Ghpepl7uMoGrVlN1eA=
X-Gm-Gg: ASbGncsXq9A+2d6uqdQs0az8SgOsgk9pVUyR5ZvOlN8aKya53W1+VR322ffCGBhqtrq
	hPqNRSYWEk87QAn55gVLPR2dtMqiG6Fcx9KrgGtH4VJSp7Qfez2czdMkDZ31l7YHg7/f3Cz9cVy
	jtf6G9nuyfB5LqmUGHoGwHLjTvFY7niD+WvirXTe5qmy4VEPGxMn9nX9uwppGQjY18TyomJ47gu
	o6AMkZbwKPCXbO4s2czy6haAr5sYy1lUJvTMFmWT9qPD2ONTtzRPkoVzEvOAZD0LmNi4ZY=
X-Google-Smtp-Source: AGHT+IEJT2nPD6ZDPo5fhv4lY4oQ+8O3CsOA79cdNjxqQQS/GOueVkAx1d6ruRQG5kJRezObrpNKIw==
X-Received: by 2002:a5d:64e9:0:b0:385:f79d:21a2 with SMTP id ffacd0b85a97d-38a87308a22mr5127113f8f.11.1736621651670;
        Sat, 11 Jan 2025 10:54:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1ce5sm7977564f8f.94.2025.01.11.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 10:54:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mmc: hi3798mv200: Use syscon_regmap_lookup_by_phandle_args
Date: Sat, 11 Jan 2025 19:54:09 +0100
Message-ID: <20250111185410.183896-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mmc/host/dw_mmc-hi3798mv200.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index cce174b5249b..5791a975a944 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -181,7 +181,6 @@ static int dw_mci_hi3798mv200_init(struct dw_mci *host)
 {
 	struct dw_mci_hi3798mv200_priv *priv;
 	struct device_node *np = host->dev->of_node;
-	int ret;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -199,15 +198,12 @@ static int dw_mci_hi3798mv200_init(struct dw_mci *host)
 		return dev_err_probe(host->dev, PTR_ERR(priv->drive_clk),
 				     "failed to get enabled ciu-drive clock\n");
 
-	priv->crg_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
+	priv->crg_reg = syscon_regmap_lookup_by_phandle_args(np, "hisilicon,sap-dll-reg",
+							     1, &priv->sap_dll_offset);
 	if (IS_ERR(priv->crg_reg))
 		return dev_err_probe(host->dev, PTR_ERR(priv->crg_reg),
 				     "failed to get CRG reg\n");
 
-	ret = of_property_read_u32_index(np, "hisilicon,sap-dll-reg", 1, &priv->sap_dll_offset);
-	if (ret)
-		return dev_err_probe(host->dev, ret, "failed to get sample DLL register offset\n");
-
 	host->priv = priv;
 	return 0;
 }
-- 
2.43.0


Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DED3921F1
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941925; cv=none; b=TGA8UrOSu/zuI3UZfvV4g+VGXenGKFRu47jah8wFsB8IxE+DAnRMwE1OP+sdYAQXxWCm1Kl/MiCUTK06hmlkrl+YJZfnYLWh/IKGjL5Adgx00AFI4evuS52xKdtQrp2BUPX5t4ieYmDH1dUOSxFlMova2VjLY64Hntmq2ucZOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941925; c=relaxed/simple;
	bh=wtcwSax+dOymKeDwOFVuIu38JkEr2pWeDdK1+wJVZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YosHTfrSkH1vDB40SZy627Tv4VRKougaRY996vZtUSP1l8PZBixHV0gJJ1SRjs7oPf+2D2AxIK5RjLC+eMryXPd3FAIokohVF7yJuOwLEsQVSJxcgzU+8OidIqqe6HOag2BYM1rCbPRMZXEXPA7t9ZBRQN9GUhHVw9G+Ob4LwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0Idp25W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Idp25W"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso1399975e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773941918; x=1774546718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dck90428BvoqEpkmWusaTQb8k98b4TyQG0pbU+HYgI=;
        b=Q0Idp25W1oFZdQf/AFGKt4I4gp8+vcUCQnwaw+0wiiR1ZTjWo/sw8q5QdbIDXjR3hI
         gEY43KmcbvFEM8JmuCKXesN2aXwBi5dHTGI4yAy47+2Bb/q9wVEmOPA9rB9U7/ZjF39C
         qh6e0sZSEummOcg8AA4v3VJZDTJGeIkEZG8yZIwgAwXgVBhfDWCAb0XC/KDGQUE+vzX3
         Jnyj+cwITrzbnLNe2W6oUQey++PyzSRu5HghnNDiK6qtpjZ3T2rXYi6BsWbTXG75Zg+K
         LnblSJoqiRwfKmOkmICmC5xkATDXo/r4y7tzOT2mEppI1pUNEAxLxGxnV4lZI5Ns7Xpw
         JAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941918; x=1774546718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dck90428BvoqEpkmWusaTQb8k98b4TyQG0pbU+HYgI=;
        b=PsIymNqZsBqsI2kyTHZVjtNRfhsIy/CN8gZPruZZOQ2nOwrVQ5wDmg2Mtp4U+x3Q/M
         ixX2JvQCtaXj9Bvg+9tqsAgp/8H+lEdFS0K4bJv2VsaatlW+rkZ+yKDzV3LprH+1gYbf
         7W7fuQHdidmWhmVIiB/lYx14Ddk04xWx9H+XQem74OsWftJu3vYg4pUMIEcuq7Qkc4fS
         s0MQwAZljWpOO3l40PuXcx7kh87EZsYhinmesh00GjBueo70I1HOVWNKDicgBTZkc1al
         U38j8RfOMfnFNURvkj4CeZVtX4BQU1yDxPbbzWZ2lZXnsfs3KIEFtC5vB9QvqlKtCPr/
         +uUw==
X-Forwarded-Encrypted: i=1; AJvYcCWhqg2AbsAyVkZtmOitHTTn9ZILYkmatI7pd3DyLgkKoC5gqNCoEpTbt9AbcY6iW7AKsrW/vXWr6Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxin5ZbtM1kMFot+FoFXUORsfZkOTBfAoYv9+1E5+i3YjIa/4fw
	okIxYlX9GBJvR2pKPXXDkZWunlZzMtf48AoIBkxzEAmKKi+jLkh6chPJ
X-Gm-Gg: ATEYQzzY712tg4/EQnY1hoavl/9SOssYS8GUE8UbzPtoqcyQXsxwD6il0MFJDwlBuxY
	Ck30ErXczPnVsyBQ539mjgu9cQnzPB0+uy1NSZ3AnCkspKGpCqLPcKCx6LbLpCjRypEhv5QxDW+
	A2eo7I1Mxfe+zam3/64z9lxDDPw+tfo2WZQJ2LhHY+3cxAVVO9FDn8g5SpH/65Xl7czm3fAmzfV
	fTseg5G4O33A9JxVT//uR6pwom+nk8MSkZZvA28cV8jG823zG8L6pfqkbw7aS6Q4LObomolj5tU
	H7ylxL/jGs5e/bf0s0iWMmWDqk04qigN6EIV0/489+SiIul1WwqTA87JrpEs6FlCfoJWGQA/e71
	E68rrIc+TvbP4eEfx5iFqsNSGuiq3Ty6klsQE6Bqw4N6B4N3c8QB5kXRitk2EfS3757Cbu09nTC
	hkfxwS66Wp/CPRJnQ3YPeKc/x8k+v8UjPOcQ==
X-Received: by 2002:a05:600c:55d7:b0:485:4f11:aabc with SMTP id 5b1f17b1804b1-486f8b80e07mr59487305e9.15.1773941917725;
        Thu, 19 Mar 2026 10:38:37 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm212845f8f.16.2026.03.19.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:38:37 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v6] mmc: sdhci-esdhc-imx: remove redundant mx25 handling and consolidate soc data
Date: Thu, 19 Mar 2026 18:38:32 +0100
Message-ID: <20260319173832.15543-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the is_imx25_esdhc check and redundant mx25-specific handling as it's no longer necessary since the new_soc initialization. Consolidate the drive data structs for imx25/35.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673b0f6..3dc43f1e517aa 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -256,11 +256,7 @@ struct esdhc_soc_data {
 	u32 quirks;
 };
 
-static const struct esdhc_soc_data esdhc_imx25_data = {
-	.flags = ESDHC_FLAG_ERR004536,
-};
-
-static const struct esdhc_soc_data esdhc_imx35_data = {
+static const struct esdhc_soc_data esdhc_imx25_35_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
@@ -391,8 +387,8 @@ struct pltfm_imx_data {
 };
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
-	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
@@ -412,10 +408,6 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
-static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
-{
-	return data->socdata == &esdhc_imx25_data;
-}
 
 static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
 {
@@ -873,11 +865,8 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		new_val = val & SDHCI_CTRL_LED;
 		/* ensure the endianness */
 		new_val |= ESDHC_HOST_CONTROL_LE;
-		/* bits 8&9 are reserved on mx25 */
-		if (!is_imx25_esdhc(imx_data)) {
-			/* DMA mode bits are shifted */
-			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
-		}
+		/* DMA mode bits are shifted */
+		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
 
 		/*
 		 * Do not touch buswidth bits here. This is done in

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
prerequisite-patch-id: bf56dcdce62cb97741b7aa11b04c7a9648fb2d6a
prerequisite-patch-id: bb57e0fd9cad8c81bcf7a6389f3cb294bbe1eb52
-- 
2.47.3


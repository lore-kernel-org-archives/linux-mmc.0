Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755912459E5
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944986; cv=none; b=nIKggBkCpEbKtavP0B7gNV31SRYNg75ZtM/V2w6/EUnB7Vy06dgjCkN0qSpsYGBjgIhnIImYY/KjDUMMWcOtCEtF1n4KZE6Pb2zkN/JLwbTH2KwryOxapBW7C8RziEDdB0oSfolIZQkVU5M2moQWtCoDb5lYldyGUTeFVkLTrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944986; c=relaxed/simple;
	bh=C0/zMw1u46TGrFTphNU3BBBRGGtXVXv8VI/g4Mo90iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UlHuPDeyMUAu3hbnXOF5WzLbnJdu8/GraOfx8f84VU2ir1KEDQ4iZSdlF/z/s6MhtbhnPh/6pAWyElXYL9QP5kBUJ2Gk5EBiDZ9jXB/CxOLK1hqFW/dNQnJgTwZjLyK9eej1zZxVUr1Kb61JeGACaqk4kIV6TzOw2taX88N7rXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9287yER; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9287yER"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fd27754bso5033195e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944984; x=1774549784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J98G/61sc667kDXVS1HdzK2h40Uy+YIn7bV3QsVznPU=;
        b=k9287yERlvYlaqMFKwcPapbUvuqoaCF3bGM3qlBxiGiFJ7msH+qm+baTfuOJFhWOnG
         xlt6l5BRqCah7nI7E+HbJA47hoWoSOIfq/3lRipwHyVzojLRZ7lWyCxm6+mNtfVebJxh
         BaOr206rbYqaUex2hHFjPqNyME6Gp+Q1leb7LJZElvBvXTg/yVZo8NQWOb6i/t9oi/70
         EUbqeNI5xiUELQy+3sijQl+9+CbX/Q7wwVyn3U0SAMLhaW71Uu1G7WKlt/13GHfIWSMk
         NOREOYO0tRpUyjC1cWuwo0g3i9m9poEX/xVyrTv+ozvFaH+1dLHWdk3k9p+k/0W2ya++
         DWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944984; x=1774549784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J98G/61sc667kDXVS1HdzK2h40Uy+YIn7bV3QsVznPU=;
        b=njg/KNXg0oQRoxtAJ7jXqiv+Dlr6GXZDuJAy8vWiUR4Ni5lMy+XXY9L3Phonf/+/ca
         FnOQEpOQdKtEPE29SMOoCLwx+yWh/icoAu6O8IQUyDDyK3Wv1M8TBRMnu7yO7RFHpgkE
         49lkYGmxU3v6vI+erOKXdA4IEnwXSdf+qGq1lLMJ1mToWPO5xOCfdeoJpgadDXP1ENPU
         daJwnTUh6XdeETOdCNqiYouNtNodIA+K05Dvh004rpoFHtSbKYys5iCXGK82x88CNHSq
         ghPG115hoXfpB5akoOTgSyDf26pbQqdZeG6Wr3VbkwDODXc55iA/14t872SGIYcqaTdJ
         aNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS5NJD/al4qGZ9ZRpZsdZgd68q05MZ4QAZfenEygNMYd6JtqwqBr5ospUvO9tLSySsGJn2sNhZykA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/sonFQqPpsm7u3R7nbnpOqrp5YmX/YjC6AN5cW2FwdNKHkIV
	en2cuNwn6OiyJhFWgyL6hdD//bQlHdEQYJA77rNS8LX89xas+Y4QiC95
X-Gm-Gg: ATEYQzyl37lKeQ33so1NRzzGRRzM+SVvf3Q9NRstnwwWobLoA7sb4IzJiUE33SyL24z
	J5Zal/zpp2biqGNu1xTw+GsE47KBYnrePTbaN7lP591tX0zXhsWSmUr1/r71Q1eQbWdq4CQp4Ac
	rhIPuAGVtWJxn6AokFRuiClRlut3I4WxRaX+6M4E7Y/U0fC533f82hClcSA5wdwi6oo55fe4lRS
	gv2LIwa4KDg/Vg7vxzqNci3mltpD9/aHlV5bV2V+rgQV8uDdsyPC7LRWrhvH5uDIP2sbsaWyoz8
	VoqkSliBHTpyfgqY69fpojhgfaBLSTEvmt2Ka0CUPAN/M/b3OmCLFV3po195q6sC2clJoEb7C8K
	dW5H/uwUnF3Fnn65h153FWz7dZzlBXNTlghrNTn+joYaxx2ErUEdoqa2be4nReij8KowQCmoxbN
	GJIDphAhk3w2RL2cGXzpYicwfj51G0qSjb28wnJEEnvVVX
X-Received: by 2002:a05:600c:c493:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-486fedbd0b0mr2311045e9.11.1773944983675;
        Thu, 19 Mar 2026 11:29:43 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm142204505e9.9.2026.03.19.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:29:43 -0700 (PDT)
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
Subject: [PATCH v7 3/3] mmc: sdhci-esdhc-imx: remove redundant mx25 handling and consolidate soc data
Date: Thu, 19 Mar 2026 19:29:38 +0100
Message-ID: <20260319182938.19525-1-adriangarciacasado42@gmail.com>
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
-- 
2.47.3


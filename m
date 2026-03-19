Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0E35A933
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950994; cv=none; b=A6NeeLNbudBgX3a2X0HHJ5qbTUPL+7czwYUPYegDZkCvEbAHjF+TD4Ez0mr0K/uqUFZ7VPvSKKKXn3BMnyMiosbwRaiWKOiZOustus9z/8lonbqHJEcz/TheTpb/8D0jNxFQUXbxHGSK6Ezrkhy/BPJds5o+XCuBkMVJ34L2Pk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950994; c=relaxed/simple;
	bh=aeThNmYclG663rSdCfTCLH9YRcXxpMqFylkpFWaIsu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rTzQ29vKCMJFV5t6dXyEJhuDLGeuk2vE5Zdf06JNn1+5LseHOVKtL/YoygetARjajjSGDuuTQpWxbTRHIoQ6hlP+bN4cAXtPAZcvHf6w7CZwUltoGGU+WFz9w7bzovPNPjZg7ZxyiwKE+gjltMi6XMy97wYECPh8uSS0PpmtZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu6Nx3uD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu6Nx3uD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486b9675d36so9154295e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773950991; x=1774555791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z+t3nij9duvH51q1jubZS0ZmVziEVK5rVexkb8LriA=;
        b=Uu6Nx3uD2PQyc40HOda9XzeWZiS7WIAL68wniTlH9R1kLjOn/Jtl5FZG2UE8cuXdOd
         i3aY1g7fPyhzpLRLxpx3+YZtUSSf5yy2ZiIJbyfK+CKMi49JDpeUtnvkr6PUW4oMKmkZ
         9zMDf47RtpOz/1nQj6Z+WoIn67F2FepcDm38gXiHbQNkOwJkkD3h1hbs/3tkSUuRHj4+
         k27Ax3klJ/XPpyQoEwNCdbwIGELu9MB37GayxkholqYeSGLRMp/UsZaIDnceVAp5ZGM9
         7hzFPvSXzBxTUBMytI1FKGUdUOhYaw7zrQdJ/PhieP50engwqSKhpQaGQGjipaevGKpl
         h0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773950991; x=1774555791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z+t3nij9duvH51q1jubZS0ZmVziEVK5rVexkb8LriA=;
        b=aYmYHm2HFpsD8MJe5gSOTD7BNq5P+/TFDbU6b7trPL/WUB6noYZpocxc2gd7+wc+bZ
         /qOl+VKcR+01GpoMMdEPYwHSPwKmiK256yzqt1BBM5aTYdAY7cXmScufBcc1Anuy9oYb
         bpG3nt0AT/VW08Hp62w9iq+PIyDLbSU/rVPilz/+Po5YOtfNDwij8UyxJb2fM/nu18nt
         XPOvt2ipmLj/DyE7jcD5cHTFX2xt35Pg8AndCg3OrqquAYbgeTqNQAvP1VEh3XwFnxVq
         zSiBZAvCPX3Tx0jkT41xAf+9L5KJQE9ObSINqRfRQRVcp4hrgVtS+lJZtaVRxJudCchb
         wy3g==
X-Forwarded-Encrypted: i=1; AJvYcCUDTem67wqrHrRaOcj452NRnmT2vcXIYrwkm4iE3N/qeGRu5i+PhNSurNRpX6/fEK6HfkV6k6QITFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAdcBBzUxM465JIMmLUErVqhVMcTkplvon2oskd3Ykq5HNJrG
	w2+92UZ7d5fjJYZoAOG+zjEm0qKPD8SYh71zt/jpENrOJvBZ9EWGlxH/
X-Gm-Gg: ATEYQzwMCcq2BF2zNCv9lMNPPYVHVlEh5qyvNiRHCihMJutn/UCldJxN9BUgWVrmHCG
	uknrqBUr2Kp1SwvgcKPfaACV86hQMGiLSIvdhUahpT1xTqL9oGtabcTqvXGz4Cqzw2ENhhiuXAt
	d00iXz5FqTpr4HFC8JOTa8zMjm+zUjFmV7DfRWcO381gzmYlsAa7TSwP1/SSptVASn7/s1zmwvt
	9mQ6w06Iq6KRYO+/riwJzx0gsBaMtxrLPRyUBd8NiIqUtrUMiCSsP46TjWn9AKrSAaMuaXIlHKB
	oEqtYznOS5057v0jLFUQ+HDxbMaLuu8XMn+mEHnihCmNDDp5EiclpVNOJv/KWlnPULKdQ6TWL3u
	p8AUMiaGMlZa7fm8+HiOz9J8NvatW0o+ZGM4FN3jKpaglSKkTy5LOc52WBP/KaYgp2/qQcIHUaT
	ySQu7ngivpUeS79mIwPO1dZKFyEZ3FaMVDdQ==
X-Received: by 2002:a05:600c:a4a:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-486fee1ab20mr5793965e9.23.1773950990582;
        Thu, 19 Mar 2026 13:09:50 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe967c64sm8991685e9.2.2026.03.19.13.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:09:50 -0700 (PDT)
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
Subject: [PATCH v8 3/3] mmc: sdhci-esdhc-imx: remove redundant mx25 handling and consolidate soc data
Date: Thu, 19 Mar 2026 21:09:45 +0100
Message-ID: <20260319200945.23333-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The is_imx25_esdhc check and redundant mx25-specific handling are no
longer necessary since the initial SoC data initialization covers
all relevant compatibility cases.

Remove the is_imx25_esdhc helper and its associated logic. Consolidate
the drive data structures for imx25 and imx35 to reduce code size
and improve maintainability.

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


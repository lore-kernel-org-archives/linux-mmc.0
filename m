Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A46FBF;
	Fri, 19 Jul 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378786; cv=none; b=eVRmGuVZ1DCcDxAiKt5+qqW5Tb3EwfddGZwTBf47QRlj9qJbHF5UvPX8bYzCOfdTcl2Mm5UoV7/q+3mA3t3CaKepHHsBDoDXMyxPIUYeVUGY+7c88Om9Z6OfsDlQ+yTtVsDWdoUHdI7u6IHQcb9UOYbfot/GxhYksdKEoaXzj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378786; c=relaxed/simple;
	bh=KACTGWyx6Se4J5CCj4YdwJDh3Wd/RuE8iLpbdP7yd4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9n1lhSNN8g5fjklmnBOJTcAM2q5tL97vis3RNf3QnVNXnmifmtfd1ZgUGMoiB6ALJchvcVLwVSy0/bzA8EqhFZfMRmvigRzDlcDhD20MQ1gg40LjAmhau6VvCLOr5/IQsrD5M9zizilGttkt+/XuHl2v+a5TIOPWm7HNZfRyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcQFJSAp; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcQFJSAp"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260e5b2dfb5so948641fac.3;
        Fri, 19 Jul 2024 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378784; x=1721983584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyrv8ONiR+CGVEjcg54gy7pcW422aJnTfPt/rMxTHl0=;
        b=UcQFJSApc20p4y3vHs3pigUIEFCLPNRwgueOIiV7TnWQfUtseczAuQX4JzFpTFQPNQ
         qDPYkRdGu4nIdZXN/T+R99zo8GEHCrnGilUAuBwTBaj3/GtMnHBuY2idt5YFJLB3KLMG
         aRaVO/JIyrAnD1et6ZGJmzygp72f63Gb/sfNTqQg9eCREgzvK61H4JeA/LS1Ah2nM8dd
         3jMWTkPWG2ns70ntpeRhJ9Iqx79EqxO0vhUv7+87hffqECKdBSK2Ms75tmj7f9CJVYsw
         uqJTkFmFgIY37Y6Loi/YOlrlD56ORQQQ2Y9xS6sG/9tCgC6QsUloxJy3YwnI4z/0A5RH
         6lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378784; x=1721983584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyrv8ONiR+CGVEjcg54gy7pcW422aJnTfPt/rMxTHl0=;
        b=JfTns6X8/XDQSKYvjg+tk74oO5Co1bj0eI0ROFPUIxzIlxYouLYrWN6WVzE0RkePAF
         ftISlDe8nq6ImXSBNinijrw0Ir2o2FS6nsV59mJ6z1VfAW/Mtn93MbHh+V4gYWVuRP7u
         ZsElSBFqu5u40EXWuotkiQf8+moxD0jOhhCnAAUxWaHXZPazlTIadFkeEJVwtJtLm6sO
         ZgtjBJjGFUgL2paGSwATm1FNV3PB50Trx9/HazCFqCV4FQ4/qAY0NIjgdNespTWu1a+c
         BbMw9zdR9vpOPoh+pxyRUP5xQFYu37GKT4OUO2RpiszwFNSWX7sfdGvhu7uBx6GCavJ6
         abIg==
X-Forwarded-Encrypted: i=1; AJvYcCVeL22NWS8r5XYzCVOJLE+8LL+YeALFgpAJSsgheM4kLxB6PtsTka6CXYv3SA2LPW9gsdKr3T1GmGDnzeDd4kMXurh/Et7zZ8ppVY5hyl5gCS8ULnO64q71Dh8wHkWF/eRlaKKSKv+ai7nMpJ52AVPswQdttZEsvpuoaBxRjrEtp2ljOQ==
X-Gm-Message-State: AOJu0YxbwcAHNedyGaJsaBsVNknulJKn3+xO6N+QUxuQcVtQ+vpBsiGp
	Aytgd1+40AQg0JgfPfzChXxsItwQ/mBZ8GOmbNPBzn0a213nii0N
X-Google-Smtp-Source: AGHT+IF9PHnW0tbx/EYsOKZWy15W7XCeU6+dIQCu4I09neyxp7NYvAxhHAoLBPFmWHyDWCmNL8yNXA==
X-Received: by 2002:a05:6870:ac1e:b0:25a:3fbf:6808 with SMTP id 586e51a60fabf-260d946484bmr6154141fac.41.1721378783616;
        Fri, 19 Jul 2024 01:46:23 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610c7d3b94sm230863fac.30.2024.07.19.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:46:23 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 4/8] mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
Date: Fri, 19 Jul 2024 16:46:15 +0800
Message-Id: <1bb79db9f05ade17d269acefb6dcdce455236b92.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Continue factor out code fron probe into dwcmshc_rk35xx_init.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 34 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index bb0adc2ee325..30e4cea8a058 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -711,12 +711,22 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
+			       struct dwcmshc_priv *dwc_priv)
 {
 	static const char * const clk_ids[] = {"axi", "block", "timer"};
-	struct rk35xx_priv *priv = dwc_priv->priv;
+	struct rk35xx_priv *priv;
 	int err;
 
+	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
+		priv->devtype = DWCMSHC_RK3588;
+	else
+		priv->devtype = DWCMSHC_RK3568;
+
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
 		err = PTR_ERR(priv->reset);
@@ -739,6 +749,8 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
 
+	dwc_priv->priv = priv;
+
 	return 0;
 }
 
@@ -1184,7 +1196,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	struct rk35xx_priv *rk_priv = NULL;
 	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
 	u32 extra, caps;
@@ -1241,20 +1252,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
-		if (!rk_priv) {
-			err = -ENOMEM;
-			goto err_clk;
-		}
-
-		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
-			rk_priv->devtype = DWCMSHC_RK3588;
-		else
-			rk_priv->devtype = DWCMSHC_RK3568;
-
-		priv->priv = rk_priv;
-
-		err = dwcmshc_rk35xx_init(host, priv);
+		err = dwcmshc_rk35xx_init(dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
@@ -1290,7 +1288,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		dwcmshc_cqhci_init(host, pdev);
 	}
 
-	if (rk_priv)
+	if (priv->priv)
 		dwcmshc_rk35xx_postinit(host, priv);
 
 	err = __sdhci_add_host(host);
-- 
2.34.1


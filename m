Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF0129A99;
	Thu, 13 Jun 2024 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242982; cv=none; b=WND5akb/bjrj9odLpvIFbNG0vx9yKaqDL3DDAsfnpcIyTiGc2z1ZOOr4Ae3Zq1Ui9FaC6yiZ2Xps08X+3tZdazmI2Oa5yjvtPs8g8BBRJmn5S9+gqFZOnYtnzsraus384Df6SwCnkam5ol4Ii2DUg/0hb2ILEd5A2R1mFD5ImEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242982; c=relaxed/simple;
	bh=7abbWRIx27AytNTH4OXZO2H/ozQ/vLZ5aUHwu9tKvFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kB50X5i8HHwnAwA5DM5v6fPtM/bAb8m54pk5KFZc3kJRU6CZDWRvY7f4NlDqegTP++Bz63ApiVnk476O/PlH0JIZpWyTch/JXP28CeJC/2lRKFb0nG/zQmZs8s1mXmVuHBQuQoR0jesfvHKmA0/D2OgnR1lfJzK59g74H3Dghc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI//pNXf; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI//pNXf"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so283220a34.2;
        Wed, 12 Jun 2024 18:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242980; x=1718847780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mEnEjULKQXk4yYyl4mjE8uROEMCabgqsBL99/Efhs4=;
        b=WI//pNXfCPt8Bl+53e4Q68otktL6KMEjIJY43Yfu/oP9gm8YoAJDLMeDAgb0CyhFkD
         j8KMuCBCiy4LAn4OUQGKL3GvrIF0t/Z8MyQ1xe2rBCL8JvX+0BfHQEiww/eckyq/yHHu
         1WMA6bO/BoTS6P87gxU2dw77YKQA2zobvriYXI7sYCnsUrxLxyQye2SIbLmHN/Kog7yY
         gwDh1cKn+4cqmz64mu/8yu45HNZjCLv3nmWoTUmFnq5G96NbRpNousNLFcOMX1oAfwU2
         EZALKtMhTpDolozqBC9LmWG3bRA+KRxGCSfdllWeF+f+IYKYoX+Z/qWVRuLLTwYjQxXj
         e6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242980; x=1718847780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mEnEjULKQXk4yYyl4mjE8uROEMCabgqsBL99/Efhs4=;
        b=HLzHT22dhSOAsSlwrMwRehtZmmzcTT1ruC6XGzaAXRrrBm43Y5vUARAsivmc/E8w4m
         4RjUT7hN1xpKi0Sa02zSYcoo92nBzYy4K1+vXxs/SmYGh4wtJf0rKvUaaLA3o/yh4g8f
         vK2tVRptbyPg71P64hG8rhrIyhAiEp3xHBWPBmZccOE66/A/ge61JX9PNa9YffYn+Sa+
         4m5FVBEdtqCX3YVBruKmVqpiNugkRItOiLbZD7UqCYH5qqfshJn2AZbP95WK66Ly2YUe
         udiw4L/ABp2g63G3gmfy5hRWGSqMoYQ2CByCgjEhjNJyri/MlcCuKkM8bHereiVHHu7z
         uC7A==
X-Forwarded-Encrypted: i=1; AJvYcCW+hXlV+74H+G6k+V7XD2HoiXovBDlzIeWqnLZN+umh/eClLxcHGM6MFqmAdpqmPct8TTsFA6jzMOk5K8JI2ZpBRd8quEXVpLlP0Y5WepKvHW9OZyylGpCp8g5rOFzweEe1ISneGZxQC6IqUZkHEsnmDS4Kww5OvsrwrSGc5xXIRii2GQ==
X-Gm-Message-State: AOJu0YwMW9/FqXb2qYQTN/hnlO0XwDI73huzWwwbU0qGZH9A4lBAcpZ/
	SQLzIHfAF17RB21Nw4S9jB5GhOHnAoqk97UnbKAFzRV/YmiUQHtK
X-Google-Smtp-Source: AGHT+IH4rU9kj/OV/RIpQ8nZ2pKMrO1e3JSgSCb/lr/90ul/n7aHhOdX2QpKamzVPNeXcaH0mEH5EA==
X-Received: by 2002:a05:6830:205a:b0:6f9:72ca:fdc8 with SMTP id 46e09a7af769-6fa1c43ba6amr3001227a34.37.1718242979977;
        Wed, 12 Jun 2024 18:42:59 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd6292da28sm46575eaf.47.2024.06.12.18.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:42:59 -0700 (PDT)
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
Subject: [PATCH v3 2/4] mmc: sdhci-of-dwcmshc: unify the naming of soc helper functions
Date: Thu, 13 Jun 2024 09:42:52 +0800
Message-Id: <91adce8d020faa22a97719e8774dda01a58333e7.1718241495.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718241495.git.unicorn_wang@outlook.com>
References: <cover.1718241495.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Continue another patch: "mmc: sdhci-of-dwcmshc: adjust positions
of helper routines".

The helper functions at the dwcmshc level are all prefixed with
"dwcmshc_", which is easier to identify, while the functions at
the soc level are more confusing. Now they are uniformly prefixed
with the soc type string, such as "rk35xx_", "th1520_", etc.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a68818f53786..346d2d323a05 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -193,7 +193,7 @@
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
 
-enum dwcmshc_rk_type {
+enum rk35xx_type {
 	DWCMSHC_RK3568,
 	DWCMSHC_RK3588,
 };
@@ -202,7 +202,7 @@ struct rk35xx_priv {
 	/* Rockchip specified optional clocks */
 	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
 	struct reset_control *reset;
-	enum dwcmshc_rk_type devtype;
+	enum rk35xx_type devtype;
 	u8 txclk_tapnum;
 };
 
@@ -621,7 +621,7 @@ static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
 	return clk_round_rate(pltfm_host->clk, ULONG_MAX);
 }
 
-static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
+static void rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
@@ -749,7 +749,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static int rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
 	struct rk35xx_priv *priv = dwc_priv->priv;
@@ -790,7 +790,7 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 	return 0;
 }
 
-static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static void rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	/*
 	 * Don't support highspeed bus mode with low clk speed as we
@@ -1062,7 +1062,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 };
 
 static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
-	.set_clock		= dwcmshc_rk3568_set_clock,
+	.set_clock		= rk3568_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
 	.get_max_clock		= rk35xx_get_max_clock,
@@ -1243,7 +1243,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 		priv->priv = rk_priv;
 
-		err = dwcmshc_rk35xx_init(host, priv);
+		err = rk35xx_init(host, priv);
 		if (err)
 			goto err_clk;
 	}
@@ -1300,7 +1300,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	}
 
 	if (rk_priv)
-		dwcmshc_rk35xx_postinit(host, priv);
+		rk35xx_postinit(host, priv);
 
 	err = __sdhci_add_host(host);
 	if (err)
-- 
2.25.1


Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CA6FBF;
	Fri, 19 Jul 2024 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378768; cv=none; b=UYdBoS4uDIrsBImu8WLNa1pWgA3qH37fjA+bmqGGOdyogLPtYCFE5Sj9HYW2GcxL0gIqvnnBuIOZ2AwfZUGkaQVsoHQySmdsOQtjtO+VS1xJtpThQC6s/9lCuLJFQc/MY92vf6Iqzbd+8bPvcH8ui9xJlZa69oe7e7jVX+NaTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378768; c=relaxed/simple;
	bh=O9lJG+k+tksg6Q8u/j+wl+xaVG8aDV4tvD5LsSXZ0zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4Dc10ACtMw5EcCPW1WyJfSW7/StlKV+ebh6Vdii1IUSKJiujAatd/H/+il1x4gqa5YMUAVM9bVcenY2xrXxiodLd5ZYkYXNNr+SeRKRJ/Wx+XTaMWkYfiKllKPHLK3pr+NecQveZO7lbk6sqt5vn6fbx0M4ZDc17cA2cGvl9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjUMK6xI; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjUMK6xI"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c667b28c82so764129eaf.1;
        Fri, 19 Jul 2024 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378766; x=1721983566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oydJeqRMAIcWXHWtFSpsEnC22p0yugXf58j/ILvTUj4=;
        b=HjUMK6xIiiHUrootYW8QPTj9sttIEJvYn9rTD6h83wmo0AfyhUFYt8u66nsLXetVlf
         VdjQuICDCtkyzRIjBKy4ToWsLV59o+nJ8xCg/EsyyaTE0GyCiKGFskIR/ML6db+l6A0s
         woVecmZmj14+KTaMnv22iGdLE7PMFDaVRZPqTCEw1IFYQzxCudo+kWQBj6pN67rAf7Ve
         dvcfcs65/gAIDYsjElHQKCYwYYRnsYqYl8F1FdRvYVo7H+rsv/IHYhbz0EPfnKK4YYAP
         H4DljwDJvq4YumaO9ZisAqS7UAHIirb0CigRqnAUqs6o8Jb9Z5F1YuHJp3KPK3x1eduo
         T59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378766; x=1721983566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oydJeqRMAIcWXHWtFSpsEnC22p0yugXf58j/ILvTUj4=;
        b=Mw4CBTFnG3FphwbswDLEAAVe+nx+vxsAYnp7HNcQ1RVU1xh8zsvYbi/8pts/DtzKuh
         ikBJPjTr05eY2k2x4QMu2ApdDefC/XoZI+5eqFu8ObZ0t82tM/9PoZedf/7hp2jK3tUZ
         MNY2KlN6WNBvNJdr1BkbGT7ss/PwQ50Zf/TjzaRokHwR5+sJ6jg2boqWqL4QFXeILgLO
         0rvx0PR3+pZ9p+eHw+rq8sSN5IOEpVCh+v/hFL4hi/djmznuqh7ZU55PuAtSWijy8E/r
         hYF3Phk+dtdo3ZRgFgBDrDV8SQLPTLl6kSTKHYXMycrHixO5Nt4+D2Dr1EfnS21Igq0u
         B54Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQH07ZSFhkHa1Zsf+to7sYrhSoXGwomq0BenTOuhDT2SM7fVGdOFiqBlP2Oi4hndk/s0NTgr9JwT7lD7odGw1ojdVUORzmcL3WhITR1bPvyq4ZnDc/Bj0K/q+vIi9EPxYBJQ6vb9PfyaUZyfhfHgfs1VTsfgT7LT4jE0qLnftD6pXDAw==
X-Gm-Message-State: AOJu0YzWwmtDQ+hK9CzBVNamNEPp+FMCapd7X6VCq8DJMiNkh3yHxcpx
	dSkC6dMx31pf2u/TrOh09GEhwCq25cP7IQOx1ifbaKXkj3i+ll8F
X-Google-Smtp-Source: AGHT+IHn4qha4kbRrWIiX+a0mGhPKxilYgIXp1gDMiIDeE58q68IhDxPbZIJpjFtfNBe92nq4RZ4Hg==
X-Received: by 2002:a4a:d018:0:b0:5c2:260b:305d with SMTP id 006d021491bc7-5d51f967addmr2896107eaf.2.1721378766628;
        Fri, 19 Jul 2024 01:46:06 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d55a7fa3a6sm177640eaf.9.2024.07.19.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:46:06 -0700 (PDT)
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
Subject: [PATCH v5 3/8] mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
Date: Fri, 19 Jul 2024 16:45:59 +0800
Message-Id: <b774f2b62d68edab2d95d9dbd1f55cac50c6abff.1721377374.git.unicorn_wang@outlook.com>
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

Different socs have initialization operations in
the probe process, which are summarized as functions.

This patch first factor out init function for th1520.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 51 +++++++++++++++++------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 903fe06050e4..bb0adc2ee325 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -830,6 +830,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static int th1520_init(struct device *dev,
+		       struct sdhci_host *host,
+		       struct dwcmshc_priv *dwc_priv)
+{
+	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
+
+	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+	/*
+	 * start_signal_voltage_switch() will try 3.3V first
+	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
+	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+	 * in sdhci_start_signal_voltage_switch().
+	 */
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
+	}
+
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1231,27 +1260,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	}
 
 	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
-
-		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
-			priv->flags |= FLAG_IO_FIXED_1V8;
-		else
-			priv->flags &= ~FLAG_IO_FIXED_1V8;
-
-		/*
-		 * start_signal_voltage_switch() will try 3.3V first
-		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
-		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
-		 * in sdhci_start_signal_voltage_switch().
-		 */
-		if (priv->flags & FLAG_IO_FIXED_1V8) {
-			host->flags &= ~SDHCI_SIGNALING_330;
-			host->flags |=  SDHCI_SIGNALING_180;
-		}
-
-		sdhci_enable_v4_mode(host);
+		th1520_init(dev, host, priv);
 	}
 
 #ifdef CONFIG_ACPI
-- 
2.34.1


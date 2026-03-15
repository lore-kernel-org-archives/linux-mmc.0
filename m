Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE97260D
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773606167; cv=none; b=eTrW6l2etYzE7ve4ojFvdFQ5BeduP2Uuiafnsyb7zMAm1ReOzeVDt8QTTU6WGYsk3myhegPNPFbQFfcl9YpePtSwS2T2CyutEaR62bybm4mluApxBlVVTiwSJqQoDAIORN6DTNecWEmcscqLNN7sDXhIEIPwxgYWV205iaqjGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773606167; c=relaxed/simple;
	bh=YmyURTSOe9/SCjL49JK1pX4JjS3HabyPzHa2LlBpNCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LEHlAvIgGnQ+WYYSiUVd/2NtTQsccFVt+KamkF/i2w5Qsf3rUA2xSXINmBs3HvCzELBlQzmgYr0j4vG1JtnFRi2CLUACPUDuG06cCYSISMLtaj1zZNeG3q3bNmiXBf/40Y0eQmtk8H07qXL8Z/+pFf3StNC5Kv/LQ2DIFfDjCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ2FwYYT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ2FwYYT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48529c325f0so27553925e9.0
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773606165; x=1774210965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPceeNJxYcOrj32GCH9mA8vAA8Kap02ECqmiWtmSPh4=;
        b=IZ2FwYYTTsv4ScDqj2WeegJd/fF2v4bpjfgzWo8DnCjSE/DivPAyNXon+/B24M01pp
         XJvQnn9Ju5vFokWhE6OOYJmPK+XXb0gIw0z4pOrZJqd02a6eGNPdwvzp+P2dvhBcNQc9
         IVsCGlYZ510e+aIMOaWI8iFxDskOTBk6ycwGnMDGRf58LrzOq+7XUOOkvQh0NphHSJ4u
         pYXRPEu8pve2j/ekj1jANpkKzQvLrdVYK2flyUfkYZlhn4eW8EcCzBA40hxW2o2Couwn
         BkZA6SKGvmPXiGj9eLjdDIq9libKaOVp/1VnRourrVeUC9xFLYG8TZm5r84VtgzoPj9f
         MZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773606165; x=1774210965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPceeNJxYcOrj32GCH9mA8vAA8Kap02ECqmiWtmSPh4=;
        b=nQNnvgX6J4aBt3stsaptxG3J9bO/3iz8YiUyG328jDxjkXJ0mGgxq9wCkzEG1Qpfua
         PCTdoegrcLwt12kz192Zm/swAs6Dh9oeh0VEi4J65CxdRikUAdkWR7k80CifAS2FcfBn
         04ESICMEuMoF+ft4iqAgMz680ED3R+4S1t8aFaiGJmrjn3h+AXHc9VKlYOEM/XrKyjW9
         zS5bFr6Cd/C0bYnErH6sTnaH99MJwnMPbX0VaW2FQeu866hPKRqKrjmKuhNglsmsRxnZ
         //i01yTU//UY1XN5b54yhMEFYJiP9r9TSXm5JphOhiNWmK0VPXqdYlBhtApLCekWjPrr
         vtyg==
X-Forwarded-Encrypted: i=1; AJvYcCVKVnUpIfhpaFATh9AuxBbM4F5Mu9jFAyIB/79sCC9bs8DIpVRJOqE5fJvnitA+gO42i5dUHW1+4bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FRDOYB/Alp69Q/Fnzl6VP4oA2nGsGzG5VRQm/ffLlubWlo5q
	zFyhyl0ih+tHDGlPTno600pb+pjmqrBGheAjkkf3tX9svDMB/lNua1Zy
X-Gm-Gg: ATEYQzwencHDAIbWZap/zPgsiYpdjBrm1OLU1AE79dPUlm4iisIEJ1nvelCW0CzRBql
	tI4BxNWVZMZ0lt2+cnpqQKwjis56WSsyB+jStFBDRDOnRcq/1ZhCD4Ogf7EvyPPUALabjrSWmPY
	ZhJVCeYNSLw8Cy/LpRBgkspwmV/axXu/JphWHjJgMkozfGEZENDjdznoN2R6BsvQWJ57YHldYrt
	nYgyHDmLkLxA3kgye9Xna9y0nNrPfpihtKqqWbhbYFiA4yKhEF6tmx/pFdt5H4RefMVoZret5K5
	HUwQg+K4IcrxMqur3Cso6Hi/0ZWkelXWfRKSyWhQOXtDgMY7jbT+lqkCnoPUifsppW2m8qaZBg+
	PNFtOC7bn9m5nTAYf2p5bQxjGwOD5cBLLUUtX9ux25sV34X2B0eFaMdgPx49mdJd06K6gH8LPY2
	n/xA6fOqu33Mj8nJ2Vf+0mXoy4tweScUfRwQ==
X-Received: by 2002:a05:600c:3552:b0:485:46fd:100a with SMTP id 5b1f17b1804b1-4855670299dmr172636005e9.25.1773606164279;
        Sun, 15 Mar 2026 13:22:44 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f619csm121862955e9.1.2026.03.15.13.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:22:43 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v3 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
Date: Sun, 15 Mar 2026 21:22:34 +0100
Message-ID: <20260315202238.15758-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
struct since they share the same flags. This reduces redundancy. Also
add the CID_MANFID_KINGSTON definition to quirks.h for centralized
management.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/mmc/core/quirks.h          |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c..d736bb4be 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673..9cfa26722 100644
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
@@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
 static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
 {
-	return data->socdata == &esdhc_imx25_data;
+	return data->socdata == &esdhc_imx25_35_data;
 }
 
 static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
-- 
2.47.3


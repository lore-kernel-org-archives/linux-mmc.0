Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D937AA9D
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605942; cv=none; b=QOIZvL4AlQR2hO2bv4XEwPwLQ49BPehU1yJuGdQkjb60qhMsl/leHK54L8gaAuG2kwZ+URxl2Xddr6CUkWUcbWlGOkOHTcE02a43Cf0d0pfkBou3aAj5O9OeSCfVq5cw4lo3oqG221zeWndL20JmQ1b+ZZisvAafI6IjFCRJQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605942; c=relaxed/simple;
	bh=YmyURTSOe9/SCjL49JK1pX4JjS3HabyPzHa2LlBpNCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKPEmmw0iUmxASuFkIi2YMk8GP/XCjS33dOG+1nCkpheud1D4IMyyDObQXa4A/JlDmkWuNSr0XkjjkGUztFTf9bkExAhNsFqKI2HCZl3iU4luVEdtcynLohhiiP5BM5mWreRktkWluyk1Bl8wmmyi4zVJjKPAjKPxpWyl1mpODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC5cU6kR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC5cU6kR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so3089299f8f.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773605940; x=1774210740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPceeNJxYcOrj32GCH9mA8vAA8Kap02ECqmiWtmSPh4=;
        b=DC5cU6kRinmrYTd+Et8fQcurhdidtsq/W7HB5BJ+iHe3ZOYE2mzx/AKDdmcrEuxwJh
         2LOGLba1CKRZidOlFZSALx6YDn3uHAh1hlYjdQDUZ29cn+ISnzORzCyfFEij77knsekD
         qJ83K7MNEC/EKGYcMt8rv0WUkhJSkV6XkzIXS6uv0XM3saIuWQtSNBRfLR86WxJpIvZQ
         upHN8qWrA5asAkJknArBjBYBcMhtQSXQuY+aIRBJIJc7GYWzDFT0X3hxwrjr7Deqk0B4
         8KuUzFVIDPctNvaQPCeak/7nGZeRyP94IO4YdVKFIPE220VTLLyJpub1tGWqAY8unlbD
         JlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773605940; x=1774210740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPceeNJxYcOrj32GCH9mA8vAA8Kap02ECqmiWtmSPh4=;
        b=OAcf14nRkv2hilzthRcxzKkuP2F16LIlFJwn9asYjQXbwbcHcyFRC5wwGYxo0AJV5l
         C3GHJNqYofGbyRpHKklG6PZgvEA9gdPeZ2v6Y/9ibgez2BdYyj2pn+mFDYhwjFHIpCrp
         C4JMp1/ugikNssEkwigvc3FgU6KPb4EUEa6KaXkvlaT8T1bRvkXLtyAljz4INHIcTUE0
         LzX/OiabwfgDF6CUf6S5iH85oReW8KcgPg/MPmulhO9r3Zi0dASbAUTGE8UAUWTlthRD
         75wsYBqKwGWZ8UBUWr4+pnyi+wxI8Ku5g1z9anGWjx5JFZJxIiEJ9r3jqANp7rxT6ZAP
         XmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCb9lhn4HTU+QaJWqPGnW9jeGmU9hxPd2rWnm99e9sqtAyZ9ljoqvZYdmG8AC/G8BOmOrYXGHAycg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGnCfeFjdbogjH5jJ1SpbJVwsEyC39jDCXiZc24p5Rpbo3EJD
	xyFYRbfNYzSYO+UYqy5JVKr85jmCQErK8xrv9byUnilesZTnZwfgFtM9
X-Gm-Gg: ATEYQzyxtaZ9isFIXlcyaLreT092JxKf4qiRILCWknvoK4eAMy8t/EGR5dkiPRay+xU
	yC+65Qif+1hcj7YF6+POxrIemwNo+dTys4poxEgniY/xq833/nulVqwkiDnZUtxuofbU1zp+k2a
	JZNtu2qpOoDRMkCdKAQSu7JYQfdZrYwYs21GTHylithRy3d0CBjEkuXM13RN5lM/X0UtnLbtQZq
	W10a9G+e/hgHxhBrbM4SoGmWv2WpLrijHAYgXRiy+YAI1arU12SyW88HT2StfD8Q4FadT0cuhtg
	4K3YMLHjehI9+vIN9zIa+LyIlf5cAgkasgDPj5r7QBRsiIcCQDMt2BIGavYn6gQXuPv4+y0sb6Q
	HEUAsaFchuywL/eyXtaMtqBc9aN9pFenJHEVIjbvdDdYHWd0rlweTbFiU6x1ixpoq6zDrzIXd3v
	Yxtj7No88rtA6PBJ2UaszxApK0ftjv6Qxtbg==
X-Received: by 2002:a05:6000:26d1:b0:439:d750:42f6 with SMTP id ffacd0b85a97d-43a04d8b557mr19733952f8f.24.1773605939326;
        Sun, 15 Mar 2026 13:18:59 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4389321csm3295618f8f.29.2026.03.15.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:18:58 -0700 (PDT)
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
Date: Sun, 15 Mar 2026 21:17:31 +0100
Message-ID: <20260315201853.15552-1-adriangarciacasado42@gmail.com>
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


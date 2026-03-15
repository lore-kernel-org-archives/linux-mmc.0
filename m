Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4063750DC
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595022; cv=none; b=VartiuAHhZM+NEpeMj/z38gSixK8gXWufkdLGMPaeF0J7WMgsbbDdiCRbCymo5dZjpPFhmlpOKNUEo+9uZCCYyLPl+FOAh4lE40kwJexzTYsQwC5PhR/c0+CiRN+caiBOn0SyBL7tkURSEWebOjSwPDUsAaPvlnYsFvsUQK2F1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595022; c=relaxed/simple;
	bh=X32PXM6CIYzypQR5TwfD7Jn/cbq77OlrCWR99DHxUpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcbDVsngojzJm/2byi+Gz7u/6K7ZKsTLrWFMDi0+r+NdC6s4jJd3imB+Srs6LVDwY6s4Qdlp5nyJCVpuBQu6V2huXqAp5YRD5Eyw9TqFgb2OptsSV8BgHvhDVff4chbW7umjzsIYsZaO+AiIoGG7tJwoCnYabNjh+LLNu/9O2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkP3s57m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkP3s57m"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3943294f8f.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595019; x=1774199819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubQ1v6PBsq99cAcF2yrnS1WsB85d1f/acmJVUU/lg1s=;
        b=bkP3s57mdv06Q8pGVWI4sO1FcTTW0j4zh+8kzK4R0Kpp+g8bHG1yntDaZr+QWoE5BZ
         +CtFml9JkkNytDIZEJqKa4MeJ3m4zFKaZt0klCzfeZaEo1KCiakxbgaV2NoKjnXU7otn
         rr+SYvK4ssEnc1oxI0xCByyWzzsTFU41my6/fvn0ZdD5hhoQe1sSv1jsT58Bf0ByHtj+
         WvL2wSTQ27qYrzk1BjsVr9PCQvp0NF/1ESdZsOUxwR0KjvVwLsvfIGDUdPgSiOVVkEzn
         MupnbYA45bC946+Fh0djNXW66NMPP/1gYgk+JFKeCz4keggXKP0N9sdY99ByzigsffOF
         Rx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595019; x=1774199819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubQ1v6PBsq99cAcF2yrnS1WsB85d1f/acmJVUU/lg1s=;
        b=ZuOewy0inXsx1FBY8J+cJuRgLCEEdKrDQZ5l7jWyJF0kzsrqBmrLKP+BNhhPWQW9md
         yeNHifBOK1lY2cKvA/MtCQ7qQQL/1U14qaS6SckGH+snuO7FpsAII2VID6CBCiFvxIgU
         lp5AwobdIbrHI4VsIHl+3PxQFLk7T98jWOzxfnIN3YWYWkx4qKctpUpCMIt/JABbKBrf
         kJmE1895eXX8O4K/i4LDGEywPHxBNI3d8sLfOA6eb8pk5lopU0AjKM1d0G0vQBDU8060
         ZPG9aN3w7WgYAsmhHy0KV5gwmlk1ERxLl+C7mbL39wC0gDHco2FCzHFkDsCk+W3xcdM4
         s2RA==
X-Forwarded-Encrypted: i=1; AJvYcCWHdv3HVZOUKkDGpAQsv7cA0qwarQ77XJuT0szraZXoBWOMRzMzrqakOPahoPYorCEwwQahP7rHbqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAGgPJ+yid6qL8BwCCaYQn7V9WJdMgipv/yqRWllB2N4oln2J
	HPDHsJ2aXr+IIMDBhXmrcX202iAUVA9NG4ApuFK+IjeDyDHSD0j396U0
X-Gm-Gg: ATEYQzwnXz34rpdIEel1SZ4atIebQcE+In4kLUbxtH+Zni8rRysSYV98gAs2Xb7f838
	bZ8cD+/Uhc2zwxCX4E6oVIOankwy1yapxpjFiO92dVS/68q7oBwHPAJ56wvEFMNBvi75BdiAnmr
	wXiqok2QoGBODLg2C25AgfKu9EQoH3rkFT+7ax0f3aLzwhcxjeJuqSaZsSSCcRndgcUQlL3ECVN
	s+nQW7MVAi0aXduQhPMGLnjM5xkntHJ1eGrxk4FK8H7RvypSjoJZMncPXvq/zvBKxxCassjzcV2
	56vglXOeOkKiSBvDCGK0Ni0k/EF46L/p1DfHvmMM3oNxQ614Ik1d4SizGgaO6N9HPlbKVBDICYw
	XVHPVIrytABcNh1vDNkaOautgIiALMkGB0da4B3LDjxtuuqgTlBWaVeEVCzleqTEDfIhMgRvNjg
	ZvZ+hL0SGj/SP5zLEDwaveos5eXNdWlzJi1w==
X-Received: by 2002:a05:6000:200f:b0:439:b59e:5e65 with SMTP id ffacd0b85a97d-43a04d79252mr18547646f8f.6.1773595018822;
        Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 1/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
Date: Sun, 15 Mar 2026 18:16:50 +0100
Message-ID: <20260315171652.269020-2-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
References: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
struct since they share the same flags. This reduces redundancy. Also
add the CID_MANFID_KINGSTON definition to quirks.h for centralized
management.

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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


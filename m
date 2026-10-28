Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191884;
	b=fNqA5ZSts2Xib5CKvCtf6mxgz947qaLbDkyTVirpVGC3zv10qu+/ryNq+sT/noaO3svt
	 XPRju8X8Ss1h3kQXmKeCmAl6W5jMyzd1AVdxzFRMVzxaRKHGuXiBT0U716U+5PF8zdhWK
	 HXEdBUg2W6aI+Hd4cPElXgIBTRd+VmXNcWthNL3CictlgQvFlSiG1ZNAkzq7Ai+Xpm6uV
	 g4Ht3oAHlPqAHcZF36tAmCcpVSaoS25fsSeSg3qvqwa0m6rOrqz2asj0dfXLwaMmA/SVg
	 5MHQY/WptV5VXsyaXd/l44qRNtQq7ggjZtI5XyzqDswDOQNmhBGVYaR5aP3ch0yp0gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=s0XP6uW8MmixUr9jsf8Tb2B/Wg2M26cG7tQ+NNPFLuU=;
	b=BeQDdkXCY8aZpHlaWrc3wA5m5TJsxNzSinvJceCaEaqN/qWEinv7tkUI9SFUdc3eZYnA
	 ZrPVHlBe+DgAgxX6tDgd1U8XMq5VhOZ4klPIC8qbtB7H1Sw9ds0zZmt+/1oWe5PBUakZw
	 LzurYBZNg391fV1rx36elcn41a+HYyA3+ENvZpWeGC4X/Kintx0NPDgicrkTFWoGnt/i8
	 wEmtVzkJ8TU3diVLwb165UUNlwrpeGyb86wFtpVf7ygk4N/H7CVNA/e1TwjZjphRX5Tn8
	 8pACCeQkAlFG8Vg7yQZzC4Kb5Qe8oz74l6T9sYxTJ7388Ifj4tJzcPtWtL7SFl2pAxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+L8aNdd;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD5606A329
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AD5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+L8aNdd
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afbd2c386so549768f8f.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191883; x=1793796683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0XP6uW8MmixUr9jsf8Tb2B/Wg2M26cG7tQ+NNPFLuU=;
        b=f+L8aNddZQEeJdv6b8IJt8lhhCSsElJW3lzvNZM3weSOuWfVzaLUh+YJr4FPGa7oDY
         xyRx5+77beG1ihlm2bCnIgQBIb9HPMkWIExtTPHIpZy55VujxhK+pMTwiGFhesm2xfrM
         EDKJU9r9ojSZrWK9Ym14lMtDl9jnbge0dtYDg4oH2JPbxsV6pdD9CEtnDF9cqZ/P4yjK
         Z1ad3t6wk7cwGblzie1AOWPZHXojyvzLqzw1kywzia/oYXNQE+AmcIz6xstK1m+JziWO
         pK4LzJP+QvfnvzpnOFXZ+MXDHRfZ6vRW8MhnPx++8551Pkvhht8lPgfqnlVz7tCjLcFN
         W8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191883; x=1793796683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0XP6uW8MmixUr9jsf8Tb2B/Wg2M26cG7tQ+NNPFLuU=;
        b=fZMmZbxj7pkqGuG+H1nuRs75kOQw3lbTjTAw3fM+812Mvyzm64aTsxvn99suSZucW2
         7RbUcmdmG6Rb3fZ5V8And+ucq6IuG4C9P1H1Xvrli4NAcYSl6m6Zi5Chmcn8w7/tW5TO
         wncgdyk/VidzClA4Lj0csuYQG+kt76qr7jAW+BFzjSBC7ZszwdzIpbdn9tLTDzX9ps1k
         dq1JRBqlyjJZdwx9bPJxGbMUn1Zh0nsTQpS5JwHO5nhS5BaQJQSFYdWjJ+oNnMSLsd64
         32XWRHUg3YQGPxTx29qx6YQGRtIfHQqjpWMsavZoAwCVduuUYU9yVEa72hMdU08QkSAo
         DJoA==
X-Gm-Message-State: AFq9FYIoEXWzGzamIVz8Z8ek0qqG1vIFdwHXA3ozvGYlsvFCmVXd9ddI
	yAE6loPyIVcuujF/Yirc6WWj676K5d9HfBq821HGiu5cQ19IG+JEa0UB
X-Gm-Gg: AYBFou2/uRBLZB+XsSkOTOAu+DNuS9AaWF124LZ7WyEG0Zg3Jxt97/XV1O/sft6nlJS
	uuKOBl2IKiJbnC7EAUeMeKhIQRtSCAE0UpSgXS0qcWnvCj70Z1yLZl8K1q6kdl1C2WFuA30e6g5
	oCUyPyDfsF3cyOthoi6YRPHqqI4bk1ZgIcZpID7iLZiT+95BX75RnnEurPshQIGpAeTJxMYepdd
	ra1+v0ijk1SC8l/jYV2mqFYjd2Kdya2aP8TgvsbDPXzy+eM4a86uh8l9IoZtSyCdb7dWUoUg+EI
	llc7pnfy0igB5Qihw8x1LjHF90wvmAGygO8GikD655WKvOjDPF+svOuUfaSZuQC+XjtsacrY031
	caufOLBYE9UXMDzRY03Qhi4sn3BS55tJdH3boG2UBEzlpHEzqJPAeuQLveSNWAm2NJYJuTbfDL8
	Xqc2CwKe4gT6vBLZiQD4WQ/wsrDj4YdBKQQ0TRb6QGDgIg18JuCcOMaptKElKr7BQxLo8hDk55j
	eZyek8SgPPxAdz5bS0/WdNXW8ZiWBd3+6XA/fcf0UAA3Nb5yvXHg+vy9QgFw1GIuTy5zDxruHfy
	p5q4GnKKV+tOhMUQcFOWPDoBJVT327hN2XrmGbIPfU3Tdm2wztovUonogdV7kfygHws=
X-Received: by 2002:a5d:5d86:0:b0:48d:dc6f:219a with SMTP id ffacd0b85a97d-48e5d5c8acdmr5836626f8f.27.1793191882643;
        Wed, 28 Oct 2026 05:51:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:21 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:19 +0000
Subject: [PATCH v25 02/11] mmc: renesas_sdhi: Clean up whitespace and add
 OF table sentinels
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-rzg3l_sdhi-v25-2-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=3511;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=ioJxuBexvCNAq5ne1/6uz2TU/X1kO9zeCLe3w5wnhKM=;
 b=gkmbnF3wah90mBQtXFW+AwM0YRLWlrsfuVSECYoDovWyMTVKZKO07fMpRW2npa4SU7kwP6IMH
 o4IcC5VRAZIBwa91q2mqaCv0PdC4gzEBMl4bnTlZhssOKrDaJR/DyiR
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Clean up coding style inconsistencies across the Renesas SDHI host driver
files. Remove redundant internal spacing in the struct definitions and
static initializers to enforce a single space separator or uniform tabs,
aligning the code with standard kernel formatting guidelines.

While at it, add a "Sentinel." comment block to the empty terminating
entries of the Open Firmware (OF) device matching tables to improve
code readability and explicitly mark the table boundaries.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * Restored struct of_default_cfg.
v23->v24:
 * No change.
v22->v23:
 * No change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
v17->v18:
 * Merged patch#4 and #5
 * Updated commit description
 * Annotate the empty sentinel entries in the OF match tables with a
   "Sentinel." comment for clarity.
 * Retained the tag as it is trivial cleanups.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h               | 2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 +++---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index afc36a407c2c..09bf9b24a8c3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -25,7 +25,7 @@ struct renesas_sdhi_scc {
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
+	u32 tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 033d8cd92726..45e0d8f5c64d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -270,8 +270,8 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compat
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
-	.of_data	= &of_data_rza2,
-	.quirks		= &sdhi_quirks_fixed_addr,
+	.of_data = &of_data_rza2,
+	.quirks = &sdhi_quirks_fixed_addr,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
@@ -292,7 +292,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index c7df4da9e865..615bbc86930d 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -88,7 +88,7 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-shmobile" },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 

-- 
2.43.0


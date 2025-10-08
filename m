Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC92BE643
	for <linux-mmc@vger.kernel.org>; Wed,  8 Oct 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897537; cv=none; b=ZvdhxbYpK01iDjIkzx/hoC8hD+2bHoIxeOm9iyDWQGokkNLvt7073eykikIYOWgL4tgMmVh9x8inXg7G24oRzkwBDTVSRVm6Y40RD+4vx0jOoSKs9lakjHiCZyQIYwylvNKIo8zu/XwCacwTDw4SPeHVtEEcOUSRNXLDkpb0BBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897537; c=relaxed/simple;
	bh=D76b8g5MMMam1XG5CeoG+dRqRhsn10Qo6IX3BhaGdcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tseALdnO0nq+rFJEXaNH2XAymLUeeD6kEJ1GdX9GE4SG+OFOgaM3Z+/OMIKjkHcbTWUG42Jf5nmxFBtqGu1lpQk017etXrhRE5wyxPCtvRzFeipuPsqBYRPUIs/dfbUTysSGa1J+nG9Cw2pD54ou8N7OF+nWHZvCeVTATx8j0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qMHa/TXN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qMHa/TXN"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07d4d24d09so1301381866b.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897534; x=1760502334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ9SuUW1UzNO7L8W8R87ast4mEdS/6k2/bbpjsln1KA=;
        b=qMHa/TXN8ASIciEhpmYTr7YPe+zB/Hi5L70iBuruZMTa2P5FF/EA6JxGS8wRNGk1Fz
         zhtp21naDkOWSgf4bO3TKsV9KD9zy4mQWbkEwRebo8226TzxgFRecu2DrFW35BOkr3Ml
         h/SGbe1aUSLtNsrG0wSc4bvtaFSl5tzy7CC8Bw7sv/1B79JBn3j3EyaBb0xbVsHOBS9R
         JHh9cbVDSUDdDDc2lSi76zWlAtdrnSKwu1L8Zv+isJ8HGm40+5EfFevMM98rEQPbQyNQ
         FVvBKuSpziHjlNl6iWMcviEO3zChVrOTd2+TFVP8F8IHUxI+irLRQVfJUumflkD30Hjg
         elaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897534; x=1760502334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ9SuUW1UzNO7L8W8R87ast4mEdS/6k2/bbpjsln1KA=;
        b=ORHD8XKjQ9gHgoaitTxmPwBP9KJNPvI8MjClnTJH+vsjAlGAL/hgsDSUxFTSqWJ31B
         D4O85uAzZw9O4p6Oe9qpZOr+F0XeZRW96BpnJ8GOUDvShc4CpJfClCZyRQHhW55HwWtk
         qH6N4A2bZHOC5mTOBJO58G9+O2q8PjVzKg2Qj/cOQEUchMS091pQzXiAPvDIAtVRULao
         nDiRq2hAQ41LA0IwAgXyoQ4ngXLC7kajxaudKSQUAyE3vxe4JUrmyvNj+99nSypO8H1U
         rsy3dqkYxfAyBl/5pOP9u/hncbUm9BCMddJ9V78zYXhYl/B9AsLLeUoygo1ugG2/RHh1
         3SZg==
X-Forwarded-Encrypted: i=1; AJvYcCWLAfP50nOKDM0RlI/X0KOnoA/3ixJChC/qlzuEcQyrWbyRmkAXwVN0su4DfmUldWtp9kuQKhQzMpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcbcNkWjcvelfO5g6LRuppzTUt2Oo3llIbk84v7KFmR9HGUIP
	AkCsFWNK40Wlw75SFdG7rXXiDm5KNgOkVE0gKG8T9Bbccb7tjL5SGtcRxJkqYjAtUOo=
X-Gm-Gg: ASbGnctQ9isHRSY4AYV9HHICrZkyucra08uWbtcM2ZLu6Ia3DQRgpq7aXx15CnivJAk
	rzB1iPctKgAr4CKqJdbVLK1qh68t7KLobcZRgPotOdBht725/F2+tLGSmDztkVt9CUGYHIDXYwA
	UAZLU5QFBrzAvIhypvEuKJ6GrOVh3bhqSJpZ/cpFQRnj3iaKhbrDtU2d54goqZFTeLaJQwx8/By
	eEhmSXFoGaIpNvTAAK66wqukCrxHZU46aIQPCUFqnt7OUYzBA6n6vYyNgy1ot954bUcIQ6SusEr
	rOdoFpj+yEzhYZ3fICjE+4jOTwUh/OFc9HVy8CNaD/lknWlmxJV2V191EI+VD5WD5UjOYmarDTC
	epi7QulWyIURoES53SkXP7+YctLCY3pquJtjphRAdY8YoKpT3uccJkLjSYc1a1XvpWp/QczhLYS
	k=
X-Google-Smtp-Source: AGHT+IEZSlz/EKrFkQ8tGzGGZjHV3u81jhu2PpcsjCGbnFA9tn7eJ3yvjQACOpvp1GYcqUvP3wSQMQ==
X-Received: by 2002:a17:907:2d8a:b0:b09:2331:f14d with SMTP id a640c23a62f3a-b50acb0e556mr182268866b.64.1759897534049;
        Tue, 07 Oct 2025 21:25:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Wed,  8 Oct 2025 07:25:23 +0300
Message-ID: <20251008042526.3312597-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Deassert the reset signal of the SDHI controller during probe to avoid
relying on the previous bootloaders. Without deasserting the reset signal,
the SDHI controller will not function.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f56fa2cd208d..c4aaf534868c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1103,7 +1103,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->clk_cd))
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
 
-	priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
-- 
2.43.0


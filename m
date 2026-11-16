Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830541;
	b=L9t2jFCz7aY/xOedsgy98nEwVbFHgpjp6MZspTUdUu36xTT3RX8gaMkbNE0ScBs5pgqQ
	 nYT96HTkFnVolmdE6XNZORBkAgEdsu2mmEsH3cKZNF+Fe1J8kUhI24lc6oxU+Xs3V1kOY
	 viksW6XUew3LVWR1Kt+7mc5jKzdEMCfR+Bn3V5X76YrPFuANJPATfyKS2oe1TSANf0Hdb
	 U5LLrAcA7gyzm49Ly+tugCM+WNIX2lerzP62+uOfeW386CzVIx5daqV+kT7hgLYDnCZ4m
	 tHKOi4IodQ0Bguz6JrgevLplUb9JQHNt3tEKDHd2M/17XdO+MuhObulX6xxg0fxgRWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=iplfStI9M5hF0Z2lIf8H96dhVPrsQ0CfwqBgjs+zJ34=;
	b=g3oiLWyb0MhhRTBe+zPssgOECek8ggKzlIgvta6u1Ol+7PpkrGoVeNaSxkuV/PB1Xhkn
	 8t4skgTmBSFO/OVNiGa9iQbu/qSuLO3cj/KD8/HpGLfqwuTCpTlZ31zpQqnyh+/Rq2htu
	 1iDXtUQdSFUY1POkt3/lbB3xi8ls0+P7coZ2wLopuyoA0pD6Y7VnS+n8Z4QST4DJrsmnS
	 pBZoFAaTh+C5f8elVPWENn3VacTD3YuK4PxTuBfY0kARLk5toWFKyK0zhGBcMMvQdnJNW
	 wtykGVTk1yEuYnGtW0VBt7WeU5cam5nFS9kdvOo49SKic/M6UNgl/s6HImFeKWA2tnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C65HUyoC;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2C606A337
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 12:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9E2C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C65HUyoC
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb606491faso9774855e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794830539; x=1795435339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iplfStI9M5hF0Z2lIf8H96dhVPrsQ0CfwqBgjs+zJ34=;
        b=C65HUyoClYYRjsr2ls9c0gCrbCyRx6ggu1XAh5bB8rAdj6XbGTN6AwTxIlJX344Orf
         dVi7GUWmv6PzybtVHweokeV6aA055QK4ROTpgx3zYteIoYkCd+Zr5TzfR1pOsHbgaIdb
         p19w3qrlM7ikJqoCCIyhfIWDiZ/mm8K2ma6n6zBYZ/Nz6/jUJnKdK4Y8qGQWYjciSGBL
         u8KBMmpoJGoRvx65Nfi+of3O8E46J5FwCCYi/P8LLrZ716hZXO4GIJbuHdUGI5s3eg9Y
         QAxpsedyVERSbX0Y9z68uuQYvfx8f9Xx57CMUv1b4mKDDlNINHLKaE3C6Cxgq3PuSzOw
         2ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830539; x=1795435339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iplfStI9M5hF0Z2lIf8H96dhVPrsQ0CfwqBgjs+zJ34=;
        b=m8Xa5tEw8VS9McELo9GPnX5pMhnnI0fpsCUOfYX4ySMZWFj/yMlcEMy+FSS2cJdzNa
         35GHyMpt6wQ79zJpYxY6AoBan5bCH1uphMJR6W5BnqqmPRfgZfOoSMszH3NxOzw1BA4L
         23HtV0jlf4t9LsQInsTyWo/R8dXX1XFRUnK/IOr7gAYR/tdWqz7LLxOBQOgW3jD7B6gT
         bxKbEsqNg6kva+lf57t4T0jJrweM0E8QnIvQznZyoGX/g0NQZjxOVssrSNxKOELvJfI7
         dNqndwXl0DmL8ChmQqQFiTVie/8shVUsbT5pW2ysvuxJNjAaSB3yFesXDm51zN6fGHpK
         mdjg==
X-Gm-Message-State: APuU4Z9tA/+33GWuyi1GFPvGU8WqDFEhfwDqcdDdoP1r1c2mx/ejGrNV
	dW7ud87jAo5J1fj4BhF9BFl5SUx7HlkWK1dFJMj8qMQ+RV05ezheLOsZ
X-Gm-Gg: AYBFou3lb2tYwNUft4+wwollZJ8r4YtcRmi55QddqlGaYCcBSum6CAj8pwlH6aZuAjn
	s+WVgWjktBcaO2WDZi7L811r+3l2nPyad4qnj3sy5Ti8hq6BxTCtOoT3hlWBQ83MVxKq5He4bZB
	vLQ+VnUKwswXfWfPZGoguAZW+dFg9guAbHJfVLYf30exJN8DPrYZLitDtxZf9aaWmhgui2trlEo
	PGo9SUrLb6QCbymfyNPiZCkeg3M7CttNeX+waKQwwHLY/Azc7mjcH1WoK5zd4BQ8hZ+2WL9fLbt
	9jY8IzLXiBAPoPehveoQSQwnTHHw+OK7jpVEReBlHgsz+CVI6p40M3aMZTtuWyPg32sqQ6g5U89
	7gzVGtzh5Aa3Cbg40UkVgqrVTsf28zorJK5vPMLS6McKBo7O95+wDbVIsIdGQXqt/HtCffCGuIv
	VKOvX43dOz6bYqENFp5aCzFLDxTYcgoi4Vpjoby33pOx/m3aQ4I9GScWT60Gt8TI1ZvWeHRSdkv
	AxMVQC9mpZGvq1llqWOz4j8zgd+gStzwN6VWK/gBttajuhqKRHvHlvLR6GyoVYC2xoUnWyj0gD/
	vcpAELKoonO4UhqboTe4+16ieKH88p7QznKvpTc7omomFEdYHn+4pmJKd2GUi1PZFg==
X-Received: by 2002:a05:600c:3f18:b0:4bb:6ac0:6dc0 with SMTP id 5b1f17b1804b1-4bb6ac06e5dmr81251525e9.29.1794830538667;
        Mon, 16 Nov 2026 04:02:18 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm395562805e9.15.2026.11.16.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:02:18 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 16 Nov 2026 12:02:15 +0000
Subject: [PATCH 1/3] mmc: renesas_sdhi: Save and restore IOVS across
 suspend/resume
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
Message-Id: <20261116-sdhi_hs400-v1-1-c5bedd312408@bp.renesas.com>
References: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
In-Reply-To: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794830537; l=2407;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=mRDcKvSH1XEDXyYZNqD0XhICaJN/EeIrHw2EbI+23QA=;
 b=1pnZgYF5a9J+YICA4EW50lPEmtMtBlFnfXR3TurcmjrbuFv6oRMdjukuWxK+4X4xa18Gq9G0w
 ppF2UCBXkfdDuUZJ7S8/rQvg8MTaLrbeJGjh7ri8aLKrpoHdJF1fpRf
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

The SD_STATUS register, specifically the IOVS (I/O Voltage Switch) bit, is
not automatically restored after a suspend/resume cycle, causing the
regulator to report an incorrect voltage on resume.

Fix this by caching the CTL_SD_STATUS register value in the renesas_sdhi
private struct at suspend time and writing it back during resume. The
whole register is saved and restored, as IOVS shares it with other bits.
The save/restore is only performed when a regulator device (rdev) is
present, as the IOVS bit is only relevant in that context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 4f8ed1d8efee..a93e613e9821 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -106,6 +106,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 5e649ef20990..56286431fd2c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1465,6 +1465,15 @@ int renesas_sdhi_suspend(struct device *dev)
 	};
 	int ret;
 
+	if (priv->rdev) {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0)
+			return ret;
+
+		priv->cache_sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
+	}
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -1494,8 +1503,23 @@ int renesas_sdhi_resume(struct device *dev)
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+		goto err_assert;
+
+	if (priv->rdev) {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0)
+			goto err_pm;
+
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
+	}
+
+	return 0;
 
+err_pm:
+	pm_runtime_force_suspend(dev);
+err_assert:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_resume);

-- 
2.43.0


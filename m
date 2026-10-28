Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191893;
	b=kswkFwoiCym6KJxanaWfakzRYyx8YY/ZZ4eZ3zLeiv9rAnvlR5m+kwxUpx9jkoZ28E8C
	 zIrm9X4H8U25WlbTFva5xtd6AIRHjGM2ZR5EPEcoXaA3rdnmJg14CuX9p4WlT7PCJ5Yzr
	 /CeKFmtX7yU9NknuGPDJmupwPH5OtkMsA2QRn24f8c4wGBTT/ePJYm+PAqnRqVndHkP/E
	 W+pZuF7AsD1C/GMeugpS8MOugg6RIYqICm222TwVAGhQN21BAXgpADf1iyFS4mgfnb5Mi
	 sjTXDERp+oique+AOuKX078DCUxauvAda1maX80zKRACkUJpnLlzNVNOVcT9k0mO1MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xoqWy7MO/c6N1qFdA742uHez375d4m56xLpj2LgHpLA=;
	b=CJiUqkKJlxWu+IFzxsglpjxNWELVp+5AHqOyLD0ydMG6UPSPBAPVI4Msfaqo2aq0EJdm
	 5s8oIdeOEsorG7m7/vyMLG0XtmAt+fPqBFm8xfglooeF91bqpQRSqnNUtihzBIDONhZTK
	 KUmrlG6sZ6lPYmehORa/Aya7cClRyAMV41WTnyX8H3mDOibxmTT7D6LfnRz3tgLsKq4sG
	 +yXDtqQtHhKpQ+SXHsCaO/Kt1dJM1XTW7/d9EiaulJlCMPVMaMb1X71oek59P7zTCP9kg
	 U5hP7gshopr372RibIElS1SdOFujUPJhAC0qm0T1mROw97+OeQoJIAOSo2VajFXfZrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlqpEYJY;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AE606A324
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F15AE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlqpEYJY
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so8190525e9.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191891; x=1793796691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xoqWy7MO/c6N1qFdA742uHez375d4m56xLpj2LgHpLA=;
        b=HlqpEYJY6SeU06ZVjmrQxi16ZthOhhVqapCxvG8plybQOMFXdacYpjPCirWx6S/WhV
         06xLJjJphsq1welDkMCCYQ8x1n14sv5suP/3e3s6kxRLzPc635UhxyOtguaV7pMlnt9b
         qEaZnaY1dcdnSxHk81jERJpB8JNJYq++AUKOqJOKI0/94sIhEc6xy0boIKnE7MZ74wlb
         QBnyRwjIrjKI/qgZoRcCddF4V8W/z4+3w4zIcS9+cjd6YW3wBYJrRza/rubCCfCmA6Nq
         iPEX6NLW3C3pShttrghSoks5t/B9WDlR05ooYOElE02svDeSLae+F96GeKGebGJKReaF
         ynkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191891; x=1793796691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xoqWy7MO/c6N1qFdA742uHez375d4m56xLpj2LgHpLA=;
        b=0DhvUyY3VuFr3mpYsgVqpQmt7SEqjcPINvWULGeOsvPfBgIE7dYGkFuTCNVzGdZ61C
         lOJIW27YW5eYLsupcw885Wr6+KWqRD3gW+JUPKpraqUWkxb5noYWpjj+ALS6a7fXklrK
         F5rT6QNJmZgmDcKabigJ9mCHeacuBnmzlm1T8pvXAq8ezISwxSEM0SnNMlQGhDe1CvaE
         Kid1VExFIfz+xjHE7ORlDeaMwWsyuiJ7cIDJYmDPSYXUbCntMQdorS3HtIlHU6EFWxN8
         KI8rrkxEkfQfSm4DI5XRntjl2MlAhSERLtywLYvTv3MQXG0S0RsEFMl/mTIAqnnTtAxL
         PtoQ==
X-Gm-Message-State: AFq9FYJi9sZIzeNYLUAWju6QiojTI+REy9iBlUUk+1cQBVFE5oyPC1Hy
	vdcT/2zKa2e1jAtJp/DSOVgdk8YdlLtuo4HmKJa41RbQ+l16ZR/iXs11
X-Gm-Gg: AYBFou0c4E58ve6ubVkXk9AlPudWvblzFPnyfync5bdvyXb+DFoG1h2lU+lC2lGtUNw
	DTS1+wQMIXn6I7a/7wpUcpcDDBgT/kxHAH1weyT5hjkA+M/lKGaKwGlWAa8PL+4IZjSqzGeb3GV
	edjcgzzteMwDjgiRHjE8D3WQW9IQgVipYPa50glKfm8vfo39T7SPmV8LDfeTCqOU3Zv0Bhu+Eex
	qS3KM1PpavRoflAl8iKIDLhTBb/2RHQEqW6bc4YSwiQYWyP8dtSzaddrDU0ZYRNQ66r7lVAYIhm
	Tm3S6ohjwoez16N0TwziA+WXmmPEn3d4NsYrxWvgGOcWFn2ttW6Mu2S4NAihy5dA6NLGxOTQhB4
	gnW5snAg5WPwwg7SKL84ksKqYBv8+uehR8XY9ioI4h6HGzyCvZYii2ZlD01mNaXhAvCntahwPjD
	tj98K2Mlm214horwqKqfea8wscWRujrQF9/7EDJFbiC4J1u3/aN6zLt8pN35ksX8TyOp3lRCgan
	WZolB/O+GSSXxbU1jzF455mbvBu/9UsOMkLu2Wu8PGSjUDH2g8KH7G7ziNiaYJMawBHq62RRYZn
	PRjN80AWyGTiFow5Eu6IzgcNtAmAyX5G9JfvqEk1TliQ9a64YEvjylvjxLZ/y4hH7Mw=
X-Received: by 2002:a05:600c:3b1e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4a9665870e9mr51619735e9.15.1793191890986;
        Wed, 28 Oct 2026 05:51:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:30 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:26 +0000
Subject: [PATCH v25 09/11] mmc: renesas_sdhi: Add optional axis/axim reset
 controls
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
Message-Id: <20261028-rzg3l_sdhi-v25-9-57f16691c2ed@bp.renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=4251;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=ofWNQQh7eeVtC/0QxqS6eNcmDhEtAhULNqUDYpDf2i8=;
 b=2dB6KGv2VbGSis5Wl9Z9RT5ZJKhkOY9qnEpDRZN3gUjWTX2kjJPuVV1agZhObhLJLBnRJol8P
 qQOj3U6MYJnCurHjqiuoqu4n3rdjZVM0yfMC7WdPgi1puLAPAtFDVIo
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SoC has axis/axim resets compared to other SoCs.

Add two optional reset controls, rstc_axis and rstc_axim, to the
renesas_sdhi struct. Both are acquired at probe time using
devm_reset_control_get_optional_exclusive_deasserted() with the
"axis" and "axim" reset names respectively.

Include them alongside the existing rstc in bulk reset/assert/deassert
operations: triggered together in renesas_sdhi_reset(), and managed
via reset_control_bulk_assert/deassert() in the suspend and resume
paths, replacing the previous single-control calls.

Being optional, these resets are a no-op on platforms that do not
provide them, so existing behaviour is preserved.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * No change.
v23->v24:
 * No change.
v22->v23:
 * No change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * Fixed the ordering of resets in suspend/resume paths.
V18->v19:
 * No change.
v17->v18:
 * Fixed ordering of reset in renesas_sdhi_reset().
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 3c991f6b988b..4f8ed1d8efee 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -102,6 +102,8 @@ struct renesas_sdhi {
 	unsigned int tap_set;
 
 	struct reset_control *rstc;
+	struct reset_control *rstc_axis;
+	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
 };
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 3a1a558bc98c..e897328d5b70 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -632,6 +632,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 				sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
 
 			reset_control_reset(priv->rstc);
+			reset_control_reset(priv->rstc_axim);
+			reset_control_reset(priv->rstc_axis);
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 					  false, priv->rstc);
@@ -1151,6 +1153,14 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
+	priv->rstc_axim = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, "axim");
+	if (IS_ERR(priv->rstc_axim))
+		return PTR_ERR(priv->rstc_axim);
+
+	priv->rstc_axis = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, "axis");
+	if (IS_ERR(priv->rstc_axis))
+		return PTR_ERR(priv->rstc_axis);
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
@@ -1404,13 +1414,18 @@ int renesas_sdhi_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = priv->rstc_axis },
+		{ .rstc = priv->rstc_axim },
+		{ .rstc = priv->rstc },
+	};
 	int ret;
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
 
-	ret = reset_control_assert(priv->rstc);
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		pm_runtime_force_resume(dev);
 
@@ -1422,15 +1437,20 @@ int renesas_sdhi_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = priv->rstc_axis },
+		{ .rstc = priv->rstc_axim },
+		{ .rstc = priv->rstc },
+	};
 	int ret;
 
-	ret = reset_control_deassert(priv->rstc);
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		return ret;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-		reset_control_assert(priv->rstc);
+		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 
 	return ret;
 }

-- 
2.43.0


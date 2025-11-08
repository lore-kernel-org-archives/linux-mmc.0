Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7A28725A
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643604; cv=none; b=oG3XFCCFNF/Yss+K+yiTPo9jMHkqIHEWYf43/VigZNcWvCTHyM9vDhVMh8TW4XXGlSyqb6rdxLP3+vgOwPmIXgjzMhTo7D3a0wiebPkFXa0Vnd6aLg9QkWZNN0BxGLCysa+vIRszRLKLSME15wiHaBJhkiwu75/FgpZ2iyvaG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643604; c=relaxed/simple;
	bh=Uyhvca88h8vv2OXwxtdsVNrGpi7PUq2+kDeHdZ0oXjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIYfeCrhVPYN8sVhcWJx0T4PegGChiMahiMCOrbJmCE/5lf/4KSFCSn/RiYdHtkVBVY5eyIHbbejQNzUQ+OdEfskuRoLfX3BSDmN+8iWkm/dWCk8A4+5WKATmP+dWl3dZ2SkxjIqFICuCRv5c9RmaXnHk3Bj7RKUmHjMrCPJfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LhincJ8Y; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LhincJ8Y"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2948044a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643601; x=1763248401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIdZxomTiawbxwfqpMnoqPSizZxwJiiryInuVxUgs40=;
        b=LhincJ8YrW4cCa30JjkSAPa35E4wQOBqvdpYZMKBXXyxaOrlHCo0o2FqDamTx/vsnr
         d3BvE7Mbcp+kE/2Rqo9MLjtmq5s1WmCrBZl92s2nFbezuugFsi5V/Uqn6JetG4MnXLaX
         8dWq/MZw7fdpv1x05TidydU0F1c9Phra6Gk8Kjhx39bCROPz8xl+Bn9yfOj5cN2UUyCg
         Ahl43oQoBlTIUHK+XdSvujFUfjk2QiPIIChUlSiS4e0taQGYEmizcRkT/3YM3J2q0wWL
         Q2CotD6XmMEPwsEGv/58RfuUkso2qA7V7TiRTXecVO/BOekBb2cbjvb20sUi4MOvDe98
         42aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643601; x=1763248401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OIdZxomTiawbxwfqpMnoqPSizZxwJiiryInuVxUgs40=;
        b=QZnbRDet6r9SoiF70g7tDm14f+z955iZ4F3xQnD3SEpgHmxptVKr2iI4iVXy6EKy4I
         rFj0+KjsBB35J9zUzE2Fn1V5vtBRnc/gbtmEEK40EiEsYeaM15NuuL2pLe+9D0O+iZOW
         CLe3bewzHV7Y56Nz4Oj/pvOAdHkDeIHkMN/vjyAykz/P98JtWV3xp/eXgWlTBiiG+Ec8
         r9EAdlnPJ1P5zjiVbjKfmCmbawCn5HVtrM8RmzUHYCZxnzQQyznmWkkJ2JbYnsqvteq4
         b/WBOaSQxxEZlM/wML87yetYyxX5XVk+76CYEeJYjHAiBRvZCDRtGRhiVegLGgemwR1v
         RBLg==
X-Forwarded-Encrypted: i=1; AJvYcCXfc4YCywE4p0hbKqO/aXrExsA6tlgqHGXP4EzjoD7oiNJ8CIaDuDhoUcDqxYnbmEy1eUdrQQMdFOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4s23vZXvwNbmUX6vEM+af/+oe2cvZ6D+ADegMdLkVTICqtTaK
	ws/KXM9/vXoHsup7VAFhdSQMn+W2HKQ5ejba5+f+NNIxZfZQuRtYf40F
X-Gm-Gg: ASbGnctxMvtLW8u7Ln//lopit56vyxyIE4+SAmCOhDhQj/95OYmd2FyckYmqIQcD22L
	1aUKQUl4pMioBtRLtqiBuBAKShnDDYaVrUCU30eKGQXm4Ho7OfbYUQHRVS39P5pHpS+yuY76Xjm
	iANr9xdBZR8szS8tH6gUHGBo0UdEdr/rOU5HyuR+2kdK4pe4KKQuUbYmizaWDGF+KoRBFL9XSiY
	LGvriGCNCSLUGsjtmrj9CbbpS387x1xljqs9dYaQF9qo/4jHawTp3SU1Ot4v3usxUZi0CZN3ZjL
	U4iwANV+O9Q8OlKmoyyqPpl40gVvu70tSa3TF3VRdiYDWVRlmqFkAVIMVWrpR4XF6btWpdkv4iv
	/VG/tRvOSdkBhr7v4C7B475XRIFpJwA8LX+I8d9jrdl2FkpvJZimFWFQygYnej4Niq7CfqS/vlg
	yp6hZsmLUiptwn/IHkD7/TyU7EdmkKSeCZgZvLSMOBtv+Xv6okvPYQ0qZdhfY8C7ALk7fy1UmIH
	noLuRVtdzgQzQFcrQZRX5cz+l0fBx1B
X-Google-Smtp-Source: AGHT+IFQjlRv39XcJklWKjtg5/kXtIXi7GGXYRLVU3hdPD9cbN+MwifNhIboaa4CWjMgje18D1/dkg==
X-Received: by 2002:a05:6402:2106:b0:640:8eed:5601 with SMTP id 4fb4d7f45d1cf-6415e104231mr2993008a12.2.1762643600704;
        Sat, 08 Nov 2025 15:13:20 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:19 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/7] mmc: meson-mx-sdio: Use devm_clk_get_enabled()
Date: Sun,  9 Nov 2025 00:12:48 +0100
Message-ID: <20251108231253.1641927-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies the code. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 2448f21bd683..1159cc911359 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -103,7 +103,6 @@ struct meson_mx_mmc_host {
 	struct device			*controller_dev;
 
 	struct clk			*parent_clk;
-	struct clk			*core_clk;
 	struct clk_divider		cfg_div;
 	struct clk			*cfg_div_clk;
 	struct clk_fixed_factor		fixed_factor;
@@ -627,6 +626,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	struct platform_device *slot_pdev;
 	struct mmc_host *mmc;
 	struct meson_mx_mmc_host *host;
+	struct clk *core_clk;
 	void __iomem *base;
 	int ret, irq;
 	u32 conf;
@@ -676,9 +676,9 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_mmc;
 
-	host->core_clk = devm_clk_get(host->controller_dev, "core");
-	if (IS_ERR(host->core_clk)) {
-		ret = PTR_ERR(host->core_clk);
+	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
+	if (IS_ERR(core_clk)) {
+		ret = PTR_ERR(core_clk);
 		goto error_free_mmc;
 	}
 
@@ -692,16 +692,10 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_mmc;
 
-	ret = clk_prepare_enable(host->core_clk);
-	if (ret) {
-		dev_err(host->controller_dev, "Failed to enable core clock\n");
-		goto error_free_mmc;
-	}
-
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
 		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
-		goto error_disable_core_clk;
+		goto error_free_mmc;
 	}
 
 	conf = 0;
@@ -715,14 +709,12 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 	ret = meson_mx_mmc_add_host(host);
 	if (ret)
-		goto error_disable_clks;
+		goto error_disable_div_clk;
 
 	return 0;
 
-error_disable_clks:
+error_disable_div_clk:
 	clk_disable_unprepare(host->cfg_div_clk);
-error_disable_core_clk:
-	clk_disable_unprepare(host->core_clk);
 error_free_mmc:
 	mmc_free_host(mmc);
 error_unregister_slot_pdev:
@@ -742,7 +734,6 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
 	of_platform_device_destroy(slot_dev, NULL);
 
 	clk_disable_unprepare(host->cfg_div_clk);
-	clk_disable_unprepare(host->core_clk);
 
 	mmc_free_host(host->mmc);
 }
-- 
2.51.2


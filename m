Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06C17B50F
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007253; cv=none; b=Kr2iXlzDk0HutA86+gW5Cytbs+B6VBsDDGaULYfwOsatnsJk4czqo2WCV5KpIep3nZKalcavvJ7cro5BhI2PJwPQcERnqGgnNCLGfrw6yO4+Lgq/W8D4c9Bu4kZIR9gEYibRjvHOoGA9brpa9ao3vfDRMxUh/c1/jh41MoMn7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007253; c=relaxed/simple;
	bh=0/BepdELP0Zi3ioZhdhtHC86o8Zd3dXLZIGFVfkzQ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND4KBBwqpYN9j73BLTNJzSi3kgRp+85iHBaLVj2HNgDDgMUNgvFJzPz2d6heOHSVkgI4QbJtAtZTd9CbUcPF/Z/xd6jHs0uno5NsFCLg323DEtMBtO211fFSODG7KXN7XFRpxWJizdOORK/JWKl5SIqfXSIojGzBHMAQt1jjMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMzL0o8Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMzL0o8Q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775895d69cso23982055e9.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 17:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007250; x=1768612050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mRvqRARBlLlFVSu4cS3ROES8gW2l+6tv55cSmtfsrs=;
        b=cMzL0o8Q+YFgXI/e0vW/qdOkCmkn6ai2G4HHdz+TsNe3HuLT2VnmcLZBWwvmNsBrXR
         ompffJpiC0K13Kbc6naKsvgtiPjwYv7o4+KfxdN6AHlMJVOgsYCwsuQ5FGWAW5S4N2zt
         26xlgFa9sLHLdey8M0mKOKpTkEbZ55HD72iHPiDodETFVB89upo5rdFASK4cRyUFwbdU
         0yfL37GucVNnu6reoTho17NIKbrQzdL/aUXkUrfO5QrBGVMPNdU3axad4Pew2ibYvDv0
         eaLiprGC0x9D9cS7HfJkl2Fg2yZl9zwvo9ZalC8XPGRWZ6JoEVmArNUZNX8yV5GEB0Fn
         /PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007250; x=1768612050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mRvqRARBlLlFVSu4cS3ROES8gW2l+6tv55cSmtfsrs=;
        b=juvGAUGZc2nzst52uGQv9Zni5uVLA7AGF+g0W+R+MZFp9xDjBgMvf3M/e8hJBDVSos
         rIt/6Vt7mu3zObPXo16/lzzmvNlGHmCGZ2Zb/mS8hFXHwaXL+tqAaGLpAQ1F7epB2wRX
         iZu+dEKNEtERh/r2cPjrW6vwu8E44KAQwXxSomTWMD8cTDvbGEf+/hF627Ulj2iH7Mro
         crNIjohbEc3QyguEDt5A9fVAU+JPfYeQaUJb2aB5hiqkXXISzbSq9RkqcHaScSLIxciC
         8ulpDAqHz+oL4OQ9RioA2zWZwkOFbrJjgPRyyKY36qYjJ1ZFhew2/2S1GxIGroyuKXUY
         OWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2x7iPFeexDvzFEZRpUTzSkWuoMKAURKU1IjZgUjIxPNYiKlabj2XbnZxhq4+A4V0y6Cp6yXE+SGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywza/xAPMWulrPdTS9cER4jEFW7MscaLQ6JQhZ2ds/XESSryJPT
	3rjOhfwsMnC0CSRxqIPtZ19xcNH9M+52zx0idwBxJKlLyAPJeFsWczTy9CKdLI8c
X-Gm-Gg: AY/fxX5qPe6hz4aYHGPjfUjqvC3r5b5ykooWqTATxsRoL9bw/UM7iiRwFDT/1lQLIGo
	l8QlwluF0Mq+AgdCOM3KJFsUW9V8GRHpay8XunH1okFHZhRYsBN15wDipKJe4BLcjG3eZW1LG+W
	JqO1QLBt3olJv4tQapZ52dHBmaetiwcJIComwjylpbYIbFmVCaxLP6oLwNANDbjA5uqoVhqDYM3
	LpUSHnMOEHUROCsLMCgUnKl8NjY2H6sZmR8xpHSEMzYLAkJFeeT2/dYLm/OdZff+COACSXpv8Yt
	ElInt3RtbNnOEpPyDtF0P3OLy2iMxiLoXR5V1Jd2qra8y3JugOrLnuJB8D/W0ZNKdkf3NfCNv7C
	UsSZJ/G8BL5TI2wUfT4557AU6I+3ZpXpUFyhVpH923kvPV2HV9SLroB75ggzFwqZDH0SUE/HVGa
	vV1CBQEh0v+poKLYp3ZWjtO1x04i07tQd/aSLbwzHfy6NYpKuhaPE0+GmXTD5KruTPqGquDv3Bm
	jLJSxw=
X-Google-Smtp-Source: AGHT+IEruxoVLQw+uvAQdMicgfFRe8XyeFbrLqGms3k4V0pLxVUBHW1PFuUJeUnVq2ysNptvW2pOWA==
X-Received: by 2002:a05:600c:83c7:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-47d84b52e31mr128613185e9.36.1768007250459;
        Fri, 09 Jan 2026 17:07:30 -0800 (PST)
Received: from stor1.home.marco.cx (ip-178-202-227-016.um47.pools.vodafone-ip.de. [178.202.227.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm71779475e9.8.2026.01.09.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 17:07:30 -0800 (PST)
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: heiko@sntech.de,
	ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marco Schirrmeister <mschirrmeister@gmail.com>
Subject: [PATCH v1 2/3] mmc: host: dw_mmc-rockchip: add rockchip,disable-runtime-pm quirk
Date: Sat, 10 Jan 2026 02:07:14 +0100
Message-ID: <20260110010715.1610159-3-mschirrmeister@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110010715.1610159-1-mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FriendlyElec NanoPi R76S (based on the Rockchip RK3576) suffers from 
a persistent bus-reset loop on the microSD (dw_mmc) interface during 
idle periods. When the microSD controller enters runtime-suspend, the 
subsequent transition back to an active state causes the bus timing to 
become unstable. This forces the driver to drop the bus speed to 400kHz 
to perform a full retraining of the SDR104 link.

Investigations using the runtime_status interface confirm that 
preventing the controller from entering a low-power state stabilizes 
the link and eliminates the reset loop entirely.

This patch introduces a new 'rockchip,disable-runtime-pm' Boolean 
property to the dw_mmc-rockchip driver. The property is used to:

- Bypass the 50ms autosuspend delay during the probe sequence.
- Explicitly increment the device usage count via pm_runtime_get_noresume()
  to keep the controller active and prevent it from being suspended 
  during idle periods.

Signed-off-by: Marco Schirrmeister <mschirrmeister@gmail.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 62c68cda1e21..d3e5c06d80ef 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -538,6 +538,7 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
+	bool disable_rpm = of_property_read_bool(pdev->dev.of_node, "rockchip,disable-runtime-pm");
 	int ret;
 
 	if (!pdev->dev.of_node)
@@ -549,8 +550,13 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_use_autosuspend(&pdev->dev);
+
+	/* Only setup autosuspend if the DTS hasn't prohibited it */
+	if (!disable_rpm) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+		pm_runtime_use_autosuspend(&pdev->dev);
+	}
+
 
 	ret = dw_mci_pltfm_register(pdev, drv_data);
 	if (ret) {
@@ -560,7 +566,20 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	/*
+	 * For boards with sensitive signaling like the RK3576-based NanoPi R76S,
+	 * we inhibit runtime PM to prevent bus resets during idle transitions.
+	 */
+	if (disable_rpm) {
+		/*
+		 * Instead of nuclear option (pm_runtime_forbid), we use
+		 * the "soft" way by incrementing the usage count to
+		 * prevent the controller from ever hitting runtime_suspend.
+		 */
+		pm_runtime_get_noresume(&pdev->dev);
+	} else {
+		pm_runtime_put_autosuspend(&pdev->dev);
+	}
 
 	return 0;
 }
-- 
2.52.0

